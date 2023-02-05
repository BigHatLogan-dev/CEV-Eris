// Modular interaction behavior
// A replacement for item_attack()-like procs that follow a format of check -> charge consumption/progress bar -> do.
// Allows behaviors to be separated from objects, which reduces code duplication and gets around the quirks of object-oriented design.

/datum/component/check_use_do
	// Do not modify after init
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/action_signal					// Signal of the action we're using (COMSIG_ATTACKBY, COMSIG_IATTACK, etc.)
	var/check_path						// Path of the component/element used to check if the interaction can be carried out
	var/check_proc_name					// Name of the check proc
	var/check_signal					// Signal to be registered with the check proc
	// === OPTIONAL ===
	var/use_path						// Path of the component/element used for optional actions to be done between the check and the do_after
	var/use_proc_name					// Name of the use proc
	var/use_signal						// Signal to be registered with the use proc
	// ================
	var/list/do_after = list()			// Map of checked qualities to arguments to pass to the proc. Format: list(tool_quality = list(args))
	var/list/do_after_procs = list()	// Map of component/element paths to their desired signal procs
	var/list/do_after_signals = list()	// Signals to be registered with do_after procs, uses the order of do_after_procs at init

	// Can modify after init
	var/worktime = null				// How long the action should take
	var/difficulty = null			// How difficult it is to do
	var/required_stat = null		// Stat used in check, optional
	var/work_sound = null			// What sound it produces, optional
	var/failure_message = ""

/datum/component/check_use_do/Initialize(list/check_args, list/use_args, list/do_after_args, ...)
	. = ..()
	if(LAZYLEN(check_args) < 3 || LAZYLEN(do_after_args) < 3)
		return COMPONENT_INCOMPATIBLE

	check_path = check_args[1]
	check_proc_name = check_args[2]
	check_signal = check_args[3]

	if(LAZYLEN(use_args) > 2)
		use_path = use_args[1]
		use_proc_name = use_args[2]
		use_signal = use_args[3]

	do_after = do_after_args[1]
	do_after_procs = do_after_args[2]
	do_after_signals = do_after_args[3]

/datum/component/check_use_do/RegisterWithParent()
	RegisterSignal(parent, action_signal, PROC_REF(do_action))

	var/datum/element/check = AddElement(check_path)
	RegisterSignal(src, check_signal, TYPE_PROC_REF(check_path, check_proc_name))

	var/datum/element/use = AddElement(use_path)
	RegisterSignal(src, use_signal, TYPE_PROC_REF(use_path, use_proc_name))

	for(var/i in 1 to LAZYLEN(do_after_procs))
		var/element_path = do_after_procs[i]
		var/datum/element/interaction = AddElement(element_path)
		RegisterSignal(src, do_after_signals[i], TYPE_PROC_REF(element_path, do_after_procs[element_path]))

/datum/component/check_use_do/ClearFromParent()
	UnregisterSignal(parent, action_signal)
	UnregisterSignal(src, check_signal)
	UnregisterSignal(src, use_signal)
	for(var/signal in do_after_signals)
		UnregisterSignal(src, signal)

/datum/component/check_use_do/proc/do_action(atom/source_ref, obj/item/I, mob/user)
	SIGNAL_HANDLER
	// Check
	var/quality_used = SEND_SIGNAL(src, check_signal, I, user, do_after)

	// Use (if applicable), then do
	if(quality_used)
		if(!use_path || SEND_SIGNAL(src, use_signal, I, user, parent, worktime, quality_used, difficulty, required_stat, work_sound))
			var/index
			if(LAZYLEN(do_after_procs) == 1 && LAZYLEN(do_after_signals) == 1)
				index = 1
			else
				index = do_after.Find(quality_used)
			var/result_signal = do_after_signals[index]
			var/cleanup = SEND_SIGNAL(src, result_signal, parent, do_after[quality_used])
			switch(cleanup)
				if(CUD_DETACH_ELEMENT)
					UnregisterSignal(src, do_after_signals[index])
					LAZYREMOVE(do_after, index)
					LAZYREMOVE(do_after_procs, index)
					LAZYREMOVE(do_after_signals, index)
					if(!LAZYLEN(do_after))
						qdel(src)
				if(CUD_QDEL_COMPONENT)
					qdel(src)
			return TRUE
	else
		to_chat(user, SPAN_NOTICE(failure_message))
		return FALSE
