
//Asset Protection Suit
/obj/item/clothing/head/helmet/space/rig/engineering
	name = "Asset Protection Rigsuit"
	desc = "A space suit for NanoTrasens finest, if you ever see one of these, your ass is in deep shit."
	icon_state = "rig0-engineering"
	item_state = "eng_helm"
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 80)

/obj/item/clothing/suit/space/rig/engineering
	name = "engineering hardsuit"
	desc = "A space suit for NanoTrasens finest, if you ever see one of these, your ass is in deep shit."
	icon_state = "rig-engineering"
	item_state = "eng_hardsuit"
	slowdown = 1
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 80)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
