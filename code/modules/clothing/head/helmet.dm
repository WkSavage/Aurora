/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES | THICKMATERIAL
	item_state = "helmet"
	armor = list(melee = 40, bullet = 20, laser = 40, energy = 20, bomb = 20, bio = 0, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	siemens_coefficient = 0.7
	w_class = 3

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "riot"
	item_state = "helmet"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES
	armor = list(melee = 85, bullet = 30, laser = 5, energy = 5, bomb = 10, bio = 10, rad = 0)
	flags_inv = HIDEEARS
	siemens_coefficient = 0.7

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "They're often used by highly trained Swat Members."
	icon_state = "swat"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "swat"
	armor = list(melee = 85, bullet = 60, laser = 60, energy = 60, bomb = 50, bio = 10, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES
	cold_protection = HEAD
	siemens_coefficient = 0.5

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper Thunderdome helmet"
	desc = "<i>'Let the battle commence!'</i>"
	icon_state = "thunderdome"
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES
	item_state = "thunderdome"
	armor = list(melee = 85, bullet = 60, laser = 60, energy = 60, bomb = 60, bio = 10, rad = 0)
	cold_protection = HEAD
	siemens_coefficient = 1

/obj/item/clothing/head/helmet/gladiator
	name = "gladiator helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES|HEADCOVERSMOUTH|BLOCKHAIR
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES
	siemens_coefficient = 1

/obj/item/clothing/head/helmet/tactical
	name = "tactical helmet"
	desc = "An armored helmet capable of being fitted with a multitude of attachments."
	icon_state = "swathelm"
	item_state = "helmet"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES
	armor = list(melee = 65, bullet = 60, laser = 50, energy = 35, bomb = 10, bio = 2, rad = 0)
	flags_inv = HIDEEARS
	siemens_coefficient = 0.7

/obj/item/clothing/head/helmet/iac
	name = "IAC helmet"
	desc = "A helmet worn by medical workers of the Interstellar Aid Corps."
	icon = 'icons/obj/clothing/iac_uniform.dmi'
	item_state = "iac_helmet"
	icon_state = "iac_helmet"
	armor = list(melee = 50, bullet = 30, laser = 30, energy = 15, bomb = 10, bio = 20, rad = 0)
	flags_inv = HIDEEARS|HIDEEYES