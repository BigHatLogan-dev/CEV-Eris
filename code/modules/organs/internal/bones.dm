/obj/item/organ/internal/bone
	name = "bone"
	icon_state = "bone_braces"
	desc = "You have got a bone to pick with this"
	organ_efficiency = list(OP_BONE = 100)
	price_tag = 100
	force = WEAPON_FORCE_NORMAL
	max_damage = 10
	var/broken_description = ""
	var/reinforced = FALSE

/obj/item/organ/internal/bone/Initialize()
    . = ..()
    src.transform *= 0.5 // this little trick makes bone size small while keeping detail level of 32x32 bones.

/obj/item/organ/internal/bone/proc/fracture()
	if(owner)
		owner.visible_message(
			SPAN_DANGER("You hear a loud cracking sound coming from \the [owner]."),
			SPAN_DANGER("Something feels like it shattered in your [name]"),
			SPAN_DANGER("You hear a sickening crack.")
		)
		if(owner.species && !(owner.species.flags & NO_PAIN))
			owner.emote("scream")

	parent.status |= ORGAN_BROKEN	//Holding the status on the parent organ to make transition to erismed organ processes easier.
	broken_description = pick("broken","fracture","hairline fracture")
	parent.perma_injury = parent.brute_dam
	take_damage(10, FALSE, BRUTE)

	// Fractures have a chance of getting you out of restraints
	if(prob(25))
		parent.release_restraints()

/obj/item/organ/internal/bone/take_damage(amount, silent, damage_type = null, sharp = FALSE, edge = FALSE)	//Deals damage to the organ itself
	if(!damage_type)
		return

	// Determine possible wounds based on nature and damage type
	var/is_robotic = BP_IS_ROBOTIC(src) || BP_IS_ASSISTED(src)
	var/is_organic = BP_IS_ORGANIC(src) || BP_IS_ASSISTED(src)
	var/list/possible_wounds = list()

	var/total_damage = amount * (100 / (parent ? parent.limb_efficiency : 100))
	var/wound_count = max(0, round(total_damage / 10, 1))	// Every 10 points of damage is a wound

	if((!is_organic && !is_robotic) || !wound_count)
		return

	switch(damage_type)
		if(BRUTE)
			if(!edge)
				if(sharp)
					if(is_organic)
						possible_wounds |= typesof(/datum/component/internal_wound/organic/bone_sharp)
					if(is_robotic)
						possible_wounds |= typesof(/datum/component/internal_wound/robotic/sharp)
				else
					if(is_organic)
						possible_wounds |= typesof(/datum/component/internal_wound/organic/bone_blunt)
					if(is_robotic)
						possible_wounds |= typesof(/datum/component/internal_wound/robotic/blunt)
			else
				if(is_organic)
					possible_wounds |= typesof(/datum/component/internal_wound/organic/bone_edge)
				if(is_robotic)
					possible_wounds |= typesof(/datum/component/internal_wound/robotic/edge)
		if(BURN)
			if(is_organic)
				possible_wounds |= typesof(/datum/component/internal_wound/organic/burn)
			if(is_robotic)
				possible_wounds |= typesof(/datum/component/internal_wound/robotic/emp_burn)

	if(is_organic)
		possible_wounds -= GetComponents(/datum/component/internal_wound/organic)	// Organic wounds don't stack

	if(possible_wounds.len)
		for(var/i in 1 to wound_count)
			var/choice = pick(possible_wounds)
			add_wound(choice)	
			if(ispath(choice, /datum/component/internal_wound/organic))
				possible_wounds -= choice
			if(!possible_wounds.len)
				break

	if(!BP_IS_ROBOTIC(src) && owner && parent && amount > 0 && !silent)
		owner.custom_pain("Something inside your [parent.name] hurts a lot.", 1)

/obj/item/organ/internal/bone/get_actions()
	var/list/actions_list = list()
	if(BP_IS_ROBOTIC(src))
		if(parent.status & ORGAN_BROKEN)
			actions_list.Add(list(list(
				"name" = "Mend break",
				"organ" = "\ref[src]",
				"step" = /datum/surgery_step/robotic/fix_bone
			)))
	else
		actions_list.Add(list(list(
			"name" = (parent.status & ORGAN_BROKEN) ? "Mend" : "Break",
			"organ" = "\ref[src]",
			"step" = (parent.status & ORGAN_BROKEN) ? /datum/surgery_step/mend_bone : /datum/surgery_step/break_bone
		)))
		if(parent.status & ORGAN_BROKEN)
			actions_list.Add(list(list(
					"name" = "Reinforce",
					"organ" = "\ref[src]",
					"step" = /datum/surgery_step/reinforce_bone
				)))
		actions_list.Add(list(list(
				"name" = "Replace",
				"organ" = "\ref[src]",
				"step" = /datum/surgery_step/replace_bone
			)))

	return actions_list

/obj/item/organ/internal/bone/proc/mend()
	parent.status &= ~ORGAN_BROKEN
	parent.status &= ~ORGAN_SPLINTED
	parent.perma_injury = 0


/obj/item/organ/internal/bone/proc/reinforce()
	if(!reinforced) //Just in case
		organ_efficiency[OP_BONE] += 33
		reinforced = TRUE
		name = "reinforced [name]"
		icon_state = "reinforced_[icon_state]"

/obj/item/organ/internal/bone/chest
	name = "ribcage"
	icon_state = "ribcage"
	parent_organ_base = BP_CHEST

/obj/item/organ/internal/bone/groin
	name = "pelvis"
	icon_state = "pelvis"
	parent_organ_base = BP_GROIN

/obj/item/organ/internal/bone/head
	name = "skull"
	icon_state = "skull"
	parent_organ_base = BP_HEAD

/obj/item/organ/internal/bone/r_arm
	name = "right humerus"
	icon_state = "right_arm"
	parent_organ_base = BP_R_ARM

/obj/item/organ/internal/bone/l_arm
	name = "left humerus"
	icon_state = "left_arm"
	parent_organ_base = BP_L_ARM

/obj/item/organ/internal/bone/r_leg
	name = "right femur"
	icon_state = "right_leg"
	parent_organ_base = BP_R_LEG
	force = WEAPON_FORCE_PAINFUL

/obj/item/organ/internal/bone/l_leg
	name = "left femur"
	icon_state = "left_leg"
	parent_organ_base = BP_L_LEG
	force = WEAPON_FORCE_PAINFUL

//Robotic limb variants
/obj/item/organ/internal/bone/chest/robotic
	name = "chest frame"
	icon_state = "metal_ribcage"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/organ/internal/bone/groin/robotic
	name = "groin frame"
	icon_state = "metal_pelvis"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/organ/internal/bone/head/robotic
	name = "head frame"
	icon_state = "metal_skull"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/organ/internal/bone/r_arm/robotic
	name = "right arm frame"
	icon_state = "metal_right_arm"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/organ/internal/bone/l_arm/robotic
	name = "left arm frame"
	icon_state = "metal_left_arm"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/organ/internal/bone/r_leg/robotic
	name = "right leg frame"
	icon_state = "metal_right_leg"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

/obj/item/organ/internal/bone/l_leg/robotic
	name = "left leg frame"
	icon_state = "metal_left_leg"
	nature = MODIFICATION_SILICON
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTIC = 2)

//Bone braces
/obj/item/bone_brace
	name = "bone braces"
	desc = "Little metal bits that bones can be reinforced with"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "bone_braces"
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_PLASTEEL = 3)
