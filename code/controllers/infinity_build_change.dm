var/datum/server_build/nextbuild
var/datum/server_build/currentbuild

/datum/configuration
	var/list/datum/server_build/buildlist = list()

/datum/subsystem/ticker
	var/buildchangechecked = 0				//build changing?
	var/buildchanger_ckey = ""				//who changing build?

/datum/server_build
	var/name				// name of build
	var/friendlyname		// friendly name of build
	var/dmb_file			// dmb file of build
	var/folder				// folder of build
	var/update				// update folder of build

/datum/server_build/New(name)
	src.name = name

/datum/configuration/proc/loadbuildlist(filename)
	var/list/Lines = file2list(filename)

	var/datum/server_build/current_build = null
	for(var/t in Lines)
		if(!t)
			continue

		t = trim(t)
		if(length(t) == 0)
			continue
		else if(copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/command = null
		var/data = null

		if(pos)
			command = lowertext(copytext(t, 1, pos))
			data = copytext(t, pos + 1)
		else
			command = lowertext(t)

		if(!command)
			continue

		if(!current_build && command != "build")
			continue

		switch(command)
			if("build")
				current_build = new (data)
			if("dmbfile")
				current_build.dmb_file = data
			if("friendlyname")
				current_build.friendlyname = data
			if("folder")
				current_build.folder = data
			if("update")
				current_build.update = data
			if("endbuild")
				config.buildlist[current_build.name] = current_build
				currentbuild = null
			else
				diary << "Unknown command in builds config: '[command]'"

/proc/loadbuildname()
	shell("sh ../dir.sh > ext.txt")
	var/ext
	var/list/Lines = file2list("ext.txt")
	if(Lines.len)
		if(Lines[1])
			ext = Lines[1]
	for(var/build in config.buildlist)
		var/datum/server_build/B = config.buildlist[build]

		if(ext == B.folder)
			currentbuild = B
			break

/client/proc/adminchangebuild()
	set category = "Server"
	set name = "Change Build"

	if(!holder)
		return

	var/list/buildchoices = list()
	for(var/build in config.buildlist)
		var/datum/server_build/B = config.buildlist[build]
		var/buildname = B.friendlyname

		if(B == currentbuild)
			continue

		buildchoices[buildname] = B

	var/chosenbuild = input("Choose a build to change to", "Change Build")  as null|anything in buildchoices

	if (!chosenbuild)
		return

	ticker.buildchangechecked = 1
	ticker.buildchanger_ckey = ckey
	var/datum/server_build/B = buildchoices[chosenbuild]
	nextbuild = B

	message_admins("[key_name_admin(usr)] �����&#255;� ���� �� [nextbuild.name]([nextbuild.friendlyname])")
	log_admin("[key_name(usr)] �����&#255;� ���� �� [nextbuild.name]([nextbuild.friendlyname])")
	world << "<span class='boldannounce'>���� ������� �� [nextbuild.friendlyname] ��&#255; ���������� ������!</span>"

/proc/forcechangebuild(datum/server_build/B)
	if(!istype(B))
		return
	if(!B)
		return
	if(ticker.update_waiting)
		return

	world << "<span class='adminooc'><FONT size=5>��������! ���� �������� �� [B.friendlyname]! ������ �� ����� �������� ��������� �����!</FONT><br>����� ����� � ����� ������ ������������ ��������������� [ticker.buildchanger_ckey]</span>."
	playsound_global('sound/effects/alarm.ogg', repeat=0, channel=1, volume=100)
	sleep(100)

	log_game("Changing build to [B.name]([B.friendlyname])")
	. = shell("infinityctl changebuild -b [B.name]")

/* mob/Stat appendix
		stat(null, "Map: [MAP_NAME]")
		if(nextmap && istype(nextmap))
			stat(null, "Next Map: [nextmap.friendlyname]")
		if(currentbuild)
			stat(null, "Build: [currentbuild.friendlyname]")
		if (nextbuild && istype(nextbuild))
			stat(null, "Next Build: [nextbuild.friendlyname]")
		stat(null, "Server Time: [time2text(world.realtime, "YYYY-MM-DD hh:mm")]")
*/