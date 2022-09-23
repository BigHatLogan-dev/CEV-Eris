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

	var/list/organ_types = list()		// Make sure we don't apply organic wounds to robotic organs and vice versa

	// Damage applied each process tick
	var/hal_damage
	var/oxy_damage
	var/tox_damage
	var/brute_damage
	var/burn_damage
	var/clone_damage
	var/psy_damage

	// Organ adjustments - preferably used for more severe wounds
	var/specific_organ_size_multiplier = null
	var/max_blood_storage_multiplier = null
	var/blood_req_multiplier = null
	var/nutriment_req_multiplier = null
	var/oxygen_req_multiplier = null

/datum/component/internal_wound/RegisterWithParent()
	RegisterSignal(parent, COMSIG_WOUND_PROCESS, .proc/process)
	RegisterSignal(parent, COMSIG_WOUND_EFFECTS, .proc/apply_effects)
	RegisterSignal(parent, COMSIG_WOUND_TREAT, .proc/try_treatment)
	RegisterSignal(parent, COMSIG_WOUND_DAMAGE, .proc/apply_damage)
	RegisterSignal(parent, COMSIG_ATTACKBY, .proc/apply_tool)

/datum/component/internal_wound/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_WOUND_PROCESS)
	UnregisterSignal(parent, COMSIG_WOUND_EFFECTS)
	UnregisterSignal(parent, COMSIG_WOUND_TREAT)
	UnregisterSignal(parent, COMSIG_WOUND_DAMAGE)
	UnregisterSignal(parent, COMSIG_ATTACKBY)

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
		UnregisterFromParent()
		if(scar && ispath(scar, /datum/component))
			parent.AddComponent(scar)

/datum/component/internal_wound/proc/progress()
	if(!can_progress)
		return

	if(severity < severity_max)
		++severity
	else
		can_progress = FALSE
		if(next_wound && ispath(next_wound, /datum/component))
			var/chosen_wound_type = pick(typesof(next_wound))
			parent.AddComponent(chosen_wound_type)

/datum/component/internal_wound/proc/process()
	var/obj/item/organ/O = parent
	var/mob/living/carbon/human/H = O.owner

	// Doesn't need to be inside someone to get worse
	if(can_progress)
		++current_tick
		if(current_tick >= progression_threshold)
			current_tick = 0
			progress()
			O.refresh_upgrades()

	if(!H)
		return

	var/sanity_damage = hal_damage + brute_damage + burn_damage + oxy_damage + tox_damage + clone_damage

	if(hal_damage)
		H.adjustHalLoss(hal_damage * severity)
	if(oxy_damage)
		H.adjustOxyLoss(oxy_damage * severity)
	if(tox_damage)
		H.adjustToxLoss(tox_damage * severity)
	if(brute_damage)
		H.adjustBruteLoss(brute_damage * severity)
	if(burn_damage)
		H.adjustFireLoss(burn_damage * severity)
	if(clone_damage)
		H.adjustCloneLoss(clone_damage * severity)
	if(psy_damage)
		H.sanity.onPsyDamage(psy_damage * severity)
	if(sanity_damage)
		H.sanity.onDamage(sanity_damage * severity)

	if(prob(2) && H.analgesic < 20 * severity)
		var/obj/item/organ/external/E = O.parent
		H.custom_pain("You feel a sharp pain in your [E.name]", 1)

	if(H.chem_effects && H.chem_effects.len)
		for(var/chem_effect in H.chem_effects)
			try_treatment(chem_effect, H.chem_effects[chem_effect])

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
