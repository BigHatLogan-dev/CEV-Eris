/datum/component/internal_wound
	var/name = "internal injury"
	dupe_mode = COMPONENT_DUPE_UNIQUE

	var/list/treatments = list()	// list(QUALITY_TOOL = FAILCHANCE, CE_CHEMEFFECT = strength), surgery steps have their own treatment defines
	var/scar						// If defined, applies this wound type when successfully treated

	var/diagnosis_stat				// BIO for organic, MEC for robotic
	var/diagnosis_difficulty		// basic - 25, adv - 40

	var/severity					// How much the wound contributes to internal organ damage
	var/severity_max = 2			// How far the wound can progress, default is 2

	var/can_progress = FALSE			// Whether the wound can progress or not
	var/next_wound						// If defined, applies a wound of this type when severity is at max
	var/progression_threshold = 150		// How many ticks until the wound progresses, default is 5 minutes
	var/current_tick					// Current tick towards progression

	var/can_spread = FALSE			// Whether the wound can spread throughout the body or not
	var/spread_threshold = 0		// Severity at which the wound spreads a single time

	var/wound_nature				// Make sure we don't apply organic wounds to robotic organs and vice versa

	// Damage applied to mob each process tick
	// Note: brute and burn are not applied because they are abstracted as internal wounds
	var/hal_damage
	var/oxy_damage
	var/tox_damage
	var/clone_damage
	var/psy_damage		// Not the same as sanity damage

	// Organ adjustments - preferably used for more severe wounds
	var/specific_organ_size_multiplier = null
	var/max_blood_storage_multiplier = null
	var/blood_req_multiplier = null
	var/nutriment_req_multiplier = null
	var/oxygen_req_multiplier = null

/datum/component/internal_wound/RegisterWithParent()
	RegisterSignal(parent, COMSIG_WOUND_EFFECTS, .proc/apply_effects)
	RegisterSignal(parent, COMSIG_WOUND_DAMAGE, .proc/apply_damage)
	RegisterSignal(src, COMSIG_ATTACKBY, .proc/apply_tool)

/datum/component/internal_wound/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_WOUND_EFFECTS)
	UnregisterSignal(parent, COMSIG_WOUND_DAMAGE)
	UnregisterSignal(src, COMSIG_ATTACKBY)

/datum/component/internal_wound/proc/apply_tool(obj/item/I, mob/user)
	var/success = FALSE

	if(!I.tool_qualities || !I.tool_qualities.len)
		success = try_treatment(I.type, 1, TRUE)
	else
		for(var/tool_quality in I.tool_qualities)
			var/quality_and_stat_level = I.tool_qualities[tool_quality] + user.stats.getStat(diagnosis_stat)
			if(try_treatment(tool_quality, quality_and_stat_level, TRUE))
				success = TRUE
				break
	
	if(user)
		if(success)
			to_chat(user, SPAN_NOTICE("You successfully treat \the [parent] with \the [I]."))
		else
			to_chat(user, SPAN_WARNING("You failed to treat \the [parent] with \the [I]."))

/datum/component/internal_wound/proc/try_treatment(type, magnitude, used_tool = FALSE)
	if(treatments.Find(type))
		if(magnitude >= treatments[type])
			treatment(used_tool)
			return TRUE
	return FALSE

/datum/component/internal_wound/proc/treatment(used_tool)
	if(severity > 0 && !used_tool)
		--severity
		can_progress = initial(can_progress)	// If it was turned off by reaching the max, turn it on again.
	else
		if(scar && ispath(scar, /datum/component))
			SEND_SIGNAL(parent, COMSIG_I_ORGAN_ADD_WOUND, scar)
		qdel(src)

/datum/component/internal_wound/proc/apply_effects()
	var/obj/item/organ/internal/O = parent

	if(specific_organ_size_multiplier)
		O.specific_organ_size *= 1 - round(specific_organ_size_multiplier, 0.01)
	if(max_blood_storage_multiplier)
		O.max_blood_storage *= 1 + round(max_blood_storage_multiplier, 0.01)
	if(blood_req_multiplier)
		O.blood_req *= 1 - round(blood_req_multiplier, 0.01)
	if(nutriment_req_multiplier)
		O.nutriment_req *= 1 - round(nutriment_req_multiplier, 0.01)
	if(oxygen_req_multiplier)
		O.oxygen_req *= 1 - round(oxygen_req_multiplier, 0.01)

/datum/component/internal_wound/proc/apply_damage()
	var/obj/item/organ/internal/O = parent

	if(severity)
		O.damage += severity
