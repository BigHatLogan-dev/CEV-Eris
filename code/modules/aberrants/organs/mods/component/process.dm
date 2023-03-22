/datum/component/modification/organ/process
	exclusive_type = /obj/item/modification/organ/internal/process
	adjustable = TRUE
	trigger_signal = COMSIG_ABERRANT_PROCESS

/datum/component/modification/organ/process/modify()
	specific_organ_size_flat_mod = 0
	max_blood_storage_flat_mod = 0
	blood_req_flat_mod = 0
	nutriment_req_flat_mod = 0
	oxygen_req_flat_mod = 0

	var/list/possibilities = ALL_STANDARD_ORGAN_EFFICIENCIES

	for(var/organ in organ_efficiency_flat_mod)
		if(LAZYLEN(organ_efficiency_flat_mod) > 1)
			for(var/organ_eff in possibilities)
				if(organ != organ_eff && LAZYFIND(organ_efficiency_flat_mod, organ_eff))
					LAZYREMOVE(possibilities, organ_eff)

		var/decision = input("Choose an organ type (current: [organ])","Adjusting Organoid") as null|anything in possibilities
		if(!decision)
			decision = organ

		var/list/organ_stats = ALL_ORGAN_STATS[decision]
		var/modifier = round(organ_efficiency_flat_mod[organ] / 100, 0.01)

		if(!modifier)
			return

		LAZYREMOVE(organ_efficiency_flat_mod, organ)
		LAZYADD(organ_efficiency_flat_mod, decision)
		organ_efficiency_flat_mod[decision] = round(organ_stats[1] * modifier, 1)
		specific_organ_size_flat_mod 		+= round(organ_stats[2] * modifier, 0.01)
		max_blood_storage_flat_mod			+= round(organ_stats[3] * modifier, 1)
		blood_req_flat_mod 					+= round(organ_stats[4] * modifier, 0.01)
		nutriment_req_flat_mod 				+= round(organ_stats[5] * modifier, 0.01)
		oxygen_req_flat_mod 				+= round(organ_stats[6] * modifier, 0.01)

/datum/component/modification/organ/process/multiplier
	var/multiplier

/datum/component/modification/organ/process/multiplier/get_function_info()
	var/is_positive = (multiplier > 0)

	var/description = "<span style='color:orange'>Functional information (processing):</span> [is_positive ? "amplifies" : "reduces"] output"
	description += "\n<span style='color:orange'>Output change:</span> [is_positive ? "+" : "-"][multiplier * 100]%"

	return description

/datum/component/modification/organ/process/multiplier/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input)
		return

	if(LAZYLEN(input))
		for(var/element in input)
			input[element] *= 1 + multiplier

		SEND_SIGNAL_OLD(holder, COMSIG_ABERRANT_OUTPUT, holder, owner, input)


/datum/component/modification/organ/process/map
	adjustable = TRUE
	var/mode = "normal"

/datum/component/modification/organ/process/map/get_function_info()
	var/description = "<span style='color:orange'>Functional information (processing):</span> connects inputs to outputs"
	description += "\n<span style='color:orange'>Mode:</span> [mode]"

	return description

/*	Multi-input aberrant organs are still supported, but not present in-game
/datum/component/modification/organ/process/map/modify()
	var/list/adjustable_qualities = list("normal", "random")

	var/decision = input("Choose an input to output mapping mode","Adjusting Organoid") as null|anything in adjustable_qualities
	if(!decision)
		return

	mode = decision
*/

/datum/component/modification/organ/process/map/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input || !input.len)
		return

	var/list/shuffled_input = list()
	var/list/packet_order = list()

	if(mode == "random")
		for(var/i in 1 to input.len)
			packet_order += "[i]"
			packet_order["[i]"] = i
			
		shuffle(packet_order)

		for(var/i in 1 to input.len)
			var/key = input[text2num(packet_order[i])]
			var/value = input[key]
			shuffled_input.Add(key)
			shuffled_input[key] = value

		input = shuffled_input

	if(input.len)
		SEND_SIGNAL_OLD(holder, COMSIG_ABERRANT_OUTPUT, holder, owner, input)


/*	Multi-input aberrant organs are still supported, but not present in-game
/datum/component/modification/organ/process/condense
/datum/component/modification/organ/process/condense/get_function_info()
	var/description = "<span style='color:orange'>Functional information (processing):</span> condenses inputs into a single output"

	return description

/datum/component/modification/organ/process/condense/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input)
		return

	var/list/condensed_input = list("condensed input" = 0)

	if(input.len)
		for(var/element in input)
			condensed_input["condensed input"] |= input[element]

		SEND_SIGNAL_OLD(holder, COMSIG_ABERRANT_OUTPUT, holder, owner, condensed_input)
*/
