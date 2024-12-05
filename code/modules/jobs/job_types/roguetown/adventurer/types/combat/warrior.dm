//shield sword
/datum/advclass/combat/sfighter
	name = "Warrior"
	tutorial = "Wandering sellswords, foolhardy gloryhounds, deserters... many and varied folk turn to the path of the warrior. Very few meet anything greater than the bottom of a tankard or the wrong end of a noose."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Tiefling",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/sfighter
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0

/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.become_blind("TRAIT_GENERIC")
	var/classes = list("Path of the Iron Vanguard","Path of the Iron Bruiser","Path of the Iron Fang","Path of the Iron Handbow")
	var/classchoice = input("Choose your Path", "Available Warrior Paths") as anything in classes

	switch(classchoice)

		if("Path of the Iron Vanguard") // Of all the warrior subclasses, the most armored in the center mass and very resilient out of the gate, but Vanguards lack in useful utility skills outside of direct combat training, and suffer heavily in speed and perception. Their armor training encourages them to wear heavy armor to slow them down even more.
			H.set_blindness(0)
			to_chat(H, span_warning("You possess trained skill with polearms, shields, and have experience as armored cavalry, you are also have heavy armor training, with limited skill in knives and crossbows. You have great physical conditioning in any field of battle, but your sight and senses are poorly trained, and you are slower than most other fighters on foot."))
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			if(H.age == AGE_OLD)
				H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 2)
			H.change_stat("perception", -2)
			H.change_stat("speed", -2)
			belt = /obj/item/storage/belt/rogue/leather
			head = /obj/item/clothing/head/roguetown/helmet/heavy/ironplate
			neck = /obj/item/clothing/neck/roguetown/coif
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
			armor = /obj/item/clothing/suit/roguetown/armor/plate/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			gloves = /obj/item/clothing/gloves/roguetown/leather
			pants = /obj/item/clothing/under/roguetown/trou/leather
			shoes = /obj/item/clothing/shoes/roguetown/ridingboots
			backr = /obj/item/rogueweapon/halberd/bardiche
			backl = /obj/item/rogueweapon/shield/tower
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/rogueweapon/huntingknife/idagger


/datum/outfit/job/roguetown/adventurer/sfighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)

	if(H.gender == FEMALE)
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_SOOT_BLACK
		H.update_body()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	//pants = /obj/item/clothing/under/roguetown/tights/black
	//backl = /obj/item/storage/backpack/rogue/satchel
	//backr = /obj/item/rogueweapon/shield/wood
	//beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	var/armortype = pickweight(list("Ironmail" = 6, "Ironplate" = 3, "Ironplate&Legs" = 1)) // At best they can get an iron breastplate over mail and iron chainleggings
	var/weapontype = pickweight(list("Axe" = 2, "Mace" = 2, "Messer" = 2, "Sword" = 3, "Flail" = 1)) // Rolls for various weapons, all of these are iron tier
	switch(armortype)
		if("Ironmail")
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
		if("Ironplate")
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
		if("Ironplate&Legs") // Big roller gets an iron cuirass over iron mail AND iron chain leggings. Lucky them
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	switch(weapontype) // We get +1 weapon skill in either axes/maces, swords, or flails depending on our starting weapon
		if("Axe")
			beltl = /obj/item/rogueweapon/axe/iron
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Mace")
			beltl = /obj/item/rogueweapon/mace
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		if("Messer")
			beltl = /obj/item/rogueweapon/sword/scimitar/messer
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Sword")
			beltl = /obj/item/rogueweapon/sword/iron
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Flail") // Big roller gets one of the best weapons to pair with a shield, even if it is only iron tier. Lucky bastard
			beltl = /obj/item/rogueweapon/flail
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)

	if(prob(66))
		neck = /obj/item/clothing/neck/roguetown/gorget
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	else // High roller gets an iron chain coif and nasal helmet
		neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		head = /obj/item/clothing/head/roguetown/helmet

	H.change_stat("strength", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", -1) // Muscle brains
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // MEDIUM armor training only, this is not a rare drifter, they shouldn't have more armor training than a garrison guard
