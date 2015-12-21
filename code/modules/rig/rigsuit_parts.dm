
//Defines the helmets, gloves and shoes for rigs.

/obj/item/rig/head
	name = "Helmet"
	flags = HEADCOVERSEYES | BLOCKHAIR | HEADCOVERSMOUTH | THICKMATERIAL
	flags_inv = 		 HIDEEARS|HIDEEYES|HIDEFACE
	body_parts_covered = HEAD|FACE|EYES
	heat_protection =    HEAD|FACE|EYES
	cold_protection =    HEAD|FACE|EYES
	var/brightness_on = 4
	sprite_sheets = list("Tajara" = 'icons/mob/species/tajaran/helmet.dmi',"Skrell" = 'icons/mob/species/skrell/helmet.dmi',"Unathi" = 'icons/mob/species/unathi/helmet.dmi')
	species_restricted = null

	var/light_overlay = "helmet_light"
	var/light_applied
	var/on = 0

	attack_self(mob/user)
		if(!isturf(user.loc))
			user << "You cannot turn the light on while in this [user.loc]" //To prevent some lighting anomalities.
			return
		on = !on
		icon_state = "hardhat[on]_[item_color]"
		item_state = "hardhat[on]_[item_color]"

		if(on)	user.SetLuminosity(user.luminosity + brightness_on)
		else	user.SetLuminosity(user.luminosity - brightness_on)

	pickup(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity + brightness_on)
//			user.UpdateLuminosity()	//TODO: Carn
			SetLuminosity(0)

	dropped(mob/user)
		if(on)
			user.SetLuminosity(user.luminosity - brightness_on)
//			user.UpdateLuminosity()
			SetLuminosity(brightness_on)

/obj/item/rig/hand
	name = "Gauntlets"
	flags = THICKMATERIAL
	body_parts_covered = HANDS
	heat_protection =    HANDS
	cold_protection =    HANDS
	species_restricted = null
	gender = PLURAL

/obj/item/rig/foot
	name = "Boots"
	body_parts_covered = FEET
	cold_protection = FEET
	heat_protection = FEET
	species_restricted = null
	gender = PLURAL
	var/icon_base = null

/obj/item/rig/chest
	name = "Chestpiece"
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv =          HIDEJUMPSUIT|HIDETAIL
	flags =              STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	slowdown = 0
	//will reach 10 breach damage after 25 laser carbine blasts, 3 revolver hits, or ~1 PTR hit. Completely immune to smg or sts hits.
	var/breach_threshold = 38
	var/resilience = 0.2
	var/can_breach = 1
	var/supporting_limbs = list()
	sprite_sheets = list("Tajara" = 'icons/mob/species/tajaran/suit.dmi',"Unathi" = 'icons/mob/species/unathi/suit.dmi')

/obj/item/rig/head/proc/prevent_track()
	return 0

/obj/item/rig/hand/Touch(var/atom/A, var/proximity)
	if(!A || !proximity)
		return 0

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || !H.back)
		return 0

	var/obj/item/rig/suit = H.back
	if(!suit || !istype(suit) || !suit.installed_modules.len)
		return 0

	for(var/obj/item/rig/module/module in suit.installed_modules)
		if(module.active && module.activates_on_touch)
			if(module.engage(A))
				return 1
	return 0

//Rig pieces for non-spacesuit based rigs
/obj/item/rig/head/light
	name = "mask"
	body_parts_covered = HEAD|FACE|EYES
	heat_protection =    HEAD|FACE|EYES
	cold_protection =    HEAD|FACE|EYES
	flags =              THICKMATERIAL|AIRTIGHT

/obj/item/rig/light
	name = "suit"
	allowed = list(/obj/item/device/flashlight)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv =          HIDEJUMPSUIT
	flags =              THICKMATERIAL

/obj/item/rig/shoe/light
	name = "boots"
	body_parts_covered = FEET
	cold_protection = FEET
	heat_protection = FEET
	species_restricted = null
	gender = PLURAL

/obj/item/rig/hand/light
	name = "gloves"
	flags = THICKMATERIAL
	body_parts_covered = HANDS
	heat_protection =    HANDS
	cold_protection =    HANDS
	species_restricted = null
	gender = PLURAL
