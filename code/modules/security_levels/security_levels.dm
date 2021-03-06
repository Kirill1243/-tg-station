/var/security_level = 0
//0 = code green
//1 = code blue
//2 = code red
//3 = code delta

//config.alert_desc_blue_downto

/proc/set_security_level(level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != security_level)
		switch(level)
			if(SEC_LEVEL_GREEN)
				minor_announce(config.alert_desc_green, "��������! ������� ��������� ������� �� �������:")
				security_level = SEC_LEVEL_GREEN
				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION)
						FA.update_icon()
			if(SEC_LEVEL_BLUE)
				if(security_level < SEC_LEVEL_BLUE)
					minor_announce(config.alert_desc_blue_upto, "��������! ������� ��������� ������� �� ������:",1)
				else
					minor_announce(config.alert_desc_blue_downto, "��������! ������� ��������� ������� �� ������:")
				security_level = SEC_LEVEL_BLUE
				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION)
						FA.update_icon()
			if(SEC_LEVEL_RED)
				if(security_level < SEC_LEVEL_RED)
					minor_announce(config.alert_desc_red_upto, "��������! ������� ���!",1)
				else
					minor_announce(config.alert_desc_red_downto, "��������! ������� ���!")
				security_level = SEC_LEVEL_RED

				/*	- At the time of commit, setting status displays didn't work properly
				var/obj/machinery/computer/communications/CC = locate(/obj/machinery/computer/communications,world)
				if(CC)
					CC.post_status("alert", "redalert")*/

				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION)
						FA.update_icon()
				for(var/obj/machinery/computer/shuttle/pod/pod in machines)
					pod.admin_controlled = 0
			if(SEC_LEVEL_DELTA)
				minor_announce(config.alert_desc_delta, "��������! ��������� ������� ��������� ������!",1)
				security_level = SEC_LEVEL_DELTA
				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION)
						FA.update_icon()
				for(var/obj/machinery/computer/shuttle/pod/pod in machines)
					pod.admin_controlled = 0
	else
		return

/proc/get_security_level()
	switch(security_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/num2seclevel(num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/seclevel2num(seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA


/*DEBUG
/mob/verb/set_thing0()
	set_security_level(0)
/mob/verb/set_thing1()
	set_security_level(1)
/mob/verb/set_thing2()
	set_security_level(2)
/mob/verb/set_thing3()
	set_security_level(3)
*/
