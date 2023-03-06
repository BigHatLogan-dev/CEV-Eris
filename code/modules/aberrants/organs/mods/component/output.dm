/datum/component/modification/organ/output
	exclusive_type = /obj/item/modification/organ/internal/output
	trigger_signal = COMSIG_ABERRANT_OUTPUT

	var/list/possible_outputs = list()
	var/list/output_qualities = list()
	var/charge_level_max = 0
	var/current_charge_level = 0

/datum/component/modification/organ/output/reagents
	adjustable = TRUE
	var/mode = CHEM_BLOOD

/datum/component/modification/organ/output/reagents/get_function_info()
	var/metabolism = mode == CHEM_BLOOD ? "bloodstream" : "stomach"

	var/outputs
	for(var/output in possible_outputs)
		var/datum/reagent/R = output
		outputs += initial(R.name) + " ([possible_outputs[output]]u), "

	outputs = copytext(outputs, 1, length(outputs) - 1)

	var/description = "<span style='color:blue'>Functional information (output):</span> produces reagents in [metabolism]"
	description += "\n<span style='color:blue'>Reagents produced:</span> [outputs]"

	return description

/datum/component/modification/organ/output/reagents/modify(obj/item/I, mob/living/user)
	if(!LAZYLEN(output_qualities))
		return

	var/list/can_adjust = list("metabolic target", "reagent")

	var/decision_adjust = input("What do you want to adjust?","Adjusting Organoid") as null|anything in can_adjust
	if(!decision_adjust)
		return

	var/list/adjustable_qualities = list()

	if(decision_adjust == "metabolic target")
		adjustable_qualities = list(
			"stomach" = CHEM_INGEST,
			"bloodstream" = CHEM_BLOOD
		)

		var/decision = input("Choose a metabolic target","Adjusting Organoid") as null|anything in adjustable_qualities
		if(!decision)
			return

		mode = adjustable_qualities[decision]

		if(istype(parent, /obj/item/modification/organ))
			var/obj/item/modification/organ/O = parent
			if(mode == CHEM_INGEST)
				O.name = "gastric organoid"
				O.desc = "Functional tissue of one or more organs in graftable form. Produces reagents in the stomach."
				O.description_info = "Produces reagents in the stomach when triggered.\n\n\
									Use a laser cutting tool to change the metabolism target or reagent type.\n\
									Reagents can only be swapped for like reagents."
			else if(mode == CHEM_BLOOD)
				O.name = "hepatic organoid"
				O.desc = "Functional tissue of one or more organs in graftable form. Secretes reagents into the bloodstream."
				O.description_info = "Produces reagents in the bloodstream when triggered.\n\n\
									Use a laser cutting tool to change the metabolism target or reagent type.\n\
									Reagents can only be swapped for like reagents."

	if(decision_adjust == "reagent")
		for(var/output in possible_outputs)
			var/list/possibilities = output_qualities.Copy()

			if(LAZYLEN(possible_outputs) > 1)
				for(var/effect_name in possibilities)
					var/effect_type = possibilities[effect_name]
					if(output != effect_type && possible_outputs.Find(effect_type))
						possibilities.Remove(effect_name)

			var/decision = input("Choose a reagent:","Adjusting Organoid") as null|anything in possibilities
			if(!decision)
				return

			var/output_amount = possible_outputs[output]
			possible_outputs[possible_outputs.Find(output)] = output_qualities[decision]
			possible_outputs[output_qualities[decision]] = output_amount

/datum/component/modification/organ/output/reagents/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input || !mode)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/organ_multiplier = (S.max_damage - S.damage) / S.max_damage
	var/datum/reagents/metabolism/RM = owner.get_metabolism_handler(mode)
	var/triggered = FALSE

	if(LAZYLEN(input) && LAZYLEN(input) <= LAZYLEN(possible_outputs))
		for(var/i in input)
			var/index = input.Find(i)
			var/is_input_valid = input[i] ? TRUE : FALSE
			if(is_input_valid && index <= LAZYLEN(possible_outputs))
				var/input_multiplier = input[i]
				var/datum/reagent/output = possible_outputs[index]
				var/amount_to_add = possible_outputs[output] * organ_multiplier * input_multiplier
				RM.add_reagent(initial(output.id), amount_to_add)
				triggered = TRUE

	if(triggered)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_COOLDOWN)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_SECONDARY, holder, owner)


/datum/component/modification/organ/output/chemical_effects	// More organ-like than producing reagents
	adjustable = TRUE

/datum/component/modification/organ/output/chemical_effects/get_function_info()
	var/outputs
	for(var/output in possible_outputs)
		var/datum/reagent/hormone/H
		if(ispath(output, /datum/reagent/hormone))
			H = output

		var/effect
		switch(output)
			if(/datum/reagent/hormone/bloodrestore, /datum/reagent/hormone/bloodrestore/alt)
				effect = "blood restoration"
			if(/datum/reagent/hormone/bloodclot, /datum/reagent/hormone/bloodclot/alt)
				effect = "blood clotting"
			if(/datum/reagent/hormone/painkiller, /datum/reagent/hormone/painkiller/alt)
				effect = "painkiller"
			if(/datum/reagent/hormone/antitox, /datum/reagent/hormone/antitox/alt)
				effect = "anti-toxin"
			if(/datum/reagent/hormone/oxygenation, /datum/reagent/hormone/oxygenation/alt)
				effect = "oxygenation"
			if(/datum/reagent/hormone/speedboost, /datum/reagent/hormone/speedboost/alt)
				effect = "augmented agility"
			else
				effect = "none"
		outputs += "[effect] (type ["[initial(H.hormone_type)]"]), "

	outputs = copytext(outputs, 1, length(outputs) - 1)

	var/description = "<span style='color:blue'>Functional information (output):</span> secretes hormones"
	description += "\n<span style='color:blue'>Effects produced:</span> [outputs]"

	return description

/datum/component/modification/organ/output/chemical_effects/modify(obj/item/I, mob/living/user)
	if(!LAZYLEN(output_qualities))
		return

	for(var/output in possible_outputs)
		var/list/possibilities = output_qualities.Copy()

		if(LAZYLEN(possible_outputs) > 1)
			for(var/effect_name in possibilities)
				var/effect_type = possibilities[effect_name]
				if(output != effect_type && possible_outputs.Find(effect_type))
					possibilities.Remove(effect_name)

		var/decision = input("Choose a hormone effect (current: [output])","Adjusting Organoid") as null|anything in possibilities
		if(!decision)
			continue

		var/new_output = output_qualities[decision]
		var/amount = possible_outputs[output]

		possible_outputs[possible_outputs.Find(output)] = new_output
		possible_outputs[new_output] = amount

/datum/component/modification/organ/output/chemical_effects/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/organ_multiplier = ((S.max_damage - S.damage) / S.max_damage) * (S.aberrant_cooldown_time / (2 SECONDS))	// Life() is called every 2 seconds
	var/datum/reagents/metabolism/RM = owner.get_metabolism_handler(CHEM_BLOOD)
	var/triggered = FALSE

	if(LAZYLEN(input) && LAZYLEN(input) <= LAZYLEN(possible_outputs))
		for(var/i in input)
			var/index = input.Find(i)
			var/is_input_valid = input[i] ? TRUE : FALSE
			if(is_input_valid && index <= LAZYLEN(possible_outputs))
				var/input_multiplier = input[i]
				var/datum/reagent/output = possible_outputs[index]
				var/amount_to_add = initial(output.metabolism) * organ_multiplier * input_multiplier
				RM.add_reagent(initial(output.id), amount_to_add)
				triggered = TRUE

	if(triggered)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_COOLDOWN)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_SECONDARY, holder, owner)


/datum/component/modification/organ/output/stat_boost
	adjustable = TRUE

/datum/component/modification/organ/output/stat_boost/get_function_info()
	var/outputs
	for(var/stat in possible_outputs)
		outputs += stat + " ([possible_outputs[stat]]), "

	outputs = copytext(outputs, 1, length(outputs) - 1)

	var/description = "<span style='color:blue'>Functional information (output):</span> augments physical/mental affinity"
	description += "\n<span style='color:blue'>Affinities:</span> [outputs]"

	return description

/datum/component/modification/organ/output/stat_boost/modify(obj/item/I, mob/living/user)
	if(!LAZYLEN(output_qualities))
		return

	for(var/output in possible_outputs)
		var/list/possibilities = output_qualities.Copy()
		var/output_amount = possible_outputs[output]
		if(LAZYLEN(possible_outputs) > 1)
			for(var/stat in possibilities)
				if(output != stat && possible_outputs.Find(stat))
					possibilities.Remove(stat)

		var/decision = input("Choose an affinity (current: [output])","Adjusting Organoid") as null|anything in possibilities
		if(!decision)
			continue

		possible_outputs[possible_outputs.Find(output)] = decision
		possible_outputs[decision] = output_amount

/datum/component/modification/organ/output/stat_boost/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/organ_multiplier = (S.max_damage - S.damage) / S.max_damage
	var/delay = S.aberrant_cooldown_time + 2 SECONDS
	var/triggered = FALSE

	if(LAZYLEN(input) && iscarbon(owner))
		for(var/i in input)
			var/index = input.Find(i)
			var/is_input_valid = input[i] ? TRUE : FALSE
			if(is_input_valid && index <= LAZYLEN(possible_outputs))
				var/input_multiplier = input[i]
				var/stat = possible_outputs[index]
				var/magnitude = possible_outputs[stat] * organ_multiplier * input_multiplier
				owner.stats.addTempStat(stat, magnitude, delay, "\ref[parent]")
				triggered = TRUE

	if(triggered)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_COOLDOWN)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_SECONDARY, holder, owner)


/datum/component/modification/organ/output/produce
	adjustable = TRUE
	aberrant_cooldown_time_mod = 5 MINUTES	// Don't want these popping out too often

/datum/component/modification/organ/output/produce/get_function_info()
	var/outputs
	for(var/output in possible_outputs)
		var/atom/movable/AM = output
		outputs += initial(AM.name) + " ([possible_outputs[AM]]), "

	outputs = copytext(outputs, 1, length(outputs) - 1)

	var/description = "<span style='color:blue'>Functional information (output):</span> produces objects"
	description += "\n<span style='color:blue'>Products (quantity):</span> [outputs]"

	return description

/datum/component/modification/organ/output/produce/modify(obj/item/I, mob/living/user)
	if(!LAZYLEN(output_qualities))
		return

	var/list/possibilities_by_name = list()

	for(var/atom/movable/possible in possible_outputs)
		possibilities_by_name.Insert(initial(possible.name), possible)

	for(var/output in possible_outputs)
		var/atom/movable/AM = output
		var/name = initial(AM.name)
		var/list/possibilities = output_qualities.Copy()
		var/output_amount = possible_outputs[output]
		if(LAZYLEN(possible_outputs) > 1)
			for(var/object_path in possibilities)
				if(output != object_path && possible_outputs.Find(object_path))
					possibilities.Remove(object_path)

		var/decision = input("Choose a product (current: [name])","Adjusting Organoid") as null|anything in possibilities_by_name
		if(!decision)
			continue

		var/decision_path = possibilities_by_name[decision]
		possible_outputs[possible_outputs.Find(output)] = decision_path
		possible_outputs[decision_path] = output_amount

/datum/component/modification/organ/output/produce/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/organ_multiplier = (S.max_damage - S.damage) / S.max_damage
	var/triggered = FALSE

	if(LAZYLEN(input) && iscarbon(owner))
		for(var/i in input)
			var/index = input.Find(i)
			var/is_input_valid = input[i] ? TRUE : FALSE
			if(is_input_valid && index <= LAZYLEN(possible_outputs))
				var/input_multiplier = input[i]
				var/object_count = round(input_multiplier * organ_multiplier)
				var/object_path = possible_outputs[index]
				for(var/count in 1 to object_count)
					new object_path(get_turf(owner))
				triggered = TRUE

	if(triggered)
		if(prob(50))
			playsound(owner, 'sound/effects/squelch1.ogg', 50, 1)
		else
			playsound(owner, 'sound/effects/splat.ogg', 50, 1)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_COOLDOWN)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_SECONDARY, holder, owner)

/*	Unused and incomplete. Leaving this here if anyone decides to make use of it.
/datum/component/modification/organ/output/research
	var/charges				// How many times this should trigger before being vomited out

/datum/component/modification/organ/output/research/get_function_info()
	var/description = "<span style='color:blue'>Functional information (output):</span> harvests visceral research data from parent limb"
	description += "\n<span style='color:blue'>Harvest cycles remaining:</span> [charges ? charges : "none"]"

	return description

/datum/component/modification/organ/output/research/trigger(atom/movable/holder, mob/living/carbon/owner, list/input)
	if(!holder || !owner || !input)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/organ_multiplier = (S.max_damage - S.damage) / S.max_damage
	var/triggered = FALSE

	if(ishuman(owner))
		if(LAZYLEN(input))
			for(var/i in input)
				var/index = input.Find(i)
				var/is_input_valid = input[i] ? TRUE : FALSE
				if(is_input_valid && index <= LAZYLEN(possible_outputs))
					var/input_multiplier = input[i]
					// research SS
					triggered = TRUE

		if(charges)
			--charges
		else
			var/mob/living/carbon/human/H = owner
			H.vomit(TRUE)
			S.removed()
			triggered = FALSE

	if(triggered)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_COOLDOWN)
		SEND_SIGNAL(holder, COMSIG_ABERRANT_SECONDARY, holder, owner)
*/
