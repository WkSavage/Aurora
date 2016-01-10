/client/proc/cmd_manual_ban()
	set name = "Manual Ban"
	set category = "Admin"
	if(!holder)
		src << "Only administrators may use this command."
		return
	var/mob/M = null
	switch(alert("How would you like to ban someone today?", "Manual Ban", "Key List", "Enter Manually", "Cancel"))
		if("Key List")
			var/list/keys = list()
			for(M in world)
				keys += M.client
			var/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in keys
			if(!selection)
				return
			M = selection:mob
			if(!holder)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return

	switch(alert("Temporary Ban?", "Yes", "No"))
		if("Yes")
			var/mins = input(usr,"How long (in minutes)?","Ban time",1440) as num
			if(!mins)
				return
			if(mins >= 525600) mins = 525599
			var/reason = input(usr,"Reason?","reason","Griefer") as text
			if(!reason)
				return
			if(M)
				AddBan(M.ckey, M.computer_id, reason, usr.ckey, 1, mins)
				M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
				M << "\red This is a temporary ban, it will be removed in [mins] minutes."
				M << "\red To try to resolve this matter head to http://ss13.donglabs.com/forum/"
				log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] minutes.")
				message_admins("\blue[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] minutes.")
				world.Export("http://216.38.134.132/adminlog.php?type=ban&key=[usr.client.key]&key2=[M.key]&msg=[html_decode(reason)]&time=[mins]&server=[replacetext(config.server_name, "#", "")]")
				del(M.client)
				del(M)
			else
		if("No")
			var/reason = input(usr,"Reason?","reason","Griefer") as text
			if(!reason)
				return
			AddBan(M.ckey, M.computer_id, reason, usr.ckey, 0, 0)
			M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
			M << "\red This is a permanent ban."
			M << "\red To try to resolve this matter head to http://ss13.donglabs.com/forum/"
			log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
			message_admins("\blue[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
			world.Export("http://216.38.134.132/adminlog.php?type=ban&key=[usr.client.key]&key2=[M.key]&msg=[html_decode(reason)]&time=perma&server=[replacetext(config.server_name, "#", "")]")
			del(M.client)
			del(M)
