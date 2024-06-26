/*
Stabilized extracts:
	Provides a passive buff to the holder.
*/

//To add: Create an effect in crossbreeding/_status_effects.dm with the name "/datum/status_effect/stabilized/[color]"
//Status effect will automatically be applied while held, and lost on drop.

/obj/item/slimecross/stabilized
	name = "stabilized extract"
	desc = ""
	effect = "stabilized"
	icon_state = "stabilized"
	var/datum/status_effect/linked_effect
	var/mob/living/owner

/obj/item/slimecross/stabilized/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/item/slimecross/stabilized/Destroy()
	STOP_PROCESSING(SSobj,src)
	qdel(linked_effect)
	return ..()

/obj/item/slimecross/stabilized/process()
	var/humanfound = null
	if(ishuman(loc))
		humanfound = loc
	if(ishuman(loc.loc)) //Check if in backpack.
		humanfound = (loc.loc)
	if(!humanfound)
		return
	var/mob/living/carbon/human/H = humanfound
	var/effectpath = /datum/status_effect/stabilized
	var/static/list/effects = subtypesof(/datum/status_effect/stabilized)
	for(var/X in effects)
		var/datum/status_effect/stabilized/S = X
		if(initial(S.colour) == colour)
			effectpath = S
			break
	if(!H.has_status_effect(effectpath))
		var/datum/status_effect/stabilized/S = H.apply_status_effect(effectpath)
		owner = H
		S.linked_extract = src
		STOP_PROCESSING(SSobj,src)



//Colors and subtypes:
/obj/item/slimecross/stabilized/grey
	colour = "grey"
	effect_desc = ""

/obj/item/slimecross/stabilized/orange
	colour = "orange"
	effect_desc = ""

/obj/item/slimecross/stabilized/purple
	colour = "purple"
	effect_desc = ""

/obj/item/slimecross/stabilized/blue
	colour = "blue"
	effect_desc = ""

/obj/item/slimecross/stabilized/metal
	colour = "metal"
	effect_desc = ""

/obj/item/slimecross/stabilized/yellow
	colour = "yellow"
	effect_desc = ""

/obj/item/slimecross/stabilized/darkpurple
	colour = "dark purple"
	effect_desc = ""

/obj/item/slimecross/stabilized/darkblue
	colour = "dark blue"
	effect_desc = ""

/obj/item/slimecross/stabilized/silver
	colour = "silver"
	effect_desc = ""

/obj/item/slimecross/stabilized/bluespace
	colour = "bluespace"
	effect_desc = ""

/obj/item/slimecross/stabilized/sepia
	colour = "sepia"
	effect_desc = ""

/obj/item/slimecross/stabilized/cerulean
	colour = "cerulean"
	effect_desc = ""

/obj/item/slimecross/stabilized/pyrite
	colour = "pyrite"
	effect_desc = ""

/obj/item/slimecross/stabilized/red
	colour = "red"
	effect_desc = ""

/obj/item/slimecross/stabilized/green
	colour = "green"
	effect_desc = ""

/obj/item/slimecross/stabilized/pink
	colour = "pink"
	effect_desc = ""

/obj/item/slimecross/stabilized/gold
	colour = "gold"
	effect_desc = ""
	var/mob_type
	var/datum/mind/saved_mind
	var/mob_name = "Familiar"

/obj/item/slimecross/stabilized/gold/proc/generate_mobtype()
	var/static/list/mob_spawn_pets = list()
	if(mob_spawn_pets.len <= 0)
		for(var/T in typesof(/mob/living/simple_animal))
			var/mob/living/simple_animal/SA = T
			switch(initial(SA.gold_core_spawnable))
				if(FRIENDLY_SPAWN)
					mob_spawn_pets += T
	mob_type = pick(mob_spawn_pets)

/obj/item/slimecross/stabilized/gold/Initialize()
	. = ..()
	generate_mobtype()

/obj/item/slimecross/stabilized/gold/attack_self(mob/user)
	var/choice = input(user, "Which do you want to reset?", "Familiar Adjustment") as null|anything in sortList(list("Familiar Location", "Familiar Species", "Familiar Sentience", "Familiar Name"))
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.has_status_effect(/datum/status_effect/stabilized/gold))
			L.remove_status_effect(/datum/status_effect/stabilized/gold)
	if(choice == "Familiar Location")
		to_chat(user, "<span class='notice'>I prod [src], and it shudders slightly.</span>")
		START_PROCESSING(SSobj, src)
	if(choice == "Familiar Species")
		to_chat(user, "<span class='notice'>I squeeze [src], and a shape seems to shift around inside.</span>")
		generate_mobtype()
		START_PROCESSING(SSobj, src)
	if(choice == "Familiar Sentience")
		to_chat(user, "<span class='notice'>I poke [src], and it lets out a glowing pulse.</span>")
		saved_mind = null
		START_PROCESSING(SSobj, src)
	if(choice == "Familiar Name")
		var/newname = copytext(sanitize_name(input(user, "Would you like to change the name of [mob_name]", "Name change", mob_name) as null|text),1,MAX_NAME_LEN)
		if(newname)
			mob_name = newname
		to_chat(user, "<span class='notice'>I speak softly into [src], and it shakes slightly in response.</span>")
		START_PROCESSING(SSobj, src)

/obj/item/slimecross/stabilized/oil
	colour = "oil"
	effect_desc = ""

/obj/item/slimecross/stabilized/black
	colour = "black"
	effect_desc = ""

/obj/item/slimecross/stabilized/lightpink
	colour = "light pink"
	effect_desc = ""

/obj/item/slimecross/stabilized/adamantine
	colour = "adamantine"
	effect_desc = ""

/obj/item/slimecross/stabilized/rainbow
	colour = "rainbow"
	effect_desc = ""
	var/obj/item/slimecross/regenerative/regencore

/obj/item/slimecross/stabilized/rainbow/attackby(obj/item/O, mob/user)
	var/obj/item/slimecross/regenerative/regen = O
	if(istype(regen) && !regencore)
		to_chat(user, "<span class='notice'>I place [O] in [src], prepping the extract for automatic application!</span>")
		regencore = regen
		regen.forceMove(src)
		return
	return ..()
