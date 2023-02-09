// Modular interaction behavior
// A replacement for attackby()-like procs that follow a format of check -> charge consumption/progress bar -> do.
// Allows behaviors to be separated from objects, which reduces code duplication and gets around the quirks of object-oriented design.

/datum/component/check_use_do
	// Do not modify after init
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/action_signal					// Signal of the action we're using (COMSIG_ATTACKBY, COMSIG_IATTACK, etc.)
	var/check_signal					// Signal to be registered with the check proc
	var/use_signal						// Signal to be registered with the use proc, optional
	var/list/do_after = list()			// Map of checked qualities to arguments to pass to the proc. Format: list(tool_quality = list(args))
	var/list/do_after_signals = list()	// Signals to be registered with do_after procs, uses the order of do_after

	// Can modify after init
	var/worktime = null				// How long the action should take
	var/difficulty = null			// How difficult it is to do
	var/required_stat = null		// Stat used in check, optional
	var/work_sound = null			// What sound it produces, optional
	var/failure_message = ""

/datum/component/check_use_do/Initialize(action, list/check_args, list/use_args, list/do_after_args, ...)
	. = ..()
	if(LAZYLEN(check_args) < 2 || LAZYLEN(do_after_args) < 3)
		return COMPONENT_INCOMPATIBLE

	action_signal = action
	check_signal = check_args[2]

	AddElement(check_args[1], check_args[2])

	if(LAZYLEN(use_args) > 1)
		use_signal = use_args[2]
		AddElement(use_args[1], use_args[2])

	do_after = do_after_args[1]
	var/list/do_after_paths = do_after_args[2]
	do_after_signals = do_after_args[3]
	for(var/i in 1 to LAZYLEN(do_after_paths))
		AddElement(do_after_paths[i], do_after_signals[i])

/datum/component/check_use_do/RegisterWithParent()
	RegisterSignal(parent, action_signal, PROC_REF(do_action))

/datum/component/check_use_do/ClearFromParent()
	UnregisterSignal(parent, action_signal)
	UnregisterSignal(src, check_signal)
	UnregisterSignal(src, use_signal)
	for(var/signal in do_after_signals)
		UnregisterSignal(src, signal)

/datum/component/check_use_do/proc/do_action(obj/item/I, mob/user)
	SIGNAL_HANDLER

	var/quality_used
	var/list/return_data = list()
	SEND_SIGNAL(src, check_signal, I, user, do_after, return_data)	// Check
	if(LAZYLEN(return_data))
		quality_used = return_data[1]

	if(quality_used)
		if(!use_signal || SEND_SIGNAL(src, use_signal, I, user, parent, worktime, quality_used, difficulty, required_stat, work_sound))	// Use
			var/index
			if(LAZYLEN(do_after_signals) == 1)
				index = 1
			else
				index = do_after.Find(quality_used)
			var/result_signal = do_after_signals[index]
			if(SEND_SIGNAL(src, result_signal, parent, do_after[quality_used]))	// Do
				qdel(src)
			else
				UnregisterSignal(src, do_after_signals[index])
				LAZYREMOVE(do_after, index)
				LAZYREMOVE(do_after_signals, index)
				if(!LAZYLEN(do_after_signals))
					qdel(src)
			return TRUE
	else
		to_chat(user, SPAN_NOTICE(failure_message))
		return FALSE
