// Infection 2.0. This will spread to every organ in your body if untreated. Progresses until death.
/datum/component/internal_wound/infection
	name = "infection"
	treatments = list(CE_ANTIBIOTIC = 5)	// 10u Spaceacillin or 5u spaceacillin + dylovene
	severity = 0
	severity_max = 10
	progression_threshold = 90	// 3 minutes
	hal_damage = 1
	tox_damage = 0.5
	can_spread = TRUE
	spread_threshold = 6
