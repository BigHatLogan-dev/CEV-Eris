/obj/item/gun/matter/regenerating
	bad_type = /obj/item/gun/matter/regenerating
	var/ticks_until_regen = 1

/obj/item/gun/matter/regenerating/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/gun/matter/regenerating/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()
	
/obj/item/gun/matter/regenerating/Process()
	if(ticks_until_regen > 0)
		--ticks_until_regen
		return
	if(stored_matter < max_stored_matter)
		stored_matter += 1
		ticks_until_regen = initial(ticks_until_regen)
