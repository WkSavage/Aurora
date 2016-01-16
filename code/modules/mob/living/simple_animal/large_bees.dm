//BEES. BIG PLAYS. -WkSavage

/mob/living/simple_animal/largebee
	name = "\improper Large Space Bee"
	desc = "This is a large space bee. It is terrifiying."
	icon = 'icons/mob/animal.dmi'
	icon_state = "parrot_fly"
	icon_living = "parrot_fly"
	icon_dead = "parrot_dead"
	pass_flags = PASSTABLE
	small = 1
	health = 200

	speak = list("Bzzzzz","Hmmmmmm","Buzzzz")
	speak_emote = list("buzzes")
	emote_hear = list("buzzes")
	emote_see = list("buzzes around")

	speak_chance = 1//1% (1 in 100) chance every tick; So about once per 150 seconds, assuming an average tick is 1.5s
	turns_per_move = 5
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/cracker/

	response_help  = "pets the"
	response_disarm = "gently moves aside the"
	response_harm   = "swats at the"
	stop_automated_movement = 1
	universal_speak = 1

	var/list/speech_buffer = list()
	var/atom/movable/bee_interest = null

	var/maxhealth = 200
	var/angered = 0
	var/anger = 0
	var/angermax = 100

	var/sleeptimercurrent = 0
	var/sleeptimermax = 60
	var/awaketimercurrent = 0
	var/awaketimermax = 720

	var/basedamagestat = 1
	var/mindamagestat = 1
	var/maxdamagestat = 20
	var/multiplyer = 1
	var/minmultiplyer = 1
	var/maxmultiplyer = 5

	var/bee_sleep_max = 30 //The maximum time a bee can bee asleep
	var/bee_sleep_dur = 30 //Same as above, this is the var that physically counts down


/mob/living/simple_animal/largebee/New()
	..()
	bee_sleep_dur = bee_sleep_max //In case someone decides to change the max without changing the duration var

/mob/living/simple_animal/largebee/Life()
	..()

	if(sleeping == 0)
		if(awaketimercurrent < awaketimermax)
			awaketimercurrent++
		if(awaketimercurrent == awaketimermax)
			sleeping = 1
			icon_state = "parrot_fly"
			sleeptimercurrent = 0

	if(sleeping == 1)
		if(sleeptimercurrent < sleeptimermax)
			sleeptimercurrent++
		if(sleeptimercurrent == sleeptimermax)
			sleeping = 0
			awaketimercurrent = 0
			icon_state = "parrot_fly"

	if(sleeping == 1 && !mindamagestat && basedamagestat > 1)
		basedamagestat--
	else
		return

	if(anger == 100)
		anger--
	else
		return

	if(anger > 1)
		angered = 1
		if(sleeping == 0 && !maxdamagestat &&  basedamagestat < 35)
			basedamagestat++

	if(angered == 1)
		if(!maxmultiplyer && multiplyer < 5.0001)
			multiplyer++
		else
			multiplyer--
	if(angered == 0)
		if(!minmultiplyer && multiplyer > 0.9)
			multiplyer--
		else
			multiplyer++

	var/mob/living/carbon/human/M
	if(M in view(src,1)) // Can I see my target?
		if(anger > 0) // ARE WE ANGRY?
			if(sleeping == 0) // ATTACK if we are AWAKE
				var/totaldamage = basedamagestat * multiplyer
				M.apply_damage(totaldamage) // BASE DAMAGE
				M.apply_damage(anger * 0.01) // MORE ANGER IS MORE PENETRATION
				M << "\red You have been stung!"
				M.flash_pain()
				M = bee_interest



/mob/living/simple_animal/largebee/death()
	walk(src,0)
	..()

/mob/living/simple_animal/largebee/attack_hand(mob/living/carbon/M as mob)
	..()
	if(client) return
	if(!stat && M.a_intent == "hurt")

		icon_state = "parrot_fly" //You pissed it off.

		if(anger == 0 && sleeping == 0)
			if(health < maxhealth)
				anger++
				if(anger < 25)
					anger = 25
			else
				return
		if(anger == 0 && sleeping == 1)
			if(health < maxhealth)
				anger = 50 // never wake a sleeping bee
				if(anger <= 50)
					anger++
			else
				return

		bee_interest = M

		if(sleeping == 1)
			bee_sleep_dur = bee_sleep_max  //Reset it's sleep timer
			sleeping = 0

	return

/mob/living/simple_animal/largebee/attackby(var/obj/item/O as obj, var/mob/user as mob)
	..()
	if(!stat && !client && !istype(O))
		if(O.force > 1)
			if(sleeping == 1)
				bee_sleep_dur = bee_sleep_max  //Reset it's sleep timer
				sleeping = 0

			bee_interest = user
	return

/mob/living/simple_animal/largebee/bullet_act(var/obj/item/projectile/Proj)
	..()
	if(!stat && !client)
		if(sleeping == 1)
			sleeping = 0
			angered = 1

		bee_interest = null
		anger = 95
		icon_state = "parrot_fly"

	return


