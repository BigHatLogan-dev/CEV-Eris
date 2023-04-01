/obj/item/tool/armblade/kouchiku
	name = "Kouchiku fang"
	desc = "A pair of Kouchiku fang-like blades deployed from your arms."
	icon = 'icons/obj/aberrant_organs/implants/kouchiku.dmi'
	icon_state = "kouchiku"
	item_state = "kouchiku"
	wielded_icon = "kouchiku_wielded"
	worksound = WORKSOUND_HARD_SLASH
	sharp = TRUE
	edge = FALSE
	force = WEAPON_FORCE_LETHAL
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("stabbed", "imapled", "skewered")
	armor_divisor = ARMOR_PEN_DEEP
	tool_qualities = list(QUALITY_ADHESIVE = 20, QUALITY_SEALING = 20)
	bad_type = /obj/item/tool/armblade/kouchiku

/obj/item/tool/armblade/kouchiku/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	..()
	// Inject pararein, then aranecolmin
