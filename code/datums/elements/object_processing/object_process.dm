// Simple object processing (not Process()) behavior
// Arg format: list(processing_verb, list(new reagent ids = amount), list(new matter = amount))
/datum/element/object_process
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

/datum/element/object_process/proc/do_object_process(datum/source_ref, atom/target, list/arguments)
	SIGNAL_HANDLER
	var/process_verb = arguments[1]
	var/list/reagent_ids_to_add = arguments[2]
	var/list/new_matter = arguments[3]

	if(process_verb)
		target.name = "[arguments[1]] " + initial(target.name)
		target.icon_state = initial(target.icon_state) + "-[arguments[1]]"
	if(islist(reagent_ids_to_add))
		var/datum/reagents/R
		if(target.reagents)
			R = target.reagents
		else
			R = new /datum/reagents
			target.reagents = R
		R.clear_reagents()
		for(var/id in reagent_ids_to_add)
			R.add_reagent(id, reagent_ids_to_add[id])
	if(islist(new_matter) && isobj(target))
		var/obj/O = target
		LAZYINITLIST(O.matter)
		var/list/target_matter = O.matter
		LAZYCLEARLIST(target_matter)
		LAZYADD(target_matter, new_matter)

	return CUD_QDEL_COMPONENT
