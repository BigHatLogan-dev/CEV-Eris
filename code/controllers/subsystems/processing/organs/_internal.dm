// Fuck it. Just copy Austin Morlan's ECS.
// This is a horrendous implementation of ECS, but it's the best I can do given most of this codebase is object-oriented
// We can treat the organ obj as the coordinator and component manager since it will already have other behaviors associated with it.
// /datum/entity_component_map keeps track of entity IDs and their associated components
// Internal Organ Manager is the system manager
// Wounds and Processes will be systems
PROCESSING_SUBSYSTEM_DEF(internal_organs_manager)
	name = "Internal Organs Manager"
	priority = 101 // Fires before mob Life()
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	wait = 2 SECONDS
	process_proc = null     	// We're gonna use components instead of calling procs
	var/datum/entity_component_map/organ_map		// Initialize and pass this into the managed subsytems in the future

///datum/controller/subsystem/processing/internal_organs_manager/Initialize()
	//organ_map = new /datum/entity_component_map
	//..()

///datum/controller/subsystem/processing/internal_organs_manager/fire(resumed = FALSE)
	//SSinternal_Wounds.fire(resumed, organ_map)
	//SSinternal_organ_processes.fire(resumed, organ_map)
