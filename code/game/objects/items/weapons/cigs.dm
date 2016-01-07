//Fine Smokeables.

/obj/item/clothing/mask/cigarette
	name = "cigarette"
	desc = "A roll of tobacco and nicotine."
	icon_state = "cigoff"
	throw_speed = 0.5
	item_state = "cigoff"
	w_class = 1
	body_parts_covered = 0
	attack_verb = list("burnt", "singed")
	var/lit = 0
	var/icon_on = "cigon"  //Note - these are in masks.dmi not in cigarette.dmi
	var/icon_off = "cigoff"
	var/type_butt = /obj/item/weapon/cigbutt
	var/lastHolder = null
	var/smoketime = 300
	var/chem_volume = 30
	var/can_hurt_mob = 1

/obj/item/clothing/mask/cigarette/New()
	..()
	flags |= NOREACT // so it doesn't react until you light it
	create_reagents(chem_volume) // making the cigarrete a chemical holder with a maximum volume of 15

/obj/item/clothing/mask/cigarette/Del()
	..()
	del(reagents)

/obj/item/clothing/mask/cigarette/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn())//Badasses dont get blinded while lighting their cig with a welding tool
			light("<span class='notice'>[user] casually lights the [name] with [W].</span>")

	else if(istype(W, /obj/item/weapon/lighter/zippo))
		var/obj/item/weapon/lighter/zippo/Z = W
		if(Z.lit)
			light("<span class='rose'>With a flick of their wrist, [user] lights  [name] with [W].</span>")

	else if(istype(W, /obj/item/weapon/lighter))
		var/obj/item/weapon/lighter/L = W
		if(L.lit)
			light("<span class='notice'>[user] manages to light their [name] with [W].</span>")

	else if(istype(W, /obj/item/weapon/match))
		var/obj/item/weapon/match/M = W
		if(M.lit)
			light("<span class='notice'>[user] lights their [name] with [W].</span>")

	else if(istype(W, /obj/item/weapon/melee/energy/sword))
		var/obj/item/weapon/melee/energy/sword/S = W
		if(S.active)
			light("<span class='warning'>[user] swings their [W], barely missing their nose. They light their [name] in the process.</span>")

	else if(istype(W, /obj/item/device/assembly/igniter))
		light("<span class='notice'>[user] fiddles with [W], and manages to light their [name].</span>")

	//can't think of any other way to update the overlays :<
	user.update_inv_wear_mask(0)
	user.update_inv_l_hand(0)
	user.update_inv_r_hand(1)
	return

/obj/item/clothing/mask/cigarette/attack(mob/M as mob, mob/user as mob)
	if(!can_hurt_mob)
		return ..()

	var/mob/living/carbon/human/H
	if(ishuman(M))
		H = M
	else
		return ..()

	if(lit)
		if (user.a_intent == "hurt")
			switch(user.zone_sel.selecting)
				if("eyes")
					H.apply_damage(6, BURN, "eyes")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] eyes!</B>", 1)
					H.say("*scream")
				if("mouth")
					H.apply_damage(6, BURN, "mouth")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] mouth!</B>", 1)
					H.say("*scream")
				if("head")
					H.apply_damage(6, BURN, "head")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] face!</B>", 1)
					H.say("*scream")
				if("chest")
					H.apply_damage(6, BURN, "chest")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] chest!</B>", 1)
					H.say("*scream")
				if("groin")
					H.apply_damage(6, BURN, "groin")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] groin!</B>", 1)
					H.say("*scream")
				if("l_arm")
					H.apply_damage(6, BURN, "l_arm")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] left arm!</B>", 1)
					H.say("*scream")
				if("r_arm")
					H.apply_damage(6, BURN, "r_arm")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] right arm!</B>", 1)
					H.say("*scream")
				if("l_leg")
					H.apply_damage(6, BURN, "l_leg")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] left leg!</B>", 1)
					H.say("*scream")
				if("l_hand")
					H.apply_damage(6, BURN, "l_hand")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] left hand!</B>", 1)
					H.say("*scream")
				if("r_hand")
					H.apply_damage(6, BURN, "r_hand")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] right hand!</B>", 1)
					H.say("*scream")
				if("r_foot")
					H.apply_damage(6, BURN, "r_foot")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] left foot!</B>", 1)
					H.say("*scream")
				if("l_foot")
					H.apply_damage(6, BURN, "l_foot")
					for(var/mob/O in viewers(H, null))
						O.show_message("\red <B>[user] has shoved [src] in [M] right foot!</B>", 1)
					H.say("*scream")
				else
					return ..()

			M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been burnt with [src.name] by [user.name] ([user.ckey])</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to burn [M.name] ([M.ckey])</font>")
			msg_admin_attack("[key_name_admin(user)] burnt [key_name_admin(user)] with [src.name] (INTENT: [uppertext(user.a_intent)]) - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>")


/obj/item/clothing/mask/cigarette/afterattack(obj/item/weapon/reagent_containers/glass/glass, mob/user as mob, proximity)
	..()
	if(!proximity) return
	if(istype(glass))	//you can dip cigarettes into beakers
		var/transfered = glass.reagents.trans_to(src, chem_volume)
		if(transfered)	//if reagents were transfered, show the message
			user << "<span class='notice'>You dip \the [src] into \the [glass].</span>"
		else			//if not, either the beaker was empty, or the cigarette was full
			if(!glass.reagents.total_volume)
				user << "<span class='notice'>[glass] is empty.</span>"
			else
				user << "<span class='notice'>[src] is full.</span>"


/obj/item/clothing/mask/cigarette/proc/light(var/flavor_text = "[usr] lights the [name].")
	if(!src.lit)
		src.lit = 1
		damtype = "fire"
		if(reagents.get_reagent_amount("plasma")) // the plasma explodes when exposed to fire
			var/datum/effect/effect/system/reagents_explosion/e = new()
			e.set_up(round(reagents.get_reagent_amount("plasma") / 2.5, 1), get_turf(src), 0, 0)
			e.start()
			del(src)
			return
		if(reagents.get_reagent_amount("fuel")) // the fuel explodes, too, but much less violently
			var/datum/effect/effect/system/reagents_explosion/e = new()
			e.set_up(round(reagents.get_reagent_amount("fuel") / 5, 1), get_turf(src), 0, 0)
			e.start()
			del(src)
			return
		flags &= ~NOREACT // allowing reagents to react after being lit
		reagents.handle_reactions()
		icon_state = icon_on
		item_state = icon_on
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
		processing_objects.Add(src)


/obj/item/clothing/mask/cigarette/process()
	var/turf/location = get_turf(src)
	var/mob/living/M = loc
	if(isliving(loc))
		M.IgniteMob()
	smoketime--
	if(smoketime < 1)
		die()
		return
	if(location)
		location.hotspot_expose(700, 5)
	if(reagents && reagents.total_volume)	//	check if it has any reagents at all
		if(iscarbon(loc) && (src == loc:wear_mask)) // if it's in the human/monkey mouth, transfer reagents to the mob
			if(istype(loc, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = loc
				if(H.species.flags & IS_SYNTHETIC)
					return
			var/mob/living/carbon/C = loc

			if(prob(15)) // so it's not an instarape in case of acid
				reagents.reaction(C, INGEST)
			reagents.trans_to(C, REAGENTS_METABOLISM)
		else // else just remove some of the reagents
			reagents.remove_any(REAGENTS_METABOLISM)
	return


/obj/item/clothing/mask/cigarette/attack_self(mob/user as mob)
	if(lit == 1)
		user.visible_message("<span class='notice'>[user] calmly drops and treads on the lit [src], putting it out instantly.</span>")
		die()
	return ..()


/obj/item/clothing/mask/cigarette/proc/die()
	var/turf/T = get_turf(src)
	var/obj/item/butt = new type_butt(T)
	transfer_fingerprints_to(butt)
	if(ismob(loc))
		var/mob/living/M = loc
		M << "<span class='notice'>Your [name] goes out.</span>"
		M.u_equip(src)	//un-equip it so the overlays can update
		M.update_inv_wear_mask(0)
	processing_objects.Remove(src)
	del(src)

////////////
// CIGARS //
////////////
/obj/item/clothing/mask/cigarette/cigar
	name = "premium cigar"
	desc = "A brown roll of tobacco and... well, you're not quite sure. This thing's huge!"
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	type_butt = /obj/item/weapon/cigbutt/cigarbutt
	throw_speed = 0.5
	item_state = "cigaroff"
	smoketime = 1500
	chem_volume = 20
	can_hurt_mob = 1

/obj/item/clothing/mask/cigarette/cigar/cohiba
	name = "\improper Cohiba Robusto cigar"
	desc = "There's little more you could want from a cigar."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	can_hurt_mob = 1

/obj/item/clothing/mask/cigarette/cigar/havana
	name = "premium Havanian cigar"
	desc = "A cigar fit for only the best of the best."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	smoketime = 7200
	chem_volume = 30
	can_hurt_mob = 1

/obj/item/weapon/cigbutt
	name = "cigarette butt"
	desc = "A manky old cigarette butt."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "cigbutt"
	w_class = 1
	throwforce = 1

/obj/item/weapon/cigbutt/New()
	..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	transform = turn(transform,rand(0,360))

/obj/item/weapon/cigbutt/cigarbutt
	name = "cigar butt"
	desc = "A manky old cigar butt."
	icon_state = "cigarbutt"


/obj/item/clothing/mask/cigarette/cigar/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn())
			light("<span class='notice'>[user] insults [name] by lighting it with [W].</span>")

	else if(istype(W, /obj/item/weapon/lighter/zippo))
		var/obj/item/weapon/lighter/zippo/Z = W
		if(Z.lit)
			light("<span class='rose'>With a flick of their wrist, [user] lights their [name] with their [W].</span>")

	else if(istype(W, /obj/item/weapon/lighter))
		var/obj/item/weapon/lighter/L = W
		if(L.lit)
			light("<span class='notice'>[user] manages to offend their [name] by lighting it with [W].</span>")

	else if(istype(W, /obj/item/weapon/match))
		var/obj/item/weapon/match/M = W
		if(M.lit)
			light("<span class='notice'>[user] lights their [name] with their [W].</span>")

	else if(istype(W, /obj/item/weapon/melee/energy/sword))
		var/obj/item/weapon/melee/energy/sword/S = W
		if(S.active)
			light("<span class='warning'>[user] swings their [W], barely missing their nose. They light their [name] in the process.</span>")

	else if(istype(W, /obj/item/device/assembly/igniter))
		light("<span class='notice'>[user] fiddles with [W], and manages to light their [name] with the power of science.</span>")
