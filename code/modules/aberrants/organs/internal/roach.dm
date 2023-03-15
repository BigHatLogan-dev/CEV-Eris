// Special
// Gestrahlte gland - reagent spit, applies rads on melee

// Generic
// roach toxin hepatic/gastric organoid/membrane - roach toxin output

/obj/item/organ/internal/scaffold/aberrant/roach
	name = "roach organ"
	ruined_name = "roach organ"
	desc = "An organ harvested from a roach."
	ruined_desc = null
	description_info = "A modular organ with four slots for organ mods or organoids."
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	ruined_description_info = null
	rarity_value = 20
	spawn_tags = SPAWN_TAG_ABERRANT_ORGAN_MAINT
	spawn_blacklisted = TRUE
	bad_type = /obj/item/organ/internal/scaffold/aberrant/roach
	b_type = "Ü~"				// Will trigger rejection
	max_upgrades = 4
	use_generated_name = FALSE
	organ_type = "roach"
	aberrant_cooldown_time = ROACH_ABERRANT_COOLDOWN

/obj/item/organ/internal/scaffold/aberrant/roach/update_color()
	..()
	if(!generated_color)
		generated_color = "[rand(1,4)]"

/obj/item/organ/internal/scaffold/aberrant/roach/fuhrer
	name = "Fuhrer organ"
	ruined_name = "Fuhrer organ"
	desc = "An organ harvested from a Fuhrer roach."
	description_info = "A modular organ with five slots for organ mods or organoids."
	icon_state = "organ_scaffold-fuhrer"
	rarity_value = 60
	max_upgrades = 5
	use_generated_color = FALSE
	use_generated_icon = FALSE
	use_generated_name = FALSE

/obj/item/organ/internal/scaffold/aberrant/roach/kaiser
	name = "Kaiser organ"
	ruined_name = "Kaiser organ"
	desc = "An organ harvested from a Kaiser roach."
	description_info = "A modular organ with seven slots for organ mods or organoids."
	icon_state = "organ_scaffold-kaiser"
	rarity_value = 120
	max_upgrades = 7
	use_generated_color = FALSE
	use_generated_icon = FALSE
	use_generated_name = FALSE

/obj/item/organ/internal/scaffold/aberrant/roach/seuche
	name = "Seuche sac"

	use_generated_color = FALSE
	use_generated_icon = FALSE
	use_generated_name = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/consume
	process_mod_path = /obj/item/modification/organ/internal/process/multiplier
	output_mod_path = /obj/item/modification/organ/internal/output/chem_smoke/roach
	special_mod_path = /obj/item/modification/organ/internal/special/on_cooldown/stat_boost
	specific_input_type_pool = STANDARD_ORGANIC_CONSUMABLES
	input_mode = NOT_USED
	process_info = list(0.50)
	output_pool = list(/datum/reagent/toxin/blattedin)
	output_info = REAGENTS_ROACH
	special_info = list(STAT_TGH, 15)

/obj/item/organ/internal/scaffold/aberrant/roach/gestrahlte
	name = "Gestrahlte gland"

	use_generated_color = FALSE
	use_generated_icon = FALSE
	use_generated_name = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/reagents
	process_mod_path = /obj/item/modification/organ/internal/process/multiplier
	output_mod_path = /obj/item/modification/organ/internal/output/stat_boost
	special_mod_path = /obj/item/modification/organ/internal/deployable
	specific_input_type_pool = list(/datum/reagent/toxin/blattedin)
	input_mode = CHEM_INGEST
	process_info = list(0.50)
	output_pool = list(STAT_TGH)
	output_info = list(15)
	special_info = list(/obj/item/gun/projectile/automatic/armsmg)	// Should be roach gun
