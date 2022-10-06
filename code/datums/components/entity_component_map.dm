// Map of entities to their components and objects
/datum/entity_component_map
    var/list/entity_to_obj_map = list()     // Maps entities (ID is the element num) to /obj, list(/obj, /obj, ...)
	var/list/entity_to_comp_map = list()	// Maps entities (ID is the element num) to components, list(list(/datum/component, /datum/component, ...))
	var/list/free_slots = list()		    // For keeping track of available IDs (usualy from destroying an entity), list(33, 12, 1, ...)
	var/entity_count = 0			    	// Used for creating entity IDs

/datum/entity_component_map/proc/add_component(id, datum/component/component)
	var/list/comp_contents = entity_to_comp_map[id]
	comp_contents += component

/datum/entity_component_map/proc/remove_component(id, datum/component/component)
	var/list/comp_contents = entity_to_comp_map[id]
	comp_contents -= component

/datum/entity_component_map/proc/on_entity_delete(id)
	entity_to_comp_map[id] = null
	free_slots += list(id)

/datum/entity_component_map/proc/on_entity_add(list/components)
	var/new_id
	var/list/comp_contents = components
	if(free_slots.len)
		new_id = free_slots[1]
		free_slots.Cut(1, 2)
		entity_to_comp_map[new_id] = comp_contents
	else
		++entity_count
		entity_to_comp_map.Add(comp_contents)
