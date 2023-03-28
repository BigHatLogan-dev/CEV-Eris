/obj/item/tool/armblade/jorogumo
	name = "Jorōgumo fang"
	desc = "A pair of arachnid fang-like blades deployed from your arms."
	icon = 'icons/obj/aberrant_organs/implants/jorogumo.dmi'
	icon_state = "jorogumo"
	item_state = "jorogumo"
	wielded_icon = "jorogumo_wielded"
	worksound = WORKSOUND_HARD_SLASH
	sharp = TRUE
	edge = FALSE
	force = WEAPON_FORCE_LETHAL
	w_class = ITEM_SIZE_HUGE
	attack_verb = list("stabbed", "imapled", "skewered")
	armor_divisor = ARMOR_PEN_DEEP
	tool_qualities = list(QUALITY_ADHESIVE = 20, QUALITY_SEALING = 20)
	bad_type = /obj/item/tool/armblade/jorogumo

/obj/item/tool/armblade/jorogumo/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	..()
	// Inject pararein, then aranecolmin
