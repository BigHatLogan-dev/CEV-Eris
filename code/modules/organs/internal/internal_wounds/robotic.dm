/datum/component/internal_wound/robotic
	dupe_mode = COMPONENT_DUPE_ALLOWED	// Allows for stacking wounds
	diagnosis_stat = STAT_MEC
	diagnosis_difficulty = STAT_LEVEL_BASIC
	can_progress = FALSE				// No cascading failures like organics
	wound_nature = MODIFICATION_ORGANIC

// Blunt
/datum/component/internal_wound/robotic/blunt
	name = "mechanical malfunction"
	treatments = list(QUALITY_HAMMERING = FAILCHANCE_NORMAL)	// Nanopaste will be allowed as treatment via surgery steps
	scar = /datum/component/internal_wound/robotic/deformation
	severity = 2
	hal_damage = 1

/datum/component/internal_wound/robotic/blunt/deformation
	name = "bent structure"

/datum/component/internal_wound/robotic/blunt/crack
	name = "cracked frame"

// Sharp
/datum/component/internal_wound/robotic/sharp
	name = "perforation"
	treatments = list(QUALITY_SEALING = FAILCHANCE_NORMAL)	// Nanopaste will be allowed as treatment via surgery steps
	severity = 2
	tox_damage = 0.5	// Fluid leak

/datum/component/internal_wound/robotic/sharp/leak
	name = "weeping leak"

/datum/component/internal_wound/robotic/sharp/pressure
	name = "pressure failure"

// Edge
/datum/component/internal_wound/robotic/edge
	name = "electrical short"
	treatments = list(QUALITY_CLAMPING = FAILCHANCE_NORMAL)	// Wiring will be allowed as treatment via surgery steps
	severity = 2
	hal_damage = 1
	//burn_damage = 0.5

/datum/component/internal_wound/robotic/edge/cut
	name = "exposed wiring"

/datum/component/internal_wound/robotic/edge/arc
	name = "arcing"

// EMP/burn wounds
/datum/component/internal_wound/robotic/emp_burn
	name = "electrical malfunction"
	treatments = list(QUALITY_PULSING = FAILCHANCE_NORMAL)	// Wiring will be allowed as treatment via surgery steps
	severity = 2
	hal_damage = 1
	//burn_damage = 0.25

/datum/component/internal_wound/robotic/emp_burn/overheat
	name = "overheating component"
	treatments = list(QUALITY_PULSING = FAILCHANCE_NORMAL, CE_MECH_COOLING = 2)	// Wiring will be allowed as treatment via surgery steps
	//burn_damage = 0.5

// Tox
/datum/component/internal_wound/robotic/build_up
	name = "clogged filter"
	treatments = list(QUALITY_PRYING = FAILCHANCE_NORMAL)	// Pop it out and replace the filter
	severity = 1

/datum/component/internal_wound/robotic/build_up/fod
	name = "foreign object debris"

// Other wounds
/datum/component/internal_wound/robotic/corrosion
	name = "corrosion"
	treatments = list(CE_MECH_ACID = 1)
	scar = /datum/component/internal_wound/robotic/deformation
	severity = 2
	tox_damage = 0.5

/datum/component/internal_wound/robotic/corrosion/rust
	name = "rust"

/datum/component/internal_wound/robotic/deformation
	name = "plastic deformation"
	treatments = list(QUALITY_WELDING = FAILCHANCE_NORMAL)
	severity = 1
