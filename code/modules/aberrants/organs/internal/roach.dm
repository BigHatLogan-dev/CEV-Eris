// Special
// Blattedin receptor (full organ, unable to be dissected) - blattedin input, resus output, single use
// Gestrahlte gland - reagent spit

// Generic
// roach toxin hepatic/gastric organoid/membrane - roach toxin output

/obj/item/organ/internal/scaffold/aberrant/roach
	name = "roach organ"
	ruined_name = "roach organ scaffold"
	desc = "An organ harvested from a roach."
	ruined_desc = null
	description_info = "A modular organ with four slots for organ mods or organoids."
	ruined_description_info = null
	rarity_value = 20
	spawn_tags = SPAWN_TAG_ABERRANT_ORGAN_ROACH
	spawn_blacklisted = TRUE
	bad_type = /obj/item/organ/internal/scaffold/aberrant/roach
	b_type = "Ü~"				// Will trigger rejection
	max_upgrades = 4
	aberrant_cooldown_time = ROACH_ABERRANT_COOLDOWN

/obj/item/organ/internal/scaffold/aberrant/roach/fuhrer
	name = "Fuhrer organ"
	ruined_name = "Fuhrer organ scaffold"
	desc = "An organ harvested from a Fuhrer roach."
	description_info = "A modular organ with five slots for organ mods or organoids."
	rarity_value = 60
	max_upgrades = 5

/obj/item/organ/internal/scaffold/aberrant/roach/kaiser
	name = "Kaiser organ"
	ruined_name = "Kaiser organ scaffold"
	desc = "An organ harvested from a Kaiser roach."
	description_info = "A modular organ with seven slots for organ mods or organoids."
	rarity_value = 120
	max_upgrades = 7

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
	process_info = list(0.50)
	output_pool = list(/datum/reagent/toxin/blattedin)
	special_info = list(STAT_ROB, 15)
