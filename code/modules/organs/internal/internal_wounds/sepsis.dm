// Infection 2.0. This will spread to every organ in your body if untreated. Progresses until death.
/datum/component/internal_wound/infection
	treatments = list(CE_ANTIBIOTIC = 5)	// 10u Spaceacillin or 5u spaceacillin + dylovene
	severity = 0
	severity_max = 10
	progression_threshold = 90	// 3 minutes
	hal_damage = 1
	tox_damage = 0.5

/datum/component/internal_wound/infection/progress()
	..()
	var/obj/item/organ/O = parent
	var/mob/living/carbon/human/H = O.owner

	// Spread once
	if(H && severity == 6)
		var/list/internal_organs_sans_parent = H.internal_organs.Copy() - O
		var/obj/item/organ/next_organ = pick(internal_organs_sans_parent)
		next_organ.AddComponent(/datum/component/internal_wound/infection)
