/datum/element/check_tool
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

/datum/element/check_tool/Attach(datum/target, sigtype)
	..()
	RegisterSignal(target, sigtype, PROC_REF(do_check_tool))

/datum/element/check_tool/proc/do_check_tool(datum/source_ref, obj/item/tool, mob/user, list/desired_qualities, list/quality_used)
	SIGNAL_HANDLER
	var/quality = tool.get_tool_type(user, desired_qualities)
	LAZYADD(quality_used, quality)
	return quality ? TRUE : FALSE
