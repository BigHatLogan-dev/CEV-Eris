// Food processing (tenderizing, mincing, etc.), not to be confused with any food-related Process() procs

/datum/component/food_processing
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/list/usable_qualities = list()	// Used to initialize processing elements, do not modify without modifying elements
	var/datum/element/root_node		// Reference to the root of the node tree

/datum/component/food_processing/RegisterWithParent()
	RegisterSignal(parent, COMSIG_IATTACK, PROC_REF(on_item_attack))

/datum/component/food_processing/ClearFromParent()
	UnregisterSignal(parent, COMSIG_IATTACK)

/datum/component/food_processing/proc/on_item_attack(atom/source_ref, obj/item/I, mob/user)
	SIGNAL_HANDLER
	var/tool_type = I.get_tool_type(user, usable_qualities)

	if(tool_type)
		if(SEND_SIGNAL(src, COMSIG_FOOD_PROC_DO, I, tool_type))
			return TRUE
