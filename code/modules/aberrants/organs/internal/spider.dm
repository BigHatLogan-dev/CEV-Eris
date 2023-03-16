// Pararein and aranecolmin injecting knuckledusters
// Web producer and spitter
// Aranecolmin membrane

/obj/item/organ/internal/scaffold/aberrant/spider
	name = "spider organ"
	ruined_name = "spider organ"
	desc = "An organ harvested from a spider."
	ruined_desc = null
	description_info = "A modular organ with four slots for organ mods or organoids."
	ruined_description_info = null
	icon = 'icons/obj/aberrant_organs/arachno_organs.dmi'
	rarity_value = 20
	spawn_tags = SPAWN_TAG_ABERRANT_ORGAN_MAINT
	spawn_blacklisted = TRUE
	bad_type = /obj/item/organ/internal/scaffold/aberrant/spider
	b_type = "X="				// Will trigger rejection
	max_upgrades = 4
	use_generated_name = FALSE
	organ_type = "arachno"
	aberrant_cooldown_time = ROACH_ABERRANT_COOLDOWN

/obj/item/organ/internal/scaffold/aberrant/spider/update_color()
	..()
	if(!generated_color)
		generated_color = "[rand(1,3)]"

/obj/item/organ/internal/scaffold/aberrant/spider/spinneret
	name = "Kouchiku spinneret"
	icon_state = "organ_scaffold-arachno-3"

	use_generated_color = FALSE
	use_generated_icon = FALSE
	use_generated_name = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/consume
	process_mod_path = /obj/item/modification/organ/internal/process/cooldown
	output_mod_path = /obj/item/modification/organ/internal/output/produce
	special_mod_path = /obj/item/modification/organ/internal/special/on_cooldown/stat_boost
	specific_input_type_pool = STANDARD_ORGANIC_CONSUMABLES
	input_mode = NOT_USED
	process_info = list(-STANDARD_ABERRANT_COOLDOWN/2)
	output_pool = list(/obj/effect/spider/stickyweb)
	output_info = list(/obj/effect/spider/stickyweb)
	special_info = list(STAT_VIG, 15)

/obj/item/organ/internal/scaffold/aberrant/spider/chelicera
	name = "Kouchiku chelicera"
	icon_state = "organ_scaffold-arachno-3"

	use_generated_color = FALSE
	use_generated_icon = FALSE
	use_generated_name = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/reagents
	process_mod_path = /obj/item/modification/organ/internal/process/multiplier
	output_mod_path = /obj/item/modification/organ/internal/output/stat_boost
	special_mod_path = /obj/item/modification/organ/internal/deployable
	specific_input_type_pool = list(/datum/reagent/toxin/pararein)
	input_mode = CHEM_BLOOD
	process_info = list(0.50)
	output_pool = list(STAT_VIG)
	output_info = list(15)
	special_info = list(/obj/item/gun/matter/regenerating/gestrahlte_gland)	// Should be spider gun
