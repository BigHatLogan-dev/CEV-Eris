/datum/element/check_tool
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

/datum/element/check_tool/proc/do_check_tool(datum/source_ref, obj/item/tool, mob/user, list/desired_qualities)
	SIGNAL_HANDLER
	return tool.get_tool_type(user, desired_qualities)
