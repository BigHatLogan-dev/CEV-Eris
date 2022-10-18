PROCESSING_SUBSYSTEM_DEF(internal_wounds)
	name = "Internal Wounds"
	priority = 101 // Fires before mob Life()
	flags = SS_KEEP_TIMING|SS_NO_INIT
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	wait = 2 SECONDS			// SSinternal_organs will call this when implemented. For now, it has the same tick as Life().
	process_proc = null     	// We're gonna use components instead of calling procs

/datum/controller/subsystem/processing/internal_wounds/fire(resumed = FALSE)
	if(!resumed)
		currentrun = processing.Copy()

	// Supposedly this makes it faster (before this: 8ms|33%(23%)|0 P:194)
	var/list/current_run = currentrun

	for(var/datum/component/internal_wound/IW in current_run)
		var/obj/item/organ/O = IW.parent

		if(!O)
			processing -= IW
			continue

		var/obj/item/organ/external/E = O.parent
		var/mob/living/carbon/human/H = O.owner

		// Doesn't need to be inside someone to get worse
		if(IW.can_progress)
			++IW.current_tick
			if(IW.current_tick >= IW.progression_threshold)
				IW.current_tick = 0
				progress(IW)

		if(!H)
			continue

		// Chemical treatment handling
		var/is_treated = FALSE
		var/list/owner_ce = H.chem_effects
		if(owner_ce && owner_ce.len)
			for(var/chem_effect in owner_ce)
				is_treated = IW.try_treatment(TREATMENT_CHEM, chem_effect, owner_ce[chem_effect])
		if(is_treated)
			continue

		// Spread once
		if(IW.can_spread)
			if(IW.severity == IW.spread_threshold)
				var/list/internal_organs_sans_parent = H.internal_organs.Copy() - O
				var/obj/item/organ/next_organ = pick(internal_organs_sans_parent)
				SEND_SIGNAL(next_organ, COMSIG_I_ORGAN_ADD_WOUND, IW.type)

		// Deal damage
		if(E)
			H.apply_damages(null, null, IW.tox_damage, IW.oxy_damage, IW.clone_damage, IW.hal_damage, E)

		if(IW.psy_damage)
			H.apply_damage(IW.psy_damage * IW.severity, PSY)

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
