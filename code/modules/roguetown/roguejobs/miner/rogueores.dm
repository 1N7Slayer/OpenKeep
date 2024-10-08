/obj/item/rogueore
	name = "ore"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ore"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/rogueore/gold
	name = "raw gold"
	icon_state = "oregold1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 10
	dust_result = /obj/item/alch/golddust

/obj/item/rogueore/gold/Initialize()
	icon_state = "oregold[rand(1,3)]"
	..()


/obj/item/rogueore/silver
	name = "raw silver"
	icon_state = "oresilv1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 8
	dust_result = /obj/item/alch/silverdust

/obj/item/rogueore/silver/Initialize()
	icon_state = "oresilv[rand(1,3)]"
	..()


/obj/item/rogueore/iron
	name = "raw iron"
	icon_state = "oreiron1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 5
	dust_result = /obj/item/alch/irondust 

/obj/item/rogueore/iron/Initialize()
	icon_state = "oreiron[rand(1,3)]"
	..()


/obj/item/rogueore/copper
	name = "raw copper"
	icon_state = "orecop1"
	smeltresult = /obj/item/ingot/copper
	sellprice = 2

/obj/item/rogueore/copper/Initialize()
	icon_state = "orecop[rand(1,3)]"
	..()

/obj/item/rogueore/coal
	name = "coal"
	icon_state = "orecoal1"
	firefuel = 5 MINUTES
	smeltresult = /obj/item/rogueore/coal
	sellprice = 1
	dust_result = /obj/item/alch/coaldust

/obj/item/rogueore/coal/Initialize()
	icon_state = "orecoal[rand(1,3)]"
	..()

/obj/item/ingot
	name = "ingot"
	desc = "A parent bar of metal. If you see this, report it on github."
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingot"
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	var/datum/anvil_recipe/currecipe
	var/quality = SMELTERY_LEVEL_NORMAL

/obj/item/ingot/examine()
	. += ..()
	if(currecipe)
		. += "<span class='warning'>It is currently being worked on to become [currecipe.recipe_name].</span>"

/obj/item/ingot/Initialize(mapload, smelt_quality)
	. = ..()
	if(smelt_quality)
		quality = smelt_quality
		smelted = TRUE
		switch(quality)
			if(SMELTERY_LEVEL_SPOIL)
				name = "spoilt [name]"
				desc += " It is practically scrap."
			if(SMELTERY_LEVEL_POOR)
				name = "poor-quality [name]"
				desc += " It is of dubious quality." // EA NASSIR, WHEN I GET YOU...
			if(SMELTERY_LEVEL_GOOD)
				name = "good-quality [name]"
				desc += " It is of exquisite quality."

/obj/item/ingot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = I
		if(!T.hingot)
			forceMove(T)
			T.hingot = src
			T.hott = null
			T.update_icon()
			return
	..()

/obj/item/ingot/Destroy()
	if(currecipe)
		QDEL_NULL(currecipe)
	if(istype(loc, /obj/machinery/anvil))
		var/obj/machinery/anvil/A = loc
		A.hingot = null
		A.update_icon()
	..()

/obj/item/ingot/gold
	name = "gold bar"
	desc = "A bar of glittering gold."
	icon_state = "ingotgold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 100
	dust_result = /obj/item/alch/golddust

/obj/item/ingot/iron
	name = "iron bar"
	desc = "A bar of wrought iron."
	icon_state = "ingotiron"
	smeltresult = /obj/item/ingot/iron
	sellprice = 25
	dust_result = /obj/item/alch/irondust

/obj/item/ingot/copper
	name = "copper bar"
	desc = "A bar of copper."
	icon_state = "ingotcop"
	smeltresult = /obj/item/ingot/copper
	sellprice = 10

/obj/item/ingot/silver
	name = "silver bar"
	desc = "A bar of glistening silver. The bane of nitewalkers."
	icon_state = "ingotsilv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 60
	dust_result = /obj/item/alch/silverdust

/obj/item/ingot/steel
	name = "steel bar"
	desc = "A bar of alloyed steel."
	icon_state = "ingotsteel"
	smeltresult = /obj/item/ingot/steel
	sellprice = 40
