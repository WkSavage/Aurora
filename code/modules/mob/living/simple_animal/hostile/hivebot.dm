/obj/item/projectile/beam/hivebotbullet
	damage = 10
	damage_type = BURN
	flag = "laser"
	eyeblur = 2
	icon_state = "laser"

/mob/living/simple_animal/hostile/hivebot
	name = "Hivebot"
	desc = "A small robot"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "hivebot"
	icon_living = "hivebot"
	icon_dead = "hivebot_gib"
	icon_gib = "hivebot_gib"
	health = 15
	maxHealth = 15
	melee_damage_lower = 2
	melee_damage_upper = 3
	attacktext = "clawed"
	projectilesound = 'sound/weapons/Laser2.ogg'
	projectiletype = /obj/item/projectile/beam/hivebotbullet
	faction = "hivebot"
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	speed = 4

/mob/living/simple_animal/hostile/hivebot/range
	name = "Hivebot"
	desc = "A smallish robot, this one is armed!"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "rangebot"
	icon_living = "rangebot"
	icon_dead = "rangebot_gib"
	icon_gib = "rangebot_gib"
	ranged = 1

/mob/living/simple_animal/hostile/hivebot/britbot
	name = "Hivebot"
	desc = "A smallish robot, this one is quite stylish!"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "britbot"
	icon_living = "britbot"
	icon_dead = "britbot"

/mob/living/simple_animal/hostile/hivebot/rapid
	ranged = 1
	rapid = 1

/mob/living/simple_animal/hostile/hivebot/strong
	name = "Strong Hivebot"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "juggerbot"
	icon_living = "juggerbot"
	icon_dead = "juggerbot_gib"
	icon_gib = "juggerbot_gib"
	desc = "A robot, this one is armed and looks tough!"
	health = 100
	ranged = 0
	melee_damage_lower = 10
	melee_damage_upper = 10

/mob/living/simple_animal/hostile/hivebot/hivemind
	name = "Hivemind"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "hivemind"
	icon_living = "hivemind"
	icon_dead = "hivemind_dead"
	icon_gib = "hivemind_gib"
	desc = " A squiddly-diddly Hivemind.. Huh, that beak kinda looks scary from a distance."
	health = 50
	maxHealth = 50
	melee_damage_lower = 0.5
	melee_damage_upper = 1
	health = 15
	ranged = 0

/mob/living/simple_animal/hostile/hivemech
	name = "Hivemech"
	desc = "A hivemind's mech.. Squiddly-diddly in there looks like they're the one guiding the bots around for the most part."
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "Hivemech"
	icon_living = "Hivemech"
	icon_dead = "Hivemech"
	icon_gib = "Hivemech_gib"
	health = 250
	maxHealth = 250
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "spiked"
	speed = 1.75

/mob/living/simple_animal/hostile/hivebot/death()
	..()
	visible_message("<b>[src]</b> blows apart!")
	new /obj/effect/decal/cleanable/blood/gibs/robot(src.loc)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	if(prob(10))
		new /obj/item/clothing/head/welding/hivebot
	del(src)
	return

/mob/living/simple_animal/hostile/hivebot/tele//this still needs work
	name = "Beacon"
	desc = "Some odd beacon thing"
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "spawnbot"
	icon_living = "spawnbot"
	icon_gib = "spawnbot_gib"
	health = 200
	maxHealth = 200
	status_flags = 0
	anchored = 1
	stop_automated_movement = 1
	var/bot_type = "norm"
	var/bot_amt = 10
	var/spawn_delay = 600
	var/turn_on = 0
	var/auto_spawn = 1
	proc
		warpbots()

	New()
		..()
		var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
		smoke.set_up(5, 0, src.loc)
		smoke.start()
		visible_message("\red <B>The [src] warps in!</B>")
		playsound(src.loc, 'sound/effects/EMPulse.ogg', 25, 1)

	warpbots()
		icon_state = "def_radar"
		visible_message("\red The [src] turns on!")
		while(bot_amt > 0)
			bot_amt--
			switch(bot_type)
				if("norm")
					new /mob/living/simple_animal/hostile/hivebot(get_turf(src))
				if("range")
					new /mob/living/simple_animal/hostile/hivebot/range(get_turf(src))
				if("rapid")
					new /mob/living/simple_animal/hostile/hivebot/rapid(get_turf(src))
		spawn(100)
			del(src)
		return


	Life()
		..()
		if(stat == 0)
			if(prob(2))//Might be a bit low, will mess with it likely
				warpbots()

