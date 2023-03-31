// Scaffolds with regular organ functions, reduced/zero requirements, and assisted nature
// Desc for eyes: "What bondage comes with these eyes?"

/obj/item/organ/internal/scaffold/aberrant/hivemind
	ruined_name = null
	ruined_desc = null
	ruined_color = null
	icon = 'icons/obj/aberrant_organs/hivemind_organs.dmi'
	bad_type = /obj/item/organ/internal/scaffold/aberrant/hivemind
	origin_tech = list(TECH_BIO = 4, TECH_DATA = 5)
	max_upgrades = 4

	nature = MODIFICATION_ASSISTED

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	should_process_have_organ_stats = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/power_source
	process_mod_path = /obj/item/modification/organ/internal/process/multiplier
	output_mod_path = /obj/item/modification/organ/internal/output/reagents_ingest
	special_mod_path = /obj/item/modification/organ/internal/on_pickup/shock/powerful

	specific_input_type_pool = ALL_USABLE_POWER_SOURCES
	input_mode = NOT_USED
	process_info = list(1.5)
	output_pool = REAGENTS_METAL
	output_info = list(VERY_LOW_OUTPUT)

/obj/item/organ/internal/scaffold/aberrant/hivemind/blood_vessel
	name = "hivemind-assisted blood vessel"
	icon_state = "blood_vessel_hivemind"
	desc = "Transports blood throughout the human body."
	organ_efficiency = list(OP_BLOOD_VESSEL = 175)
	max_damage = IORGAN_SMALL_HEALTH * 2
	min_bruised_damage = 2
	min_broken_damage = 4
	specific_organ_size = 0.5
	max_blood_storage = 100
	oxygen_req = 2
	nutriment_req = 0.5
	price_tag = 250

/obj/item/organ/internal/scaffold/aberrant/hivemind/muscle
	name = "hivemind-assisted muscle"
	icon_state = "human_muscle_hivemind"
	description_info = "Increases limb efficiency, making you run faster or use tools better"
	desc = "Rip and tear"
	organ_efficiency = list(OP_MUSCLE = 175)
	max_damage = IORGAN_SMALL_HEALTH * 2
	min_bruised_damage = 2
	min_broken_damage = 4
	specific_organ_size = 0.5
	blood_req = 0
	max_blood_storage = 2.5
	nutriment_req = 0.25
	price_tag = 250

/obj/item/organ/internal/scaffold/aberrant/hivemind/nerve
	name = "hivemind-assisted nerve"
	icon_state = "nerve_hivemind"
	desc = "Looking at this makes you feel nervous."
	description_info = "Increases limb sensitivity, making you more susceptible to pain, but also more precise with tools"
	organ_efficiency = list(OP_NERVE = 175)
	max_damage = IORGAN_SMALL_HEALTH * 2
	min_bruised_damage = 2
	min_broken_damage = 4
	specific_organ_size = 0
	blood_req = 0
	max_blood_storage = 2.5
	nutriment_req = 0.25
	price_tag = 250

/obj/item/organ/internal/scaffold/aberrant/hivemind/heart
	name = "hivemind-assisted heart"
	icon_state = "heart_hivemind"
	dead_icon = "heart_hivemind-dead"
	desc = "A vital organ which pumps blood through the blood vessels of the circulatory system. "
	description_info = "Increases the efficiency of reagent metabolization in blood"
	organ_efficiency = list(OP_HEART = 175)
	parent_organ_base = BP_CHEST
	max_damage = IORGAN_STANDARD_HEALTH * 2
	specific_organ_size = 2
	oxygen_req = 10
	nutriment_req = 5
	price_tag = 2500

/obj/item/organ/internal/scaffold/aberrant/hivemind/kidney
	name = "hivemind-assisted kidney"
	icon_state = "kidney_hivemind"
	organ_efficiency = list(OP_KIDNEYS = 87.5)
	parent_organ_base = BP_GROIN
	max_damage = IORGAN_STANDARD_HEALTH * 2
	specific_organ_size = 1
	blood_req = 0
	max_blood_storage = 7.5
	oxygen_req = 2.5
	nutriment_req = 1
	price_tag = 1000

/obj/item/organ/internal/scaffold/aberrant/hivemind/liver
	name = "hivemind-assisted liver"
	icon_state = "liver_hivemind"
	desc = "A vital organ that detoxifies metabolites. Among other things."
	description_info = "Increases the metabolization rate of chemicals in both the stomach and bloodstream"
	organ_efficiency = list(OP_LIVER = 175)
	parent_organ_base = BP_GROIN
	max_damage = IORGAN_STANDARD_HEALTH * 2
	blood_req = 0
	max_blood_storage = 25
	oxygen_req = 7
	nutriment_req = 2.5
	price_tag = 2250

/obj/item/organ/internal/scaffold/aberrant/hivemind/lungs
	name = "hivemind-assisted lungs"
	icon_state = "lungs_hivemind"
	desc = "A vital respiratory organ."
	gender = PLURAL
	organ_efficiency = list(OP_LUNGS = 175)
	parent_organ_base = BP_CHEST
	max_damage = IORGAN_STANDARD_HEALTH * 2
	specific_organ_size = 2
	blood_req = 0
	max_blood_storage = 50
	nutriment_req = 5
	breath_modulo = 3
	price_tag = 750

/obj/item/organ/internal/scaffold/aberrant/hivemind/stomach
	name = "hivemind-assisted stomach"
	icon_state = "stomach_hivemind"
	desc = "A vital digestive organ."
	description_info = "Increases the metabolization rate for reagents in the stomach."
	organ_efficiency = list(OP_STOMACH = 175)
	parent_organ_base = BP_CHEST
	max_damage = IORGAN_STANDARD_HEALTH * 2
	blood_req = 0
	max_blood_storage = 25
	oxygen_req = 5
	price_tag = 1750

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone
	name = "hivemind-assisted bone"
	desc = "You have got a bone to pick with this"
	bad_type = /obj/item/organ/internal/scaffold/aberrant/hivemind/bone
	force = WEAPON_FORCE_NORMAL
	organ_efficiency = list(OP_BONE = 175)
	max_damage = IORGAN_SKELETAL_HEALTH * 2
	min_bruised_damage = 4
	min_broken_damage = 6
	price_tag = 250

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/skull
	name = "hivemind-assisted skull"
	icon_state = "skull_hivemind"
	parent_organ_base = BP_HEAD

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/ribcage
	name = "hivemind-assisted ribcage"
	icon_state = "ribcage_hivemind"
	parent_organ_base = BP_CHEST

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/pelvis
	name = "hivemind-assisted pelvis"
	icon_state = "pelvis_hivemind"
	parent_organ_base = BP_GROIN

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/r_arm
	name = "hivemind-assisted right humerus"
	icon_state = "right_arm_hivemind"
	parent_organ_base = BP_R_ARM

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/l_arm
	name = "hivemind-assisted left humerus"
	icon_state = "left_arm_hivemind"
	parent_organ_base = BP_L_ARM

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/r_leg
	name = "hivemind-assisted right femur"
	icon_state = "right_leg_hivemind"
	parent_organ_base = BP_R_LEG
	force = WEAPON_FORCE_PAINFUL

/obj/item/organ/internal/scaffold/aberrant/hivemind/bone/l_leg
	name = "hivemind-assisted left femur"
	icon_state = "left_leg_hivemind"
	parent_organ_base = BP_L_LEG
	force = WEAPON_FORCE_PAINFUL
