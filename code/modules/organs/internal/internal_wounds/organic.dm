/datum/component/internal_wound/organic
	diagnosis_stat = STAT_BIO
	diagnosis_difficulty = STAT_LEVEL_ADEPT
	can_progress = TRUE

// Blunt
/datum/component/internal_wound/organic/rupture
	treatments = list(QUALITY_CAUTERIZING = FAILCHANCE_NORMAL, CE_BLOODCLOT = 0.55)	// Tricordrazine/polystem + bicaridine + meralyne OR quickclot OD
	severity = 1
	can_progress = FALSE
	hal_damage = 2

// Sharp
/datum/component/internal_wound/organic/perforation
	treatments = list(QUALITY_CAUTERIZING = FAILCHANCE_NORMAL, CE_BLOODCLOT = 0.75)	// Tricordrazine + polystem + bicaridine + meralyne	+ quickclot
	severity = 1
	next_wound = /datum/component/internal_wound/organic/swelling
	hal_damage = 2

// Edge
/datum/component/internal_wound/organic/laceration
	treatments = list(QUALITY_CAUTERIZING = FAILCHANCE_NORMAL, CE_BLOODCLOT = 0.75)	// Tricordrazine + polystem + bicaridine + meralyne	+ quickclot
	severity = 1
	next_wound = /datum/component/internal_wound/organic/swelling
	hal_damage = 2

// Secondary wounds
/datum/component/internal_wound/organic/swelling
	treatments = list(QUALITY_CUTTING = FAILCHANCE_NORMAL, CE_ANTIBIOTIC = 3) // 5u Spaceacillin or spaceacillin + dylovene
	severity = 0	// Does nothing, at first
	next_wound = /datum/component/internal_wound/sepsis
	hal_damage = 3
	tox_damage = 0.2
	specific_organ_size_multiplier = 0.1

// Other wounds
/datum/component/internal_wound/organic/blood_loss
	treatments = list(CE_OXYGENATED = 2)	// Dex+ treats, but it will come back if you don't get blood
	severity = 0
	max_severity = 10
	progression_threshold = 3	// Kills the organ in approx. 1 minute
