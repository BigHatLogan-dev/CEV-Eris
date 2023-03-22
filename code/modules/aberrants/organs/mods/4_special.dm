// =================================================
// ===============     MEMBRANES     ===============
// =================================================

/obj/item/modification/organ/internal/on_item_examine
	bad_type = /obj/item/modification/organ/internal/on_item_examine

/obj/item/modification/organ/internal/on_item_examine/brainloss
	name = "eldritch membrane"
	desc = "A graftable outer membrane for organ tissues. The alien textures are painful to look at."

/obj/item/modification/organ/internal/on_item_examine/brainloss/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null)
	AddComponent(/datum/component/modification/organ/on_item_examine/brainloss)
	..()


/obj/item/modification/organ/internal/on_pickup

/obj/item/modification/organ/internal/on_pickup/shock
	name = "shocking membrane"
	desc = "A graftable outer membrane for organ tissues. There is bioelectric phenomena present and it hurts to touch."
	icon_state = "membrane-hive"

/obj/item/modification/organ/internal/on_pickup/shock/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null)
	AddComponent(/datum/component/modification/organ/on_pickup/shock)
	..()

/obj/item/modification/organ/internal/on_pickup/shock/update_icon()
	return

/obj/item/modification/organ/internal/on_pickup/shock/powerful
	name = "powerful shocking membrane"
	desc = "A graftable outer membrane for organ tissues. There is significant bioelectric phenomena present and it hurts to touch."
	
/obj/item/modification/organ/internal/on_pickup/shock/powerful/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null)
	AddComponent(/datum/component/modification/organ/on_pickup/shock/powerful)
	..()


/obj/item/modification/organ/internal/on_cooldown
	bad_type = /obj/item/modification/organ/internal/on_cooldown

/obj/item/modification/organ/internal/on_cooldown/chemical_effect
	name = "endocrinal membrane"
	desc = "A graftable membrane for organ tissues. Secretes hormones when the primary organ function triggers."
	description_info = "Produces a hormone when the primary function triggers."
	var/effect_path = null

/obj/item/modification/organ/internal/on_cooldown/chemical_effect/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/chosen_special_info)
	var/datum/component/modification/organ/on_cooldown/chemical_effect/S = AddComponent(/datum/component/modification/organ/on_cooldown/chemical_effect)

	if(chosen_special_info?.len >= 1)
		S.effect = chosen_special_info[1]
	else if(effect_path)
		S.effect = effect_path
	..()

/obj/item/modification/organ/internal/on_cooldown/reagents_blood
	name = "hepatic membrane"
	desc = "A graftable membrane for organ tissues. Secretes a reagent when the primary organ function triggers."
	description_info = "Produces a reagent when the primary function triggers."
	var/reagent_path = null

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/chosen_special_info)
	var/datum/component/modification/organ/on_cooldown/reagents_blood/S = AddComponent(/datum/component/modification/organ/on_cooldown/reagents_blood)

	if(chosen_special_info?.len >= 1)
		S.reagent = chosen_special_info[1]
	else if(reagent_path)
		S.reagent = reagent_path
	..()

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/blattedin
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-roach-1"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/blattedin

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/diplopterum
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-roach-2"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/diplopterum

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/seligitillin
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-roach-3"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/seligitillin

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/starkellin
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-roach-4"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/starkellin

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/gewaltine
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-roach-5"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/gewaltine

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/fuhrerole
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-fuhrer"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/fuhrerole

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/kaiseraurum
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "membrane-kaiser"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/kaiseraurum

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/pararein
	icon = 'icons/obj/aberrant_organs/arachno_organs.dmi'
	icon_state = "membrane-arachno-1"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/pararein

/obj/item/modification/organ/internal/on_cooldown/reagents_blood/aranecolmin
	icon = 'icons/obj/aberrant_organs/arachno_organs.dmi'
	icon_state = "membrane-arachno-2"
	use_generated_icon = FALSE
	reagent_path = /datum/reagent/toxin/aranecolmin

/obj/item/modification/organ/internal/on_cooldown/stat_boost
	name = "intracrinal membrane"
	desc = "A graftable membrane for organ tissues. Secretes stimulating hormones when the primary organ function triggers."
	description_info = "Slightly increases a stat when the primary function triggers."
	var/stat = null
	var/modifier = 10

/obj/item/modification/organ/internal/on_cooldown/stat_boost/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/chosen_special_info)
	var/datum/component/modification/organ/on_cooldown/stat_boost/S = AddComponent(/datum/component/modification/organ/on_cooldown/stat_boost)

	if(chosen_special_info?.len >= 2)
		S.stat = chosen_special_info[1]
		S.boost = chosen_special_info[2]
	else if(stat)
		S.stat = stat
		S.boost = modifier
	..()

// =================================================
// ===============     ORGANOIDS     ===============
// =================================================

/obj/item/modification/organ/internal/symbiotic
	name = "parasitic organoid"
	icon_state = "parasitic_organoid"
	desc = "Functional tissue of one or more organs in graftable form. Inhibits organ functions, but allows for painful implantation of organs."
	use_generated_icon = FALSE
	var/organ_mod = -0.10

/obj/item/modification/organ/internal/symbiotic/Initialize(loc, generate_organ_stats = TRUE, predefined_modifier = organ_mod, list/chosen_special_info)
	var/datum/component/modification/organ/symbiotic/S = AddComponent(/datum/component/modification/organ/symbiotic)
	S.specific_organ_size_multiplier = 0.10
	..()

/obj/item/modification/organ/internal/symbiotic/commensal
	name = "commensalistic organoid"
	desc = "Functional tissue of one or more organs in graftable form. Allows for painful implantation of organs."
	organ_mod = null

/obj/item/modification/organ/internal/symbiotic/mutual
	name = "mutualistic organoid"
	desc = "Functional tissue of one or more organs in graftable form. Supplements organ functions and allows for painful implantation of organs."
	organ_mod = 0.1

/obj/item/modification/organ/internal/deployable
	name = "protractile organoid"
	icon_state = "parasitic_organoid"		// temp
	desc = "Functional tissue of one or more organs in graftable form. Allows for protraction/retraction of an appendage."

/obj/item/modification/organ/internal/deployable/Initialize(loc, generate_organ_stats = FALSE, predefined_modifier = null, list/special_args)
	var/datum/component/modification/organ/deployable/D = AddComponent(/datum/component/modification/organ/deployable)
	D.stored_type = special_args[1]
	..()

/obj/item/modification/organ/internal/deployable/gestrahlte
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	icon_state = "output_organoid-gestrahlte"
	use_generated_icon = FALSE
