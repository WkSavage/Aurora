// WIP. WkSavage

/obj/machinery/sft
	name = "Security Fine Terminal
	desc = "For all your monetary needs!"
	icon = 'icons/obj/terminals.dmi'
	icon_state = "atm"
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	var/maxtime = 60
	var/maxfine = 3760
	var/authenticated = 0

/obj/machinery/sft/New()
	..()

/obj/machinery/sft/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/card))


