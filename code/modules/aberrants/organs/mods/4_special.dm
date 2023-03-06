/obj/item/modification/organ/internal/special
	name = "membrane"
	desc = "A graftable outer membrane for organ tissues."
	icon_state = "membrane"
	bad_type = /obj/item/modification/organ/internal/special

/obj/item/modification/organ/internal/special/update_icon()
	icon_state = initial(icon_state) + "-[rand(1,5)]"

/obj/item/modification/organ/internal/special/on_item_examine
	bad_type = /obj/item/modification/organ/internal/special/on_item_examine

/obj/item/modification/organ/internal/special/on_item_examine/brainloss
	name = "eldritch membrane"
	desc = "A graftable outer membrane for organ tissues. The alien textures are painful to look at."

/obj/item/modification/organ/internal/special/on_item_examine/brainloss/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null)
	AddComponent(/datum/component/modification/organ/on_item_examine/brainloss)
	..()


/obj/item/modification/organ/internal/special/on_pickup

/obj/item/modification/organ/internal/special/on_pickup/shock
	name = "shocking membrane"
	desc = "A graftable outer membrane for organ tissues. There is bioelectric phenomena present and it hurts to touch."
	icon_state = "membrane-hive"

/obj/item/modification/organ/internal/special/on_pickup/shock/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null)
	AddComponent(/datum/component/modification/organ/on_pickup/shock)
	..()

/obj/item/modification/organ/internal/special/on_pickup/shock/update_icon()
	return

/obj/item/modification/organ/internal/special/on_pickup/shock/powerful
	name = "powerful shocking membrane"
	desc = "A graftable outer membrane for organ tissues. There is significant bioelectric phenomena present and it hurts to touch."
	
/obj/item/modification/organ/internal/special/on_pickup/shock/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null)
	AddComponent(/datum/component/modification/organ/on_pickup/shock/powerful)
	..()


/obj/item/modification/organ/internal/special/on_cooldown
	bad_type = /obj/item/modification/organ/internal/special/on_cooldown

/obj/item/modification/organ/internal/special/on_cooldown/chemical_effect
	name = "endocrinal membrane"
	desc = "A graftable membrane for organ tissues. Secretes hormones when the primary organ function triggers."
	description_info = "Produces a hormone when the primary function triggers."
	var/effect_path = null

/obj/item/modification/organ/internal/special/on_cooldown/chemical_effect/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/chosen_special_info)
	var/datum/component/modification/organ/on_cooldown/chemical_effect/S = AddComponent(/datum/component/modification/organ/on_cooldown/chemical_effect)

	if(chosen_special_info?.len >= 2)
		S.effect = chosen_special_info[1]
	else if(effect_path)
		S.effect = effect_path
	..()

/obj/item/modification/organ/internal/special/on_cooldown/stat_boost
	name = "intracrinal membrane"
	desc = "A graftable membrane for organ tissues. Secretes stimulating hormones when the primary organ function triggers."
	description_info = "Slightly increases a stat when the primary function triggers."
	var/stat = null
	var/modifier = 10

/obj/item/modification/organ/internal/special/on_cooldown/stat_boost/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/chosen_special_info)
	var/datum/component/modification/organ/on_cooldown/stat_boost/S = AddComponent(/datum/component/modification/organ/on_cooldown/stat_boost)

	if(chosen_special_info?.len >= 2)
		S.stat = chosen_special_info[1]
		S.boost = chosen_special_info[2]
	else if(stat)
		S.stat = stat
		S.boost = modifier
	..()

/obj/item/modification/organ/internal/special/symbiotic
	name = "parasitic organoid"
	desc = "Functional tissue of one or more organs in graftable form. Inhibits organ functions, but allows for painful implantation of organs."
	icon_state = "parasitic_organoid"
	var/organ_mod = -0.10

/obj/item/modification/organ/internal/special/symbiotic/Initialize(loc, generate_organ_stats = TRUE, predefined_modifier = organ_mod)
	var/datum/component/modification/organ/symbiotic/P = AddComponent(/datum/component/modification/organ/symbiotic)
	P.specific_organ_size_multiplier = 0.10
	..()

/obj/item/modification/organ/internal/special/symbiotic/update_icon()
	return

/obj/item/modification/organ/internal/special/symbiotic/commensal
	name = "commensalistic organoid"
	desc = "Functional tissue of one or more organs in graftable form. Allows for painful implantation of organs."
	organ_mod = null

/obj/item/modification/organ/internal/special/symbiotic/mutual
	name = "mutualistic organoid"
	desc = "Functional tissue of one or more organs in graftable form. Supplements organ functions and allows for painful implantation of organs."
	organ_mod = 0.1
