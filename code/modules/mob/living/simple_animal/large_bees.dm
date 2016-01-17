//BEES. BIG PLAYS. -WkSavage

/mob/living/simple_animal/largebee
	name = "\improper Large Space Bee"
	desc = "This is a large space bee. It is terrifiying."
	icon = 'icons/mob/bigbees.dmi'
	icon_state = "bigbee"
	icon_living = "bigbee"
	icon_dead = "bigbee"
	pass_flags = PASSTABLE
	small = 1
	health = 100

	speak_emote = list("buzzes")
	emote_hear = list("buzzes")
	emote_see = list("buzzes around")

	speak_chance = 1//1% (1 in 100) chance every tick; So about once per 150 seconds, assuming an average tick is 1.5s
	turns_per_move = 6

	response_help  = "pets the"
	response_disarm = "gently moves aside the"
	response_harm   = "swats at the"
	universal_speak = 1

	var/list/speech_buffer = list()
	var/atom/movable/bee_interest = null
	var/turf/target_turf

	var/maxhealth = 100
	var/angered = 0
	var/anger = 0
	var/angermax = 100
	var/currentcooldown = 0
	var/targetcooldown = 20
	var/calm = 1

	var/basedamagestat = 1
	var/mindamagestat = 1
	var/maxdamagestat = 20

/mob/living/simple_animal/largebee/New()
	..()
	calm = 1
	anger = 0
	angered = 0
	currentcooldown = 0

/mob/living/simple_animal/largebee/Life()
	..()
	if(calm == 1)
		anger = -10
		bee_interest = null
		target_turf = null
		wander = 1
		currentcooldown = 0
		if(prob(1))
			src.visible_message("\blue [pick("Buzzzz.","Hmmmmm.","Bzzz.")]")
	if(anger >= 10)
		angered = 1
		if(angered)
			calm = 0
	if(anger == 100)
		anger--
	if(anger > 0)
		currentcooldown++
		anger--
	if(currentcooldown == targetcooldown)
		calm = 1
		currentcooldown = 0
	if(calm == 1 && !mindamagestat && basedamagestat > 1)
		basedamagestat--
	if(calm == 0 && !maxdamagestat &&  basedamagestat < 20)
		basedamagestat++

	var/mob/living/carbon/human/M

	if(M in view(src,1)) // Can I see my target?
		if(angered == 1) // ARE WE ANGRY?
			if(calm == 0) // ATTACK if we are NOT CALM
				var/totaldamage = basedamagestat * 1.5
				M.apply_damage(totaldamage) // BASE DAMAGE
				M.apply_damage(anger * 0.01) // MORE ANGER IS MORE PENETRATION
				M << "\red You have been stung!"
				M.flash_pain()
				M = bee_interest

	if(target_turf)
		if(!(DirBlocked(get_step(src, get_dir(src,target_turf)),get_dir(src,target_turf)))) // Check for windows and doors!
			Move(get_step(src, get_dir(src,target_turf)))


/mob/living/simple_animal/largebee/death()
	..()

/mob/living/simple_animal/largebee/attack_hand(mob/living/carbon/M as mob)
	..()

	anger++

/mob/living/simple_animal/largebee/attackby(var/obj/item/O as obj, var/mob/user as mob)
	..()

	anger++

/mob/living/simple_animal/largebee/bullet_act(var/obj/item/projectile/Proj)
	..()

	anger = 95 // YOU PISSED IT OFF
	anger++

/mob/living/simple_animal/largebee/admin
	name = "\improper Large Angry Space Bee"
	desc = "This is a large space bee. It is terrifiying. This one has red eyes."
	icon = 'icons/mob/bees.dmi'
	icon_state = "beememe"
	icon_living = "beememe"
	icon_dead = "beememe"
	pass_flags = PASSTABLE
	small = 1
	health = 200