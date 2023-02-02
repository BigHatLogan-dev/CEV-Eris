// Special
// Blattedin receptor (full organ, unable to be dissected) - blattedin input, resus output, single use
// Seuche sac - reagent gas
// Gestrahlte gland - reagent spit

// Generic
// roach toxin hepatic/gastric organoid/membrane - roach toxin output
// ovarian - produces eggs, cubes
// oesophagal - eat organs, roaches

// Non-roach needs
// Input organoid that can trigger the aberrant process at-will, somatic organoid. Unrelated: autonomic organoid could allow process to trigger for free each cycle.

/obj/item/organ/internal/scaffold/aberrant/roach
	name = "roach organ"
	ruined_name = "roach organ scaffold"
	desc = "An organ harvested from a roach."
	ruined_desc = null
	description_info = "A modular organ with four slots for organ mods or organoids."
	ruined_description_info = null
	rarity_value = 20
	spawn_tags = SPAWN_TAG_ABERRANT_ORGAN_ROACH
	spawn_blacklisted = TRUE	// Go butcher roaches
	bad_type = /obj/item/organ/internal/scaffold/aberrant/roach
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
