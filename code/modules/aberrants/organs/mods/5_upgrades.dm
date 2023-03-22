/obj/item/modification/organ/internal/stromal
	name = "stromal organoid"
	icon = 'icons/obj/aberrant_organs/organ_mods.dmi'
	bad_type = /obj/item/modification/organ/internal/stromal

/obj/item/modification/organ/internal/stromal/update_icon()
	return

// Printable mods

/obj/item/modification/organ/internal/stromal/requirements
	name = "improved capillaries"
	desc = "A set of modified capillaries that improve substance transfer within an organ."
	icon_state = "capillary"

/obj/item/modification/organ/internal/stromal/requirements/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.blood_req_multiplier = -0.50
	M.nutriment_req_multiplier = -0.50
	M.oxygen_req_multiplier = -0.50
	M.prefix = "efficient"
	..()

/obj/item/modification/organ/internal/stromal/durability
	name = "durable membrane"
	desc = "A stronger membrane that allows an organ to sustain greater injury before its functions are diminished."
	icon_state = "thick_membrane"

/obj/item/modification/organ/internal/stromal/durability/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.specific_organ_size_multiplier = 0.20
	M.min_bruised_damage_multiplier = 0.20
	M.min_broken_damage_multiplier = 0.20
	M.max_damage_multiplier = 0.20
	M.prefix = "durable"
	..()

/obj/item/modification/organ/internal/stromal/efficiency
	name = "stem cell application"
	desc = "A clump of stem cells that permanently increases the functional efficiency of an organ."
	icon_state = "stem_cells"

/obj/item/modification/organ/internal/stromal/efficiency/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.organ_efficiency_multiplier = 0.25
	M.removable = FALSE		// Stem cells don't go back to being undifferentiated
	M.prefix = "enhanced"
	..()
	
/obj/item/modification/organ/internal/stromal/overclock
	name = "visceral symbiont"
	desc = "A leech-like creature that attaches itself to the viscera of an orgnanism. It mimics the function of the parent organ in exchange for blood, oxygen, and nutrients."
	icon_state = "symbiont"

/obj/item/modification/organ/internal/stromal/overclock/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.organ_efficiency_multiplier = 0.20
	M.blood_req_multiplier = 0.20
	M.nutriment_req_multiplier = 0.20
	M.oxygen_req_multiplier = 0.20
	M.specific_organ_size_multiplier = 0.20
	M.prefix = "symbiotic"
	..()

/obj/item/modification/organ/internal/stromal/underclock
	name = "bypass tubules"
	desc = "A series of tubules that siphon blood away from an organ, reducing its effectiveness, to be used elsewhere in the body."
	icon_state = "tubules"

/obj/item/modification/organ/internal/stromal/underclock/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.organ_efficiency_multiplier = -0.20		// Brings a standard organ just above the efficiency where the body is negatively impacted
	M.blood_req_multiplier = -0.20
	M.nutriment_req_multiplier = -0.20
	M.oxygen_req_multiplier = -0.20
	M.specific_organ_size_multiplier = -0.20
	M.prefix = "bypassed"
	..()

/obj/item/modification/organ/internal/stromal/expander
	name = "biostructure gel"
	desc = "A gel that will permanently solidify as structural tissue of the organ it is applied to."
	icon_state = "advanced_collagen"

/obj/item/modification/organ/internal/stromal/expander/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.specific_organ_size_mod = 0.10
	M.max_upgrade_mod = 2
	M.removable = FALSE		// Not feasible to remove
	M.prefix = "expanded"
	..()

/obj/item/modification/organ/internal/stromal/silencer
	name = "masked membrane"
	desc = "An outer membrane that absorbs typical medical scanning wavelengths. Slightly impedes organ functions and reduces organ size."
	icon_state = "stealth_composites"

/obj/item/modification/organ/internal/stromal/silencer/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.organ_efficiency_multiplier = -0.10
	M.specific_organ_size_multiplier = -0.10
	M.scanner_hidden = TRUE
	M.prefix = "scanner-masked"
	..()

/obj/item/modification/organ/internal/parenchymal
	name = "pygmy parenchymal membrane"
	desc = "A graftable membrane for organ tissues. Contains functional tissue from one or more organs."
	description_info = "Adds/increases organ efficiencies. Size, blood, oxygen, and nutrition requirements are based on the added efficiencies."
	icon_state = "membrane"
	var/organ_eff_mod = 0.20

/obj/item/modification/organ/internal/parenchymal/Initialize(loc, generate_organ_stats = TRUE, predefined_modifier = organ_eff_mod)
	var/datum/component/modification/organ/parenchymal/M = AddComponent(/datum/component/modification/organ/parenchymal)

	M.prefix = "grafted"
	M.multiples_allowed = TRUE
	..()

/obj/item/modification/organ/internal/parenchymal/large
	name = "parenchymal membrane"
	organ_eff_mod = 0.40

// Junk loot or craftables
/obj/item/modification/organ/internal/electromechanical
	bad_type = /obj/item/modification/organ/internal/electromechanical
	spawn_blacklisted = FALSE

/obj/item/modification/organ/internal/electromechanical/bone_braces
	name = "bone braces"
	desc = "Little metal bits that bones can be reinforced with."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bone_braces"
	matter = list(MATERIAL_PLASTEEL = 3)
	price_tag = 90

/obj/item/modification/organ/internal/electromechanical/bone_braces/update_icon()
	return

/obj/item/modification/organ/internal/electromechanical/bone_braces/New()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.apply_to_types = list(/obj/item/organ/internal/bone)
	M.examine_msg = "Can be attached to bones."
	M.examine_difficulty = STAT_LEVEL_BASIC
	M.prefix = "reinforced"

	M.organ_efficiency_mod = list(OP_BONE = 0.33)


// Roach loot

/obj/item/modification/organ/internal/stromal/efficiency_roach
	name = "congealed blattedin"
	desc = "A clump of solidified roach blood that permanently increases the functional efficiency of an organ."
	icon_state = "roach_stem_cells"

/obj/item/modification/organ/internal/stromal/efficiency_roach/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.organ_efficiency_multiplier = 0.40
	M.removable = FALSE		// Stem cells don't go back to being undifferentiated
	M.prefix = "blattidean"
	..()

/obj/item/modification/organ/internal/stromal/durability_roach
	name = "chitinous membrane"
	desc = "A chitinous membrane that allows an organ to sustain greater injury before its functions are diminished."
	icon_state = "thick_membrane"

/obj/item/modification/organ/internal/stromal/durability_roach/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.min_bruised_damage_multiplier = 1
	M.min_broken_damage_multiplier = 1
	M.max_damage_multiplier = 1
	M.prefix = "chitinous"
	..()


// One Star loot

/obj/item/modification/organ/internal/stromal/requirements_onestar
	name = "improved capillaries"
	desc = "A set of modified capillaries that improve substance transfer within an organ."
	icon_state = "capillary"

/obj/item/modification/organ/internal/stromal/requirements_onestar/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.blood_req_multiplier = -0.90
	M.nutriment_req_multiplier = -0.90
	M.oxygen_req_multiplier = -0.90
	M.prefix = "hyper-efficient"
	..()

/obj/item/modification/organ/internal/stromal/underclock_onestar
	name = "bypass tubules"
	desc = "A series of tubules that siphon blood away from an organ, reducing its effectiveness, to be used elsewhere in the body."
	icon_state = "tubules"

/obj/item/modification/organ/internal/stromal/underclock_onestar/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.organ_efficiency_multiplier = -0.25		// Brings a standard organ just under the efficiency where the body is negatively impacted
	M.blood_req_multiplier = -0.40
	M.nutriment_req_multiplier = -0.40
	M.oxygen_req_multiplier = -0.40
	M.specific_organ_size_multiplier = -0.60
	M.prefix = "bypassed"
	..()


// Hivemind loot

/obj/item/modification/organ/internal/stromal/hivemind_conversion
	name = "hivemind membrane"
	desc = "An outer membrane that absorbs typical medical scanning wavelengths. Slightly impedes organ functions and reduces organ size."
	icon_state = "stealth_composites"

/obj/item/modification/organ/internal/stromal/hivemind_conversion/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.apply_to_natures = list(MODIFICATION_ORGANIC, MODIFICATION_SILICON)
	M.nature_adjustment = MODIFICATION_ASSISTED		// Vulnerable to both organic and robotic wounds, allows robotic organs to take organic mods
	M.organ_efficiency_multiplier = 0.10
	M.specific_organ_size_multiplier = -0.10
	M.scanner_hidden = TRUE
	M.prefix = "hive-assisted"
	..()

/obj/item/modification/organ/internal/stromal/overclock_hivemind
	name = "visceral symbiont"
	desc = "A leech-like creature that attaches itself to the viscera of an orgnanism. It mimics the function of the parent organ in exchange for blood, oxygen, and nutrients."
	icon_state = "symbiont"

/obj/item/modification/organ/internal/stromal/overclock_hivemind/Initialize()
	var/datum/component/modification/organ/stromal/M = AddComponent(/datum/component/modification/organ/stromal)

	M.apply_to_natures = list(MODIFICATION_ASSISTED)
	M.organ_efficiency_multiplier = 1
	M.blood_req_multiplier = -0.50
	M.nutriment_req_multiplier = -0.50
	M.oxygen_req_multiplier = -0.50
	M.prefix = "hive-assisted"
	..()
