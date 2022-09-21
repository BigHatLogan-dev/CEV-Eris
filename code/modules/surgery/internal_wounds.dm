/datum/surgery_step/treat_wound
	target_organ_type = /obj/item/organ/internal
	blood_level = 1

// Wounds contain their own info and feedback for whether a treatment will be successful or not
/datum/surgery_step/treat_wound/tool_quality()
	return 120

/datum/surgery_step/treat_wound/can_use()
	return TRUE

/datum/surgery_step/treat_wound/prepare_step()
	return TRUE

/datum/surgery_step/treat_wound/begin_step(mob/living/user, obj/item/organ/organ, obj/item/tool)
	duration = max(0, duration - user.stats.getStat(STAT_BIO))

/datum/surgery_step/treat_wound/end_step(mob/living/user, obj/item/organ/organ, obj/item/tool)
	SEND_SIGNAL(organ, COMSIG_ATTACKBY, tool, user)
