// Scaffolds with regular organ functions, reduced/zero requirements, and assisted nature
// Desc for eyes: "What bondage comes with these eyes?"

/obj/item/organ/internal/scaffold/aberrant/hive_blood_vessel
	name = "hivemind blood vessel"
	icon_state = "blood_vessel"
	desc = "Transports blood throughout the human body."
	organ_efficiency = list(OP_BLOOD_VESSEL = 125)
	nature = MODIFICATION_ASSISTED
	max_damage = 50
	specific_organ_size = 0.5
	max_blood_storage = 100
	oxygen_req = 2
	nutriment_req = 0.5

	price_tag = 250

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_bone
	name = "hivemind bone"
	icon_state = "bone_braces"
	desc = "You have got a bone to pick with this"
	force = WEAPON_FORCE_NORMAL
	organ_efficiency = list(OP_BONE = 125)
	nature = MODIFICATION_ASSISTED
	max_damage = 100

	price_tag = 250

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_muscle
	name = "hivemind muscle"
	icon_state = "human_muscle"
	description_info = "Increases limb efficiency, making you run faster or use tools better"
	desc = "Rip and tear"
	organ_efficiency = list(OP_MUSCLE = 125)
	nature = MODIFICATION_ASSISTED
	max_damage = 50
	specific_organ_size = 0.5
	blood_req = 0
	max_blood_storage = 2.5
	nutriment_req = 0.25

	price_tag = 250

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_nerve
	name = "hivemind nerve"
	icon_state = "nerve"
	desc = "Looking at this makes you feel nervous."
	description_info = "Increases limb sensitivity, making you more susceptible to pain, but also more precise with tools"
	organ_efficiency = list(OP_NERVE = 125)
	nature = MODIFICATION_ASSISTED
	max_damage = 50
	specific_organ_size = 0
	blood_req = 0
	max_blood_storage = 2.5
	nutriment_req = 0.25

	price_tag = 250

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_heart
	name = "hivemind heart"
	icon_state = "heart-on"
	dead_icon = "heart-off"
	desc = "A vital organ which pumps blood through the blood vessels of the circulatory system. "
	description_info = "Increases the efficiency of reagent metabolization in blood"
	organ_efficiency = list(OP_HEART = 125)
	nature = MODIFICATION_ASSISTED
	parent_organ_base = BP_CHEST
	specific_organ_size = 2
	oxygen_req = 10
	nutriment_req = 5

	price_tag = 2500

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_kidney
	name = "hivemind kidney"
	icon_state = "kidney_left"
	organ_efficiency = list(OP_KIDNEYS = 62.5)
	nature = MODIFICATION_ASSISTED
	parent_organ_base = BP_GROIN
	specific_organ_size = 1
	blood_req = 0
	max_blood_storage = 7.5
	oxygen_req = 2.5
	nutriment_req = 1

	price_tag = 1000

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_liver
	name = "hivemind liver"
	icon_state = "liver"
	desc = "A vital organ that detoxifies metabolites. Among other things."
	description_info = "Increases the metabolization rate of chemicals in both the stomach and bloodstream"
	organ_efficiency = list(OP_LIVER = 125)
	nature = MODIFICATION_ASSISTED
	parent_organ_base = BP_GROIN
	blood_req = 0
	max_blood_storage = 25
	oxygen_req = 7
	nutriment_req = 2.5

	price_tag = 2250

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_lungs
	name = "hivemind lungs"
	icon_state = "lungs"
	desc = "A vital respiratory organ."
	gender = PLURAL
	organ_efficiency = list(OP_LUNGS = 125)
	nature = MODIFICATION_ASSISTED
	parent_organ_base = BP_CHEST
	specific_organ_size = 2
	blood_req = 0
	max_blood_storage = 50
	nutriment_req = 5

	price_tag = 750

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock

/obj/item/organ/internal/scaffold/aberrant/hive_stomach
	name = "hivemind stomach"
	icon_state = "stomach"
	desc = "A vital digestive organ."
	description_info = "Increases the metabolization rate for reagents in the stomach."
	organ_efficiency = list(OP_STOMACH = 125)
	nature = MODIFICATION_ASSISTED
	parent_organ_base = BP_CHEST
	blood_req = 0
	max_blood_storage = 25
	oxygen_req = 5

	price_tag = 1750

	use_generated_name = FALSE
	use_generated_icon = FALSE
	use_generated_color = FALSE
	special_mod_path = /obj/item/modification/organ/internal/special/on_pickup/shock
