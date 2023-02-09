/datum/element/use_tool
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

/datum/element/use_tool/Attach(datum/target, sigtype)
	..()
	RegisterSignal(target, sigtype, PROC_REF(do_use_tool))

/datum/element/use_tool/proc/do_use_tool(datum/source_ref, obj/item/tool, mob/user, atom/target, worktime, tool_quality, failchance, required_stat, work_sound)
	SIGNAL_HANDLER
	return tool.use_tool(user, target, worktime, tool_quality, failchance, required_stat, forced_sound = work_sound) ? TRUE : FALSE
