/obj/item/rig/head/proc/toggle_helmet()
	set name = "Toggle Helmet"
	set desc = "Deploys or retracts your helmet."
	set category = "Hardsuit"
	set src = usr.contents

	if(!istype(wearer) || !wearer.back == src)
		usr << "<span class='warning'>The hardsuit is not being worn.</span>"
		return

	if(!check_suit_access(usr))
		return

	toggle_piece("head",wearer)

/obj/item/rig/chest/proc/toggle_chest()
	set name = "Toggle Chestpiece"
	set desc = "Deploys or retracts your chestpiece."
	set category = "Hardsuit"
	set src = usr.contents

	if(!check_suit_access(usr))
		return

	toggle_piece("chest",wearer)

/obj/item/rig/proc/toggle_gauntlets()
	set name = "Toggle Gauntlets"
	set desc = "Deploys or retracts your gauntlets."
	set category = "Hardsuit"
	set src = usr.contents

	if(!istype(wearer) || !wearer.back == src)
		usr << "<span class='warning'>The hardsuit is not being worn.</span>"
		return

	if(!check_suit_access(usr))
		return

	toggle_piece("hand",wearer)

/obj/item/rig/foot/proc/toggle_boots()
	set name = "Toggle Boots"
	set desc = "Deploys or retracts your boots."
	set category = "Hardsuit"
	set src = usr.contents

	if(!istype(wearer) || !wearer.back == src)
		usr << "<span class='warning'>The hardsuit is not being worn.</span>"
		return

	if(!check_suit_access(usr))
		return

	toggle_piece("foot",wearer)