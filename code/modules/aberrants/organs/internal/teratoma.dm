// Flavorful holder object for organoids. Organoids should almost never spawn outside of these.
/obj/item/organ/internal/scaffold/aberrant/teratoma
	name = "teratoma"
	desc = "An abnormal growth of organ tissue."
	description_info = "A functionless organ with space for a single organoid. Use a laser cutting tool to remove the organoid and recycle the leftover teratoma tissue in the disgorger."
	ruined_name = "ruined teratoma"
	ruined_desc = "An abnormal growth of organ tissue. Ruined by use."
	ruined_description_info = "Useless organ tissue. Recycle this in a disgorger."
	ruined_color = "#696969"
	icon_state = "teratoma"

	max_upgrades = 1
	use_generated_name = FALSE
	use_generated_color = FALSE
	req_num_inputs = null
	req_num_outputs = null

/obj/item/organ/internal/scaffold/aberrant/teratoma/ruin()
	..()
	use_generated_name = FALSE
	max_upgrades = 0
	price_tag = 25
	matter = list(MATERIAL_BIOMATTER = 5)
	STOP_PROCESSING(SSobj, src)

// Input
/obj/item/organ/internal/scaffold/aberrant/teratoma/input
	name = "teratoma (input)"
	req_num_inputs = 1
	input_mod_path = TRUE

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents
	name = "metabolic teratoma"
	description_info = "A teratoma that houses a metabolic organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Requires the specified reagent(s) to be present in one of the three metabolism holders: bloodstream, ingested, or touch. \
						When the correct reagent is in the correct holder, the reagent will be removed at a rate equal to its metabolism times \
						the length of the organ\'s cooldown in ticks. Then, the process will trigger."
	input_mod_path = /obj/item/modification/organ/internal/input/reagents

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/roach
	name = "metabolic teratoma (roach)"
	specific_input_type_pool = REAGENTS_ROACH

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/spider
	name = "metabolic teratoma (spider)"
	specific_input_type_pool = REAGENTS_SPIDER

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/toxin
	name = "metabolic teratoma (toxins)"
	specific_input_type_pool = REAGENTS_TOXIN

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/edible
	name = "metabolic teratoma (edible)"
	specific_input_type_pool = REAGENTS_EDIBLE

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/alcohol
	name = "metabolic teratoma (alcohol)"
	specific_input_type_pool = REAGENTS_ALCOHOL

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/drugs
	name = "metabolic teratoma (drugs)"
	specific_input_type_pool = REAGENTS_DRUGS

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/reagents/dispenser
	name = "metabolic teratoma (chemical)"
	specific_input_type_pool = REAGENTS_DISPENSER_1


/obj/item/organ/internal/scaffold/aberrant/teratoma/input/damage
	name = "nociceptive teratoma"
	description_info = "A teratoma that houses a nociceptive organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Requires the specified damage type(s) to be present. The process is triggered when at least one point of damage is taken \
						(can be inflicted before attaching the organ), but no damage is healed."
	input_mod_path = /obj/item/modification/organ/internal/input/damage

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/damage/basic_low
	specific_input_type_pool = DAMAGE_TYPES_BASIC
	input_threshold = 45

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/damage/all_mid
	specific_input_type_pool = ALL_DAMAGE_TYPES
	input_threshold = 30

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/damage/all_high
	specific_input_type_pool = ALL_DAMAGE_TYPES
	input_threshold = 15

/obj/item/organ/internal/scaffold/aberrant/teratoma/input/power_source
	name = "bioelectric teratoma"
	description_info = "A teratoma that houses a bioelectric organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Requries the specified power source to be held in the bare hand of the organ's owner. Any amount of charge in a cell or sheets \
						in a stack will trigger the process, but larger cells and rarer materials will provide a slight cognition and sanity boost."
	input_mod_path = /obj/item/modification/organ/internal/input/power_source

// process
/obj/item/organ/internal/scaffold/aberrant/teratoma/process
	name = "teratoma (processing)"
	process_mod_path = TRUE

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/map
	name = "tubular teratoma"
	description_info = "A teratoma that houses a tubular organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Maps inputs to outputs. Works for any number of inputs and outputs."
	process_mod_path = /obj/item/modification/organ/internal/process/map

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/condense
	name = "sphincter teratoma"
	description_info = "A teratoma that houses a sphincter organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Maps inputs to a single output. If there are multiple outputs, it only uses the first."
	process_mod_path = /obj/item/modification/organ/internal/process/condense

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/multiplier
	name = "enzymal teratoma (catalyst)"
	description_info = "A teratoma that houses an enzymal organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Maps inputs to outputs. Modifies output magnitude."
	process_mod_path = /obj/item/modification/organ/internal/process/multiplier
	process_info = list(0.20)

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/multiplier/negative_low
	name = "pygmy enzymal teratoma (inhibitor)"
	process_info = list(-0.10)

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/multiplier/negative
	name = "enzymal teratoma (inhibitor)"
	process_info = list(-0.20)

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/multiplier/low
	name = "pygmy enzymal teratoma (catalyst)"
	process_info = list(0.10)

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/multiplier/high
	name = "enlarged enzymal teratoma (catalyst)"
	process_info = list(0.40)

/obj/item/organ/internal/scaffold/aberrant/teratoma/process/cooldown
	name = "sphincter teratoma"
	description_info = "A teratoma that houses a circadian organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Maps inputs to outputs. Modifies organ process duration."
	process_mod_path = /obj/item/modification/organ/internal/process/cooldown
	process_info = list(STANDARD_ABERRANT_COOLDOWN / 2)

// output
/obj/item/organ/internal/scaffold/aberrant/teratoma/output
	name = "teratoma (output)"
	req_num_outputs = 1
	output_mod_path = TRUE

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood
	name = "hepatic teratoma"
	description_info = "A teratoma that houses an hepatic organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Produces reagents in the bloodstream when triggered."
	req_num_outputs = 1
	output_mod_path = /obj/item/modification/organ/internal/output/reagents_blood

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/roach
	name = "hepatic teratoma (roach)"
	output_pool = REAGENTS_ROACH

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/spider
	name = "hepatic teratoma (spider)"
	output_pool = REAGENTS_SPIDER

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/drugs
	name = "hepatic teratoma (drugs)"
	output_pool = REAGENTS_DRUGS

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/industrial
	name = "hepatic teratoma (industrial)"
	output_pool = REAGENTS_INDUSTRIAL

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/dispenser_base
	name = "pygmy hepatic teratoma (chemical)"
	output_pool = REAGENTS_DISPENSER_1

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/dispenser_one
	name = "hepatic teratoma (chemical)"
	output_pool = REAGENTS_DISPENSER_2

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_blood/dispenser_two
	name = "enlarged hepatic teratoma (chemical)"
	output_pool = REAGENTS_DISPENSER_3

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest
	name = "gastric teratoma"
	description_info = "A teratoma that houses a gastric organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Produces reagents in the stomach when triggered."
	req_num_outputs = 1
	output_mod_path = /obj/item/modification/organ/internal/output/reagents_ingest

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest/edible
	name = "gastric teratoma (edible)"
	output_pool = REAGENTS_EDIBLE

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest/alcohol
	name = "gastric teratoma (alcohol)"
	output_pool = REAGENTS_ALCOHOL

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest/industrial
	name = "gastric teratoma (industrial)"
	output_pool = REAGENTS_INDUSTRIAL

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest/dispenser_base
	name = "pygmy gastric teratoma (chemical)"
	output_pool = REAGENTS_DISPENSER_1

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest/dispenser_one
	name = "gastric teratoma (chemical)"
	output_pool = REAGENTS_DISPENSER_2

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/reagents_ingest/dispenser_two
	name = "enlarged gastric teratoma (chemical)"
	output_pool = REAGENTS_DISPENSER_3

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/chemical_effects
	name = "endocrinal teratoma"
	description_info = "A teratoma that houses an endocrinal organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Produces hormones in the bloodstream when triggered."
	req_num_outputs = 1
	output_mod_path = /obj/item/modification/organ/internal/output/chemical_effects

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/chemical_effects/type_1
	name = "endocrinal teratoma (type 1)"
	output_pool = TYPE_1_HORMONES

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/chemical_effects/type_2
	name = "endocrinal teratoma (type 2)"
	output_pool = TYPE_2_HORMONES

/obj/item/organ/internal/scaffold/aberrant/teratoma/output/stat_boost
	name = "intracrinal teratoma"
	description_info = "A teratoma that houses an intracrinal organoid. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Organoid information:\n\
						Slightly increase stats when triggered."
	req_num_outputs = 1
	output_mod_path = /obj/item/modification/organ/internal/output/stat_boost


// special
/obj/item/organ/internal/scaffold/aberrant/teratoma/special
	name = "teratoma (unknown)"
	special_mod_path = TRUE

/obj/item/organ/internal/scaffold/aberrant/teratoma/special/chemical_effect
	name = "pygmy endocrinal teratoma"
	description_info = "A teratoma that houses a pygmy endocrinal membrane. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Membrane information:\n\
						Produces a hormone when the primary function triggers."
	special_mod_path = /obj/item/modification/organ/internal/special/on_cooldown/chemical_effect

/obj/item/organ/internal/scaffold/aberrant/teratoma/special/stat_boost
	name = "pygmy intracrinal teratoma"
	description_info = "A teratoma that houses a pygmy intracrinal membrane. Use a laser cutting tool to remove the organoid. 35 BIO and 15 COG recommended.\n\n\
						Membrane information:\n\
						Slightly increases a stat when the primary function triggers."
	special_mod_path = /obj/item/modification/organ/internal/special/on_cooldown/stat_boost

/*
/obj/item/storage/freezer/medical/contains_teratomas/populate_contents()
	new /obj/item/organ/internal/scaffold/aberrant/teratoma/random(src)
	for(var/count in 1 to 3)	// 79.6% to have at least one extra teratoma
		if(prob(40))
			new /obj/item/organ/internal/scaffold/aberrant/teratoma/random(src)
	for(var/count in 1 to 3)	// 27.1% to have at least one uncommon teratoma
		if(prob(10))
			new /obj/item/organ/internal/scaffold/aberrant/teratoma/random/uncommon(src)
	if(prob(5))
		new /obj/item/organ/internal/scaffold/aberrant/teratoma/random/rare(src)
*/
