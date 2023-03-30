/obj/item/modification/organ/internal/output
	name = "organoid (output)"
	icon_state = "output_organoid"
	bad_type = /obj/item/modification/organ/internal/output

/obj/item/modification/organ/internal/output/reagents_blood
	name = "hepatic organoid"
	desc = "Functional tissue of one or more organs in graftable form. Secretes reagents into the bloodstream."
	description_info = "Produces reagents in the bloodstream when triggered.\n\n\
						Use a laser cutting tool to change the metabolism target or reagent type.\n\
						Reagents can only be swapped for like reagents."

/obj/item/modification/organ/internal/output/reagents_blood/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/output_types, list/additional_output_info)
	var/datum/component/modification/organ/output/reagents/O = AddComponent(/datum/component/modification/organ/output/reagents)

	for(var/output in output_types)
		O.possible_outputs += output
		O.possible_outputs[output] = output_types[output]
		O.mode = CHEM_BLOOD

	var/list/new_output_qualities = list()

	for(var/quality in additional_output_info)
		if(ispath(quality, /datum/reagent))
			var/datum/reagent/R = quality
			var/reagent_name = initial(R.name)
			new_output_qualities |= reagent_name
			new_output_qualities[reagent_name] = quality
	
	O.output_qualities = new_output_qualities
	..()

/obj/item/modification/organ/internal/output/reagents_ingest
	name = "gastric organoid"
	desc = "Functional tissue of one or more organs in graftable form. Produces reagents in the stomach."
	description_info = "Produces reagents in the stomach when triggered.\n\n\
						Use a laser cutting tool to change the metabolism target or reagent type.\n\
						Reagents can only be swapped for like reagents."

/obj/item/modification/organ/internal/output/reagents_ingest/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/output_types, list/additional_output_info)
	var/datum/component/modification/organ/output/reagents/O = AddComponent(/datum/component/modification/organ/output/reagents)

	for(var/output in output_types)
		O.possible_outputs += output
		O.possible_outputs[output] = output_types[output]
		O.mode = CHEM_INGEST

	var/list/new_output_qualities = list()

	for(var/quality in additional_output_info)
		if(ispath(quality, /datum/reagent))
			var/datum/reagent/R = quality
			var/reagent_name = initial(R.name)
			new_output_qualities |= reagent_name
			new_output_qualities[reagent_name] = quality
	
	O.output_qualities = new_output_qualities
	..()

/obj/item/modification/organ/internal/output/chemical_effects
	name = "endocrinal organoid"
	desc = "Functional tissue of one or more organs in graftable form. Secretes hormones."
	description_info = "Produces hormones in the bloodstream when triggered.\n\n\
						Use a laser cutting tool to change the hormone type.\n\
						Hormone effects of the same type do not stack."

/obj/item/modification/organ/internal/output/chemical_effects/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/output_types, list/additional_output_info)
	var/datum/component/modification/organ/output/chemical_effects/O = AddComponent(/datum/component/modification/organ/output/chemical_effects)

	for(var/output in output_types)
		O.possible_outputs += output
		O.possible_outputs[output] = output_types[output]

	var/list/new_output_qualities = list()

	for(var/quality in additional_output_info)
		var/effect
		switch(quality)
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

		new_output_qualities |= effect
		new_output_qualities[effect] = quality
	
	O.output_qualities = new_output_qualities
	..()

/obj/item/modification/organ/internal/output/stat_boost
	name = "intracrinal organoid"
	desc = "Functional tissue of one or more organs in graftable form. Secretes stimulating hormones."
	description_info = "Slightly increases stats when triggered.\n\n\
						Use a laser cutting tool to change the target stat."

/obj/item/modification/organ/internal/output/stat_boost/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/output_types, list/additional_output_info)
	var/datum/component/modification/organ/output/stat_boost/O = AddComponent(/datum/component/modification/organ/output/stat_boost)

	for(var/output in output_types)
		O.possible_outputs += output
		O.possible_outputs[output] = output_types[output]
	
	O.output_qualities = additional_output_info.Copy()
	..()

/obj/item/modification/organ/internal/output/produce
	name = "ovarian organoid"
	desc = "Functional tissue of one or more organs in graftable form. The cradle of life."
	description_info = "Causes the user to vomit an object.\n\n\
						Use a laser cutting tool to change the target stat."

/obj/item/modification/organ/internal/output/produce/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/output_types, list/additional_output_info)
	var/datum/component/modification/organ/output/produce/O = AddComponent(/datum/component/modification/organ/output/produce)

	for(var/output in output_types)
		O.possible_outputs += output
		O.possible_outputs[output] = output_types[output]
	
	O.output_qualities = additional_output_info.Copy()
	O.modifications[ORGAN_ABERRANT_COOLDOWN] = 5 MINUTES	// Don't want these popping out too often
	..()

/obj/item/modification/organ/internal/output/chem_smoke
	name = "eructal organoid"
	desc = "Functional tissue of one or more organs in graftable form. Expels stored reagents as a gas cloud."
	description_info = "Causes the user to emit a gas cloud containing reagents in their blood, stomach, or an internal gas sac.\n\n\
						Use a laser cutting tool to change the target stat."
	var/list/modes = STANDARD_CHEM_SMOKE_MODES

/obj/item/modification/organ/internal/output/chem_smoke/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/output_types, list/additional_output_info)
	var/datum/component/modification/organ/output/chem_smoke/O = AddComponent(/datum/component/modification/organ/output/chem_smoke)

	for(var/output in output_types)
		O.possible_outputs += output
		O.possible_outputs[output] = output_types[output]
	
	O.modes = modes.Copy()
	O.output_qualities = additional_output_info.Copy()
	O.modifications[ORGAN_ABERRANT_COOLDOWN] = 5 MINUTES
	..()

/obj/item/modification/organ/internal/output/chem_smoke/roach
	name = "Seuche organoid"
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "output_organoid-seuche"
	description_info = "Causes the user to emit a gas cloud containing reagents in their blood, stomach, or an internal gas sac.\n\n\
						Use a laser cutting tool to change the target stat."
	use_generated_icon = FALSE
	modes = ROACH_CHEM_SMOKE_MODES
