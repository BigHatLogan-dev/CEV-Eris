/obj/item/organ/internal/scaffold/aberrant/roach
	name = "roach organ"
	ruined_name = "roach organ"
	desc = "An organ harvested from a roach."
	ruined_desc = null
	description_info = "A modular organ with four slots for organ mods or organoids."
	ruined_description_info = null
	icon = 'icons/obj/aberrant_organs/roach_organs.dmi'
	rarity_value = 20
	spawn_tags = SPAWN_TAG_ABERRANT_ORGAN_MAINT
	spawn_blacklisted = TRUE
	b_type = "Ü~"				// Will trigger rejection
	max_upgrades = 4
	
	use_generated_name = FALSE
	organ_type = "roach"
	num_variants = 0
	num_colors = 4

	aberrant_cooldown_time = MAINT_ABERRANT_COOLDOWN
	
	input_mod_path = /obj/item/modification/organ/internal/input/consume
	process_mod_path = /obj/item/modification/organ/internal/process/multiplier
	output_mod_path = /obj/item/modification/organ/internal/output/reagents_blood

	specific_input_type_pool = STANDARD_ORGANIC_CONSUMABLES
	input_mode = NOT_USED
	process_info = list(0.75)
	output_pool = REAGENTS_ROACH
	output_info = list(LOW_OUTPUT)

/obj/item/organ/internal/scaffold/aberrant/roach/blattedin
	name = "blattedin gland"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/blattedin

/obj/item/organ/internal/scaffold/aberrant/roach/diplopterum
	name = "diplopterum sac"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/diplopterum

/obj/item/organ/internal/scaffold/aberrant/roach/seligitillin
	name = "seligitillin node"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/seligitillin

/obj/item/organ/internal/scaffold/aberrant/roach/starkellin
	name = "starkellin gland"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/starkellin

/obj/item/organ/internal/scaffold/aberrant/roach/gewaltine
	name = "gewaltine node"
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/gewaltine

/obj/item/organ/internal/scaffold/aberrant/roach/fuhrer
	name = "Fuhrer organ"
	desc = "An organ harvested from a Fuhrer roach."
	description_info = "A modular organ with five slots for organ mods or organoids."
	icon_state = "organ_scaffold-fuhrer"
	bad_type = /obj/item/organ/internal/scaffold/aberrant/roach/fuhrer		// Drop only
	use_generated_color = FALSE
	use_generated_icon = FALSE
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/fuhrerole
	output_pool = REAGENTS_FUHRER

/obj/item/organ/internal/scaffold/aberrant/roach/kaiser
	name = "Kaiser organ"
	desc = "An organ harvested from a Kaiser roach."
	description_info = "A modular organ with seven slots for organ mods or organoids."
	icon_state = "organ_scaffold-kaiser"
	bad_type = /obj/item/organ/internal/scaffold/aberrant/roach/kaiser		// Event only
	use_generated_color = FALSE
	use_generated_icon = FALSE
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/reagents_blood/kaiseraurum
	output_pool = REAGENTS_KAISER

/obj/item/organ/internal/scaffold/aberrant/roach/seuche
	name = "Seuche sac"
	icon_state = "organ_scaffold-roach-4"

	use_generated_color = FALSE
	use_generated_icon = FALSE
	
	output_mod_path = /obj/item/modification/organ/internal/output/chem_smoke/roach
	special_mod_path = /obj/item/modification/organ/internal/on_cooldown/stat_boost

	output_pool = list(/datum/reagent/toxin/blattedin)
	output_info = REAGENTS_ROACH
	special_info = list(STAT_TGH, 15)

/obj/item/organ/internal/scaffold/aberrant/roach/gestrahlte
	name = "Gestrahlte gland"
	icon_state = "organ_scaffold-roach-1"

	use_generated_color = FALSE
	use_generated_icon = FALSE

	input_mod_path = /obj/item/modification/organ/internal/input/reagents
	output_mod_path = /obj/item/modification/organ/internal/output/stat_boost
	special_mod_path = /obj/item/modification/organ/internal/deployable/gestrahlte

	specific_input_type_pool = list(/datum/reagent/toxin/blattedin)
	input_mode = CHEM_INGEST
	output_pool = list(STAT_TGH)
	output_info = list(15)
	special_info = list(/obj/item/gun/matter/regenerating/gestrahlte_gland)
