PROCESSING_SUBSYSTEM_DEF(internal_wounds)
	name = "Internal Wounds"
	priority = 101 // Fires before mob Life()
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	wait = 2 SECONDS			// SSinternal_organs will call this when implemented. For now, it has the same tick as Life().
	process_proc = null     	// We're gonna use components instead of calling procs
	var/datum/entity_component_map/organ_map	// Will be passed in by SSinternal_organ_manager in the future

/datum/controller/subsystem/processing/internal_wounds/Initialize()
	organ_map = new /datum/entity_component_map
	..()

/datum/controller/subsystem/processing/internal_wounds/fire(resumed = FALSE)
	if(!resumed)
		currentrun = processing.Copy()

	for(var/obj/item/organ/O in currentrun)
		var/list/datum/component/internal_wound/wound_list = O.GetComponents(/datum/component/internal_wound)
		//var/datum/component/internal_organ = O.GetComponents(/datum/component/internal_organ)
		var/obj/item/organ/external/E = O.parent
		var/mob/living/carbon/human/H = O.owner

		if(!wound_list || !wound_list.len)
			processing.Remove(O)
			continue

		for(var/datum/component/internal_wound/IW in wound_list)
			// Doesn't need to be inside someone to get worse
			if(IW.can_progress)
				++IW.current_tick
				if(IW.current_tick >= IW.progression_threshold)
					IW.current_tick = 0
					progress(IW)

			if(!H)
				return

			// When organs and mobs are systemized/componentized, these should be moved to a relevant subsytem

			// Chemical treatment handling
			var/is_treated = FALSE
			if(H.chem_effects && H.chem_effects.len)
				for(var/chem_effect in H.chem_effects)
					is_treated = IW.try_treatment(chem_effect, H.chem_effects[chem_effect])
			if(is_treated)
				continue

			// Spread once
			if(IW.can_spread)
				if(IW.severity == IW.spread_threshold)
					var/list/internal_organs_sans_parent = H.internal_organs.Copy() - O
					var/obj/item/organ/next_organ = pick(internal_organs_sans_parent)
					SEND_SIGNAL(next_organ, COMSIG_I_ORGAN_ADD_WOUND, IW.type)

			// Deal damage
			H.apply_damages(null, null, IW.tox_damage, IW.oxy_damage, IW.clone_damage, IW.hal_damage, E)

			if(IW.psy_damage)
				H.apply_damage(IW.psy_damage * IW.severity, PSY)

			// Notify owner of wound(s)
			if(prob(2) && H.analgesic < 25 * IW.severity)
				H.custom_pain("You feel a sharp pain in your [E.name]", 1)

/datum/controller/subsystem/processing/internal_wounds/proc/progress(datum/component/internal_wound/IW)
	if(!IW.can_progress)
		return

	if(IW.severity < IW.severity_max)
		++IW.severity
	else
		IW.can_progress = FALSE
		if(IW.next_wound && ispath(IW.next_wound, /datum/component))
			var/chosen_wound_type = pick(typesof(IW.next_wound))
			SEND_SIGNAL(IW.parent, COMSIG_I_ORGAN_ADD_WOUND, chosen_wound_type)

	SEND_SIGNAL(IW.parent, COMSIG_I_ORGAN_REFRESH)
