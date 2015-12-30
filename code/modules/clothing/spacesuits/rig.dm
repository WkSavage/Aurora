//Regular rig suits
/obj/item/clothing/head/helmet/space/rig
	name = "hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment."
	icon_state = "rig0-engineering"
	item_state = "eng_helm"
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 20)
	allowed = list(/obj/item/device/flashlight)
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	item_color = "engineering" //Determines used sprites: rig[on]-[color] and rig[on]-[color]2 (lying down sprite)
	icon_action_button = "action_hardhat"
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE

	//Species-specific stuff.
	species_restricted = list("exclude","Unathi","Tajaran","Skrell","Diona","Vox")
	sprite_sheets_refit = list(
		"Unathi" = 'icons/mob/species/unathi/helmet.dmi',
		"Tajaran" = 'icons/mob/species/tajaran/helmet.dmi',
		"Skrell" = 'icons/mob/species/skrell/helmet.dmi',
		)
	sprite_sheets_obj = list(
		"Unathi" = 'icons/obj/clothing/species/unathi/hats.dmi',
		"Tajaran" = 'icons/obj/clothing/species/tajaran/hats.dmi',
		"Skrell" = 'icons/obj/clothing/species/skrell/hats.dmi',
		)

	attack_self(mob/user)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]" //To prevent some lighting anomalities.
			return
		on = !on
		icon_state = "rig[on]-[item_color]"
//		item_state = "rig[on]-[color]"

		if(on)	user.SetLuminosity(user.luminosity + brightness_on)
		else	user.SetLuminosity(user.luminosity - brightness_on)

		if(istype(user,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = user
			H.update_inv_head()

	pickup(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity + brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(0)

	dropped(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity - brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(brightness_on)

/obj/item/clothing/suit/space/rig
	name = "hardsuit"
	desc = "A special space suit for environments that might pose hazards beyond just the vacuum of space. Provides more protection than a standard space suit."
	icon_state = "rig-engineering"
	item_state = "eng_hardsuit"
	slowdown = 1
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 20)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit)
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE

	species_restricted = list("exclude","Unathi","Tajaran","Diona","Vox")
	sprite_sheets_refit = list(
		"Unathi" = 'icons/mob/species/unathi/suit.dmi',
		"Tajaran" = 'icons/mob/species/tajaran/suit.dmi',
		"Skrell" = 'icons/mob/species/skrell/suit.dmi',
		)
	sprite_sheets_obj = list(
		"Unathi" = 'icons/obj/clothing/species/unathi/suits.dmi',
		"Tajaran" = 'icons/obj/clothing/species/tajaran/suits.dmi',
		"Skrell" = 'icons/obj/clothing/species/skrell/suits.dmi',
		)

	//Breach thresholds, should ideally be inherited by most (if not all) hardsuits.
	breach_threshold = 18
	can_breach = 1

	//Component/device holders.
//	var/obj/item/weapon/stock_parts/gloves = null     // Basic capacitor allows insulation, upgrades allow shock gloves etc.

	var/attached_boots = 1                            // Can't wear boots if some are attached
	var/obj/item/clothing/shoes/magboots/boots = null // Deployable boots, if any.
	var/attached_helmet = 1                           // Can't wear a helmet if one is deployable.
	var/obj/item/clothing/head/helmet/helmet = null   // Deployable helmet, if any.
//	var/obj/item/weapon/tank/tank = null
	var/obj/item/clothing/mask/breath/mask = null

//	var/list/max_mounted_devices = 0                  // Maximum devices. Easy.
//	var/list/can_mount = null                         // Types of device that can be hardpoint mounted.
//	var/list/mounted_devices = null                   // Holder for the above device.
//	var/obj/item/active_device = null                 // Currently deployed device, if any.

/obj/item/clothing/suit/space/rig/equipped(mob/M)
	..()

	var/mob/living/carbon/human/H = M

	if(!istype(H)) return

	if(H.wear_suit != src)
		return

	if(attached_helmet && helmet)
		if(H.head)
			M << "You are unable to deploy your suit's helmet as \the [H.head] is in the way."
		else
			M << "Your suit's helmet deploys with a hiss."
			//TODO: Species check, skull damage for forcing an unfitting helmet on?
			helmet.loc = H
			H.equip_to_slot(helmet, slot_head)
			helmet.canremove = 0

	if(attached_boots && boots)
		if(H.shoes)
			M << "You are unable to deploy your suit's magboots as \the [H.shoes] are in the way."
		else
			M << "Your suit's boots deploy with a hiss."
			boots.loc = H
			H.equip_to_slot(boots, slot_shoes)
			boots.canremove = 0

	if(mask)
		if(H.wear_mask)
			M << "You are unable to deploy your suit's mask as \the [H.wear_mask] is in the way."
		else
			M << "Your suit's mask deploys with a hiss."
			mask.loc = H
			H.equip_to_slot(mask, slot_wear_mask)
			mask.canremove = 0
/*
	if(tank)
		if(H.s_store)
			M << "\red If you ever see this message tell Scopes"
		else
			tank.loc = H
			H.equip_to_slot(tank, slot_s_store)
			tank.canremove = 0
*/

/obj/item/clothing/suit/space/rig/dropped()
	var/mob/living/carbon/human/H
/*	if(tank)//do this first
		H = tank.loc
		if(istype(H))
			if(tank && H.s_store == tank)
				tank.canremove = 1
//				H.drop_from_inventory(tank)
				tank.loc = src
*/
	if(helmet)
		H = helmet.loc
		if(istype(H))
			if(helmet && H.head == helmet)
				helmet.canremove = 1
				H.drop_from_inventory(helmet)
				helmet.loc = src

	if(boots)
		H = boots.loc
		if(istype(H))
			if(boots && H.shoes == boots)
				boots.canremove = 1
				H.drop_from_inventory(boots)
				boots.loc = src

	if(mask)
		H = mask.loc
		if(istype(H))
			if(mask && H.wear_mask == mask)
				mask.canremove = 1
				H.drop_from_inventory(mask)
				mask.loc = src

	..() //then everything else


/*
/obj/item/clothing/suit/space/rig/verb/get_mounted_device()

	set name = "Deploy Mounted Device"
	set category = "Object"
	set src in usr

	if(!can_mount)
		verbs -= /obj/item/clothing/suit/space/rig/verb/get_mounted_device
		verbs -= /obj/item/clothing/suit/space/rig/verb/stow_mounted_device
		return

	if(!istype(usr, /mob/living)) return
	if(usr.stat) return

	if(active_device)
		usr << "You already have \the [active_device] deployed."
		return

	if(!mounted_devices.len)
		usr << "You do not have any devices mounted on \the [src]."
		return

/obj/item/clothing/suit/space/rig/verb/stow_mounted_device()

	set name = "Stow Mounted Device"
	set category = "Object"
	set src in usr

	if(!can_mount)
		verbs -= /obj/item/clothing/suit/space/rig/verb/get_mounted_device
		verbs -= /obj/item/clothing/suit/space/rig/verb/stow_mounted_device
		return

	if(!istype(usr, /mob/living)) return

	if(usr.stat) return

	if(!active_device)
		usr << "You have no device currently deployed."
		return
*/

/obj/item/clothing/suit/space/rig/verb/toggle_helmet()

	set name = "Toggle Helmet"
	set category = "Object"
	set src in usr

	if(!istype(src.loc,/mob/living)) return

	if(!helmet)
		usr << "There is no helmet installed."
		return

	var/mob/living/carbon/human/H = usr

	if(!istype(H)) return
	if(H.stat) return
	if(H.wear_suit != src) return

	if(H.head == helmet)
		helmet.canremove = 1
		H.drop_from_inventory(helmet)
		helmet.loc = src
		H << "\blue You retract your hardsuit helmet."
	else
		if(H.head)
			H << "\red You cannot deploy your helmet while wearing another helmet."
			return
		//TODO: Species check, skull damage for forcing an unfitting helmet on?
		// Yes please -Sound
		helmet.loc = H
		H.equip_to_slot(helmet, slot_head)
		helmet.canremove = 0
		H << "\blue You deploy your hardsuit helmet, sealing you off from the world."

/obj/item/clothing/suit/space/rig/attackby(obj/item/W as obj, mob/user as mob)

	if(!istype(user,/mob/living)) return

	if(user.a_intent == "help")
		var/target_zone = user.zone_sel.selecting

		//You can't modify a suit while wearing it, but you can remove the tank if you click it with another tank or screwdriver
		if(istype(src.loc,/mob/living))
/*			if((istype(W,/obj/item/weapon/screwdriver) || istype(W, /obj/item/weapon/tank)) && target_zone == "chest")
				if(!tank && istype(W, /obj/item/weapon/tank))
					user << "You attach \the [W] to \the [src]'s tank mount."
					user.drop_item()
					tank = W
					tank.loc = user
					user.equip_to_slot(tank, slot_s_store)
					tank.canremove = 0
					return
				else
					var/mob/living/carbon/human/H = user
					if(tank && H.s_store == tank)
						tank.canremove = 1
						H.drop_from_inventory(tank)
					user << "You detatch \the [tank] from \the [src]'s tank mount."
					tank.loc = get_turf(src)
					tank = null
					if(istype(W, /obj/item/weapon/tank))
						user << "You attach \the [W] to \the [src]'s tank mount."
						user.drop_item()
						tank = W
						tank.loc = user
						user.equip_to_slot(tank, slot_s_store)
						tank.canremove = 0
				return*/
			user << "How do you propose to modify a hardsuit while it is being worn?"
			return

		//begin doing stuff with putting them on
		switch(W.parent_type)
/*			if(/obj/item/weapon/tank)
				if(!tank)
					user << "You attach \the [W] to \the [src]'s tank mount."
					user.drop_item()
					W.loc = src
					src.tank = W
				else
					user << "\The [src] already has a tank mounted." //Do a thing here so you can switch tanks
				return
*/
			if(/obj/item/clothing/shoes)
				if(istype(W, /obj/item/clothing/shoes/magboots))
					if(!boots)
						user << "You attach \the [W] to \the [src]'s boot mounts."
						user.drop_item()
						W.loc = src
						src.boots = W
					else
						user << "\The [src] already has magboots installed."
					return
				else
					user << "You can't find a way to attach \the [W] to \the [src]"
					return

			if(/obj/item/clothing/mask)
				if(istype(W, /obj/item/clothing/mask/breath))
					if(!mask)
						user << "You attach \the [W] to \the [src]'s mask mount."
						user.drop_item()
						W.loc = src
						src.mask = W
					else
						user << "\The [src] already has a mask installed."
					return
				else
					user << "You can't find a way to attach \the [W] to \the [src]"
					return

		if(istype(W, /obj/item/clothing/head/helmet/space)) //WTF WHAT IS THIS, some nasty hack why, meh.
			if(istype(W, /obj/item/clothing/head/helmet/space/rig))
				if(!helmet)
					user << "You attach \the [W] to \the [src]'s helmet mount."
					user.drop_item()
					W.loc = src
					src.helmet = W
				else
					user << "\The [src] already has a helmet installed."
				return
			else
				user << "You can't find a way to attach \the [W] to \the [src]"
				return

		//now we can remove
		if(istype(W,/obj/item/weapon/screwdriver))
			switch(target_zone)
				if("head")
					if(!helmet)
						user << "\The [src] does not have a helmet installed."
					else
						user << "You detatch \the [helmet] from \the [src]'s helmet mount."
						helmet.loc = get_turf(src)
						src.helmet = null
					return

				//Fricking boots and Switches
				if("l_leg")
					if(!boots)
						user << "\The [src] does not have any boots installed."
					else
						user << "You detatch \the [boots] from \the [src]'s boot mounts."
						boots.loc = get_turf(src)
						boots = null
					return
				if("r_leg")
					if(!boots)
						user << "\The [src] does not have any boots installed."
					else
						user << "You detatch \the [boots] from \the [src]'s boot mounts."
						boots.loc = get_turf(src)
						boots = null
					return
				if("l_foot")
					if(!boots)
						user << "\The [src] does not have any boots installed."
					else
						user << "You detatch \the [boots] from \the [src]'s boot mounts."
						boots.loc = get_turf(src)
						boots = null
					return
				if("r_foot")
					if(!boots)
						user << "\The [src] does not have any boots installed."
					else
						user << "You detatch \the [boots] from \the [src]'s boot mounts."
						boots.loc = get_turf(src)
						boots = null
					return
/*
				if("chest")
					if(!tank)
						user << "\The [src] does not have a tank mounted."
					else
						user << "You detatch \the [tank] from \the [src]'s tank mount."
						tank.loc = get_turf(src)
						tank = null
					return
*/
				if("mouth")
					if(!mask)
						user << "\The [src] does not have a mask installed."
					else
						user << "You detatch \the [mask] from \the [src]'s mask attachment."
						mask.loc = get_turf(src)
						mask = null
					return
		else //Why is this statement here
			return ..()
	return ..()

/*

		var/target_zone = user.zone_sel.selecting

		if(target_zone == "head")

			//Installing a component into or modifying the contents of the helmet.
			if(!attached_helmet)
				user << "\The [src] does not have a helmet mount."
				return

			if(istype(W,/obj/item/weapon/screwdriver))
				if(!helmet)
					user << "\The [src] does not have a helmet installed."
				else
					user << "You detatch \the [helmet] from \the [src]'s helmet mount."
					helmet.loc = get_turf(src)
					src.helmet = null
				return
			else if(istype(W,/obj/item/clothing/head/helmet/space))
				if(helmet)
					user << "\The [src] already has a helmet installed."
				else
					user << "You attach \the [W] to \the [src]'s helmet mount."
					user.drop_item()
					W.loc = src
					src.helmet = W
				return
			else
				return ..()

		else if(target_zone == "l_leg" || target_zone == "r_leg" || target_zone == "l_foot" || target_zone == "r_foot")

			//Installing a component into or modifying the contents of the feet.
			if(!attached_boots)
				user << "\The [src] does not have boot mounts."
				return

			if(istype(W,/obj/item/weapon/screwdriver))
				if(!boots)
					user << "\The [src] does not have any boots installed."
				else
					user << "You detatch \the [boots] from \the [src]'s boot mounts."
					boots.loc = get_turf(src)
					boots = null
				return
			else if(istype(W,/obj/item/clothing/shoes/magboots))
				if(boots)
					user << "\The [src] already has magboots installed."
				else
					user << "You attach \the [W] to \the [src]'s boot mounts."
					user.drop_item()
					W.loc = src
					boots = W
			else
				return ..()

		/*
		else if(target_zone == "l_arm" || target_zone == "r_arm" || target_zone == "l_hand" || target_zone == "r_hand")

			//Installing a component into or modifying the contents of the hands.

		else if(target_zone == "torso" || target_zone == "groin")

			//Modifying the cell or mounted devices

			if(!mounted_devices)
				return
		*/

		else //wat
			return ..()

	..()
*/