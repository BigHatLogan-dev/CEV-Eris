/obj/item/gun/matter/regenerating/gestrahlte_gland
	name = "Gestrahlte gland"
	icon = 'icons/obj/aberrant_organs/implants/gestrahlte_gland.dmi'
	icon_state = "gestrahlte_gland"
	bad_type = /obj/item/gun/matter/regenerating/gestrahlte_gland
	force = WEAPON_FORCE_NORMAL
	damtype = TOX
	fire_delay = 10
	fire_sound = 'sound/effects/blobattack.ogg'
	max_stored_matter = 5
	projectile_type = /obj/item/projectile/roach_spit
	ticks_until_regen = 1	// Every other tick
