/datum/component/modification/organ/on_item_examine
	exclusive_type = /obj/item/modification/organ/internal/special/on_item_examine
	trigger_signal = COMSIG_EXAMINE

/datum/component/modification/organ/on_item_examine/brainloss
	var/damage = 1

/datum/component/modification/organ/on_item_examine/brainloss/moderate
	damage = 5

/datum/component/modification/organ/on_item_examine/brainloss/get_function_info()
	var/description = "<span style='color:purple'>Functional information (secondary):</span> causes brain damage when viewed closely"
	return description

/datum/component/modification/organ/on_item_examine/brainloss/trigger(mob/user)
	if(!user)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/L = user	// NOTE: In this case, user means the mob that examined the holder, not the mob the holder is attached to
		L.adjustBrainLoss(damage)
		L.apply_damage(damage, PSY)


/datum/component/modification/organ/on_pickup
	exclusive_type = /obj/item/modification/organ/internal/special/on_pickup
	trigger_signal = COMSIG_ITEM_PICKED

/datum/component/modification/organ/on_pickup/shock
	var/damage = 5

/datum/component/modification/organ/on_pickup/shock/get_function_info()
	var/description = "<span style='color:purple'>Functional information (secondary):</span> electrocutes when touched"
	return description

/datum/component/modification/organ/on_pickup/shock/powerful
	damage = 25

/datum/component/modification/organ/on_pickup/shock/trigger(obj/item/holder, mob/owner)
	if(!holder || !owner)
		return

	if(isliving(owner))
		var/mob/living/L = owner
		L.electrocute_act(damage, parent)

/datum/component/modification/organ/on_cooldown
	exclusive_type = /obj/item/modification/organ/internal/special/on_cooldown
	trigger_signal = COMSIG_ABERRANT_SECONDARY

/datum/component/modification/organ/on_cooldown/chemical_effect
	var/effect

/datum/component/modification/organ/on_cooldown/chemical_effect/get_function_info()
	var/datum/reagent/hormone/H
	if(ispath(effect, /datum/reagent/hormone))
		H = effect

	var/effect_desc
	switch(effect)
		if(/datum/reagent/hormone/bloodrestore, /datum/reagent/hormone/bloodrestore/alt)
			effect_desc = "blood restoration"
		if(/datum/reagent/hormone/bloodclot, /datum/reagent/hormone/bloodclot/alt)
			effect_desc = "blood clotting"
		if(/datum/reagent/hormone/painkiller, /datum/reagent/hormone/painkiller/alt)
			effect_desc = "painkiller"
		if(/datum/reagent/hormone/antitox, /datum/reagent/hormone/antitox/alt)
			effect_desc = "anti-toxin"
		if(/datum/reagent/hormone/oxygenation, /datum/reagent/hormone/oxygenation/alt)
			effect_desc = "oxygenation"
		if(/datum/reagent/hormone/speedboost, /datum/reagent/hormone/speedboost/alt)
			effect_desc = "augmented agility"

	var/description = "<span style='color:purple'>Functional information (secondary):</span> secretes a hormone"
	description += "\n<span style='color:purple'>Effect produced:</span> [effect_desc] (type ["[initial(H.hormone_type)]"])"

	return description

/datum/component/modification/organ/on_cooldown/chemical_effect/trigger(obj/item/holder, mob/living/carbon/owner)
	if(!holder || !owner)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/organ_multiplier = ((S.max_damage - S.damage) / S.max_damage) * (S.aberrant_cooldown_time / (2 SECONDS))	// Life() is called every 2 seconds
	var/datum/reagents/metabolism/RM = owner.get_metabolism_handler(CHEM_BLOOD)

	var/datum/reagent/output = effect
	var/amount_to_add = initial(output.metabolism) * organ_multiplier
	RM.add_reagent(initial(output.id), amount_to_add)

/datum/component/modification/organ/on_cooldown/stat_boost
	var/stat
	var/boost

/datum/component/modification/organ/on_cooldown/stat_boost/get_function_info()
	var/description = "<span style='color:purple'>Functional information (secondary):</span> augments physical/mental affinity"
	description += "\n<span style='color:purple'>Affinity:</span> [stat] ([boost])"

	return description

/datum/component/modification/organ/on_cooldown/stat_boost/trigger(obj/item/holder, mob/owner)
	if(!holder || !owner)
		return
	if(!istype(holder, /obj/item/organ/internal/scaffold))
		return

	var/obj/item/organ/internal/scaffold/S = holder
	var/effect_multiplier = (S.max_damage - S.damage) / S.max_damage
	var/delay = S.aberrant_cooldown_time + 2 SECONDS

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.stats.addTempStat(stat, boost * effect_multiplier, delay, "\ref[parent]")


/datum/component/modification/organ/parasitic
	exclusive_type = /obj/item/modification/organ/internal/special/parasitic
	adjustable = TRUE
	trigger_signal = COMSIG_ITEM_PICKED

/datum/component/modification/organ/parasitic/get_function_info()
	var/description

	if(trigger_signal == COMSIG_IATTACK)
		description = "<span style='color:purple'>Functional information (secondary):</span> can be implanted through unprotected skin"
	else if(trigger_signal == COMSIG_ITEM_PICKED)
		description = "<span style='color:purple'>Functional information (secondary):</span> can implant itself through unprotected skin"

	return description

/datum/component/modification/organ/parasitic/modify(obj/item/I, mob/living/user)
	var/list/can_adjust = list("organ tissue", "implant behavior")

	var/decision_adjust = input("What do you want to adjust?","Adjusting Organoid") as null|anything in can_adjust
	if(!decision_adjust)
		return

	switch(decision_adjust)
		if("organ tissue")
			specific_organ_size_mod = 0
			max_blood_storage_mod = 0
			blood_req_mod = 0
			nutriment_req_mod = 0
			oxygen_req_mod = 0

			var/list/possibilities = PARASITIC_ORGAN_EFFICIENCIES

			for(var/organ in organ_efficiency_mod)
				if(organ_efficiency_mod.len > 1)
					for(var/organ_eff in possibilities)
						if(organ != organ_eff && organ_efficiency_mod.Find(organ_eff))
							possibilities.Remove(organ_eff)

				var/decision = input("Choose an organ type (current: [organ])","Adjusting Organoid") as null|anything in possibilities
				if(!decision)
					decision = organ

				var/list/organ_stats = ALL_ORGAN_STATS[decision]
				var/modifier = round(organ_efficiency_mod[organ] / 100, 0.01)

				if(!modifier)
					return

				organ_efficiency_mod.Remove(organ)
				organ_efficiency_mod.Add(decision)
				organ_efficiency_mod[decision] 	= round(organ_stats[1] * modifier, 1)
				specific_organ_size_mod 		+= round(organ_stats[2] * modifier, 0.01)
				max_blood_storage_mod			+= round(organ_stats[3] * modifier, 1)
				blood_req_mod 					+= round(organ_stats[4] * modifier, 0.01)
				nutriment_req_mod 				+= round(organ_stats[5] * modifier, 0.01)
				oxygen_req_mod 					+= round(organ_stats[6] * modifier, 0.01)
		if("implant behavior")
			var/list/possibilities = list(
				"on pick-up" = COMSIG_ITEM_PICKED,
				"on insertion" = COMSIG_IATTACK
				)
			var/list/inverted_possibles = list(
				COMSIG_ITEM_PICKED = "on pick-up",
				COMSIG_IATTACK = "on insertion"
			)

			var/decision = input("Choose an implant method (current: [inverted_possibles[trigger_signal]])","Adjusting Organoid") as null|anything in possibilities
			if(!decision)
				return
			
			trigger_signal = possibilities[decision]

/datum/component/modification/organ/parasitic/trigger(atom/A, mob/M)
	if(!A || !M)
		return

	if(trigger_signal == COMSIG_IATTACK)
		trigger_iattack(A, M)
	else if(trigger_signal == COMSIG_ITEM_PICKED)
		trigger_pickup(A, M)

/datum/component/modification/organ/parasitic/proc/trigger_pickup(obj/item/holder, mob/owner)
	if(!holder || !owner)
		return

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		var/obj/item/organ/external/active_hand = H.get_active_hand_organ()
		if(H.getarmor_organ(active_hand, ARMOR_BIO) < 75 && active_hand.get_total_occupied_volume() < active_hand.max_volume)
			if(istype(holder, /obj/item/organ/internal))
				var/obj/item/organ/internal/I = holder
				H.drop_item()
				I.replaced(active_hand)
				H.apply_damage(10, HALLOSS, active_hand)
				H.apply_damage(5, BRUTE, active_hand)
				to_chat(owner, SPAN_WARNING("\The [holder] forces its way into your [active_hand.name]!"))

/datum/component/modification/organ/parasitic/proc/trigger_iattack(atom/A, mob/living/user)
	if(!A || !user)
		return

	if(ishuman(A) && ishuman(user))
		var/mob/living/carbon/human/target = A
		var/mob/living/carbon/human/attacker = user
		var/obj/item/organ/external/affected = target.organs_by_name[attacker.targeted_organ]
		if(!affected)
			user.visible_message(SPAN_NOTICE("[user.name] attempts to implant [target.name], but misses!"), SPAN_WARNING("The target limb is missing."))
		var/duration = max(3 SECONDS - round(attacker.stats.getStat(STAT_BIO) / 10), 0)		// Every 10 points of BIO reduces the duration by a tick (tenth of a second)
		if(!do_after(attacker, duration, target))
			return
		if(target.getarmor_organ(affected, ARMOR_BIO) < 75 && affected.get_total_occupied_volume() < affected.max_volume)
			var/atom/movable/AM = parent
			if(istype(AM.loc, /obj/item/organ/internal))
				var/obj/item/organ/internal/I = AM.loc
				attacker.drop_item()
				I.replaced(affected)
				target.apply_damage(10, HALLOSS, affected)
				target.apply_damage(5, BRUTE, affected)
				user.visible_message(SPAN_WARNING("[user.name] implants \the [I] into [target.name]'s [affected.name]!"), SPAN_WARNING("You implant \the [I] into [target.name]'s [affected.name]!"))
