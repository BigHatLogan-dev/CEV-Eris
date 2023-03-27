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
	b_type = "X="				// Will trigger rejection
	max_upgrades = 4

	use_generated_name = FALSE
	organ_type = "arachno"
	num_variants = 0
	num_colors = 3
	
	aberrant_cooldown_time = MAINT_ABERRANT_COOLDOWN

	input_mod_path = /obj/item/modification/organ/internal/input/consume
	process_mod_path = /obj/item/modification/organ/internal/process/cooldown
	output_mod_path = /obj/item/modification/organ/internal/output/reagents_blood

	specific_input_type_pool = STANDARD_ORGANIC_CONSUMABLES
	input_mode = NOT_USED
	process_info = list(-STANDARD_ABERRANT_COOLDOWN/1.5)
	output_pool = REAGENTS_SPIDER
	output_info = list(LOW_OUTPUT)

/obj/item/organ/internal/scaffold/aberrant/spider/pararein
	name = "pararein gland"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/pararein

/obj/item/organ/internal/scaffold/aberrant/spider/aranecolmin
	name = "aranecolmin sac"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/aranecolmin

/obj/item/organ/internal/scaffold/aberrant/spider/spinneret
	name = "Kouchiku spinneret"
	icon_state = "organ_scaffold-arachno-3"

	use_generated_color = FALSE
	use_generated_icon = FALSE

	output_mod_path = /obj/item/modification/organ/internal/output/produce
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/stat_boost

	output_pool = list(/obj/effect/spider/stickyweb)
	output_info = list(/obj/effect/spider/stickyweb)
	special_info = list(STAT_VIG, 15)

/obj/item/organ/internal/scaffold/aberrant/spider/chelicera
	name = "Kouchiku chelicera"
	icon_state = "organ_scaffold-arachno-3"

	use_generated_color = FALSE
	use_generated_icon = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/reagents
	output_mod_path = /obj/item/modification/organ/internal/output/stat_boost
	special_mod_path = /obj/item/modification/organ/internal/deployable

	specific_input_type_pool = list(/datum/reagent/toxin/pararein)
	input_mode = CHEM_BLOOD
	output_pool = list(STAT_VIG)
	output_info = list(15)
	special_info = list(/obj/item/tool/armblade/jorogumo)
