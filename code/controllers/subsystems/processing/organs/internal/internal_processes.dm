PROCESSING_SUBSYSTEM_DEF(internal_organ_processes)
	name = "Internal Organ Processes"
	priority = 101 // Fires before mob Life()
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	process_proc = null     	// We're gonna use components instead of calling procs
