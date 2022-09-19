/datum/component/internal_wound/robotic
	dupe_mode = COMPONENT_DUPE_ALLOWED	// Allows for stacking wounds
	diagnosis_stat = STAT_MEC
	diagnosis_difficulty = STAT_LEVEL_BASIC
	can_progress = FALSE				// No cascading failures like organics, more individually damaging

// Blunt
/datum/component/internal_wound/robotic/structural_damage
	treatments = list(QUALITY_WELDING = FAILCHANCE_NORMAL)	// Nanopaste will be allowed as treatment via surgery steps
	severity = 1
	hal_damage = 2

// Sharp
/datum/component/internal_wound/robotic/leak
	treatments = list(QUALITY_SEALING = FAILCHANCE_NORMAL)	// Nanopaste will be allowed as treatment via surgery steps
	severity = 1
	tox_damage = 1	// Hydraulic fluid leak

// Edge
/datum/component/internal_wound/robotic/short
	treatments = list(QUALITY_CLAMPING = FAILCHANCE_NORMAL)	// Wiring will be allowed as treatment via surgery steps
	severity = 1
	hal_damage = 3
	burn_damage = 0.2

// EMP wounds
/datum/component/internal_wound/robotic/malfunction
	treatments = list(QUALITY_PULSING = FAILCHANCE_NORMAL)	// Wiring will be allowed as treatment via surgery steps
	severity = 1
	hal_damage = 5
	burn_damage = 0.1

/datum/component/internal_wound/robotic/overheat
	treatments = list(QUALITY_PULSING = FAILCHANCE_NORMAL, CE_MECH_COOLING = 2)	// Wiring will be allowed as treatment via surgery steps
	severity = 0
	severity_max = 10
	can_progress = FALSE
	hal_damage = 1
	burn_damage = 0.25
