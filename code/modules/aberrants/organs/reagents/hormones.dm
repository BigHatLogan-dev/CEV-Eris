// These are produced by organs. They should never appear elsewhere.
// Hormone ideas: CE_TOXIN (negative value) and CE_ANTITOXIN, alternate versions of existing ones (to allow effect stacking)
/datum/reagent/hormone
	name = "hormone"
	id = "hormone"
	reagent_state = LIQUID
	metabolism = REM
	scannable = FALSE					// Don't need these clogging up reagent lists on the health scanner
	constant_metabolism = TRUE			// We want these to get used up before the aberrant cooldown is over
	nerve_system_accumulations = 0		// These are hormones
	appear_in_default_catalog = FALSE
	reagent_type = "Hormone"
	var/list/effects = list()	// "effect" = magnitude

/datum/reagent/hormone/affect_blood(mob/living/carbon/M, alien, effect_multiplier)
	if(!effects?.len)
		return

	for(var/effect in effects)
		M.add_chemical_effect(effect, effects[effect])

/datum/reagent/hormone/affect_ingest(mob/living/carbon/M, alien, effect_multiplier)
	return

/datum/reagent/hormone/affect_touch(mob/living/carbon/M, alien, effect_multiplier)
	return

// Blood clotting
/datum/reagent/hormone/bloodclot
	name = "thrombopoietin"		// Increases platelet (clotting stuff) production
	id = "bloodclot_hormone"
	effects = list(CE_BLOODCLOT = 0.1)

// Blood restoration
/datum/reagent/hormone/bloodrestore
	name = "aldosterone"		// Increases blood volume as a result of its IRL effects
	id = "bloodrestore_hormone"
	effects = list(CE_BLOODRESTORE = 0.1)

// Painkiller
/datum/reagent/hormone/painkiller
	name = "enkephalin"			// Regulates nociception (pain response)
	id = "painkiller_hormone"
	effects = list(CE_PAINKILLER = 10)

// Speed boost
/datum/reagent/hormone/speedboost
	name = "osteocalcin"		// Increases energy availability in muscles among other things, probably close enough
	id = "speedboost_hormone"
	effects = list(CE_SPEEDBOOST = 0.1)

// Anti-toxin
/datum/reagent/hormone/antitox
	name = "leukotrienes"		// Produced by white blood cells, probably doesn't help against toxins IRL
	id = "antitox_hormone"
	effects = list(CE_ANTITOX = 0.5)

// Oxygenation
/datum/reagent/hormone/oxygenation
	name = "dexterone"			// Progesterone, the only hormone I found that has something to do with cell oxygen levels; close enough
	id = "oxygenation_hormone"
	effects = list(CE_OXYGENATED = 1)
