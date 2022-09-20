/datum/component/internal_wound/organic
	diagnosis_stat = STAT_BIO
	diagnosis_difficulty = STAT_LEVEL_ADEPT
	can_progress = TRUE

// Blunt
/datum/component/internal_wound/organic/blunt
	name = "rupture"
	treatments = list(QUALITY_CAUTERIZING = FAILCHANCE_NORMAL, CE_BLOODCLOT = 0.55)	// Tricordrazine/polystem + bicaridine + meralyne OR quickclot OD
	severity = 1
	hal_damage = 1

/datum/component/internal_wound/organic/blunt/bruising
	name = "severe bruising"

/datum/component/internal_wound/organic/blunt/trauma
	name = "blunt trauma"

/datum/component/internal_wound/organic/blunt/hemorrhage
	name = "internal hemorrhage"

/datum/component/internal_wound/organic/blunt/bruising
	name = "contusion"

// Sharp
/datum/component/internal_wound/organic/sharp
	name = "perforation"
	treatments = list(QUALITY_CAUTERIZING = FAILCHANCE_NORMAL, CE_BLOODCLOT = 0.75)	// Tricordrazine + polystem + bicaridine + meralyne	+ quickclot
	severity = 1
	next_wound = /datum/component/internal_wound/organic/swelling
	hal_damage = 1

/datum/component/internal_wound/organic/sharp/cavity
	name = "cavitation"

/datum/component/internal_wound/organic/sharp/puncture
	name = "puncture"

/datum/component/internal_wound/organic/sharp/trauma
	name = "penetrating trauma"

/datum/component/internal_wound/organic/sharp/gore
	name = "gored flesh"

// Edge
/datum/component/internal_wound/organic/edge
	name = "laceration"
	treatments = list(QUALITY_CAUTERIZING = FAILCHANCE_NORMAL, CE_BLOODCLOT = 0.75)	// Tricordrazine + polystem + bicaridine + meralyne	+ quickclot
	severity = 1
	next_wound = /datum/component/internal_wound/organic/swelling
	hal_damage = 1

/datum/component/internal_wound/organic/edge/gash
	name = "deep gash"

/datum/component/internal_wound/organic/edge/rip
	name = "ripped tissue"

/datum/component/internal_wound/organic/edge/tear
	name = "torn tissue"

/datum/component/internal_wound/organic/edge/cut
	name = "leaking cut"

// Burn
/datum/component/internal_wound/organic/burn
	name = "scorched tissue"
	treatments = list(QUALITY_CUTTING = FAILCHANCE_NORMAL)	// No chem treatment, must be cut away
	scar = /datum/component/internal_wound/organic/damaged_tissue
	severity = 0
	severity_max = 10
	next_wound = /datum/component/internal_wound/infection
	tox_damage = 0.25

/datum/component/internal_wound/organic/damaged_tissue
	name = "recovering tissue"
	treatments = list(CE_OXYGENATED = 2)
	severity = 1
	can_progress = FALSE

// Tox/chem OD
/datum/component/internal_wound/organic/poisoning
	name = "toxin accumulation"
	treatments = list(CE_PURGER = 3)	// No anti-tox cure, poisoning can occur as a result of too much anti-tox
	severity = 0
	hal_damage = 3
	tox_damage = 0.5

/datum/component/internal_wound/organic/poisoning/chem
	name = "chemical poisoning"

// Secondary wounds
/datum/component/internal_wound/organic/swelling
	name = "swelling"
	treatments = list(QUALITY_CUTTING = FAILCHANCE_NORMAL, CE_ANTIBIOTIC = 3) // 5u Spaceacillin or spaceacillin + dylovene
	severity = 0	// Does nothing, at first
	next_wound = /datum/component/internal_wound/infection
	hal_damage = 1.5
	tox_damage = 0.25
	specific_organ_size_multiplier = 0.2

/datum/component/internal_wound/organic/swelling/abcess
	name = "abcess"

// Other wounds
/datum/component/internal_wound/organic/blood_loss
	treatments = list(CE_OXYGENATED = 2, CE_BLOODRESTORE = 0.01)	// Dex+ treats, but it will come back if you don't get blood
	severity = 0
	severity_max = 10
	progression_threshold = 3	// Kills the organ in approx. 1 minute
