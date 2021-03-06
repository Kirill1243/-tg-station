//Objects that spawn ghosts in as a certain role when they click on it, i.e. away mission bartenders.

//Preserved terrarium/seed vault: Spawns in seed vault structures in lavaland. Ghosts become plantpeople and are advised to begin growing plants in the room near them.
/obj/effect/mob_spawn/human/seed_vault
	name = "preserved terrarium"
	desc = "An ancient machine that seems to be used for storing plant matter. The glass is obstructed by a mat of vines."
	mob_name = "a lifebringer"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "terrarium"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	mob_species = /datum/species/pod
	flavour_text = "<font size=3><b>Y</b></font><b>ou are a sentient ecosystem - an example of the mastery over life that your creators possessed. Your masters, benevolent as they were, created uncounted \
	seed vaults and spread them across the universe to every planet they could chart. You are in one such seed vault. Your goal is to cultivate and spread life wherever it will go while waiting \
	for contact from your creators. Estimated time of last contact: Deployment, 5x10^3 millennia ago.</b>"

/obj/effect/mob_spawn/human/seed_vault/special(mob/living/new_spawn)
	var/plant_name = pick("Tomato", "Potato", "Brocolli", "Carrot", "Ambrosia", "Pumpkin", "Ivy", "Kudzu", "Bannana", "Moss", "Flower", "Bloom", "Root", "Bark", "Glowshroom", "Petal", "Leaf", \
	"Venus", "Sprout","Cocao", "Strawberry", "Citrus", "Oak", "Cactus", "Pepper", "Juniper")
	new_spawn.real_name = plant_name
	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.underwear = "Nude" //You're a plant, partner
		H.update_body()

/obj/effect/mob_spawn/human/seed_vault/Destroy()
	new/obj/structure/fluff/empty_terrarium(get_turf(src))
	..()

//Ash walker eggs: Spawns in ash walker dens in lavaland. Ghosts become unbreathing lizards that worship the Necropolis and are advised to retrieve corpses to create more ash walkers.
/obj/effect/mob_spawn/human/ash_walker
	name = "ash walker egg"
	desc = "A man-sized yellow egg, spawned from some unfathomable creature. A humanoid silhouette lurks within."
	mob_name = "an ash walker"
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	mob_species = /datum/species/lizard/ashwalker
	helmet = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/gladiator
	roundstart = FALSE
	faction = "ash"
	death = FALSE
	anchored = 0
	density = 0
	flavour_text = "<font size=3><b>��</b></font><b> � ��������� �����. ���� ����� ������ �����, �� ������ ����� ��������� �. �� ������ ������� ��� ����� � ������� ���������� �� ������ ����. ���� ����� ����������� <span class='danger'>�����������</span>. ��� ������� - ���� �������, ���� ����� � ���������� ������, �� ������� ����� ���������. \
	�� ������ ���� � ����, �� ���-������... ��������� ������� �� ����� �������� ������, ����� ����� � ���������� ���� ������� - ���� �����������. ����� �������� �� � ������ ������ ������� ����������...</b>"

/obj/effect/mob_spawn/human/ash_walker/special(mob/living/new_spawn)
	new_spawn.real_name = random_unique_lizard_name(gender)
	new_spawn << "<b>������ ���� ������� ������� � ������� � ������ ������. ��� ����� ��������� � ����� ���������� ���, �� �������� ���� ��������� �������. ����� �����������!</b>"
	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/REAL_NIGHT_VISION(null))
		H.underwear = "Nude"
		H.update_body()

/obj/effect/mob_spawn/human/ash_walker/New()
	..()
	var/area/A = get_area(src)
	if(A)
		notify_ghosts("���� ���������� ������ ������ ���������&#255; � [A.name].", source = src, action=NOTIFY_ATTACK)
//Timeless prisons: Spawns in Wish Granter prisons in lavaland. Ghosts become age-old users of the Wish Granter and are advised to seek repentance for their past.
/obj/effect/mob_spawn/human/exile
	name = "timeless prison"
	desc = "Although this stasis pod looks medicinal, it seems as though it's meant to preserve something for a very long time."
	mob_name = "a penitent exile"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	mob_species = /datum/species/shadow
	flavour_text = "<font size=3><b>Y</b></font><b>ou are cursed. Years ago, you sacrificed the lives of your trusted friends and the humanity of yourself to reach the Wish Granter. Though you \
	did so, it has come at a cost: your very body rejects the light, dooming you to wander endlessly in this horrible wasteland.</b>"

/obj/effect/mob_spawn/human/exile/Destroy()
	new/obj/structure/fluff/empty_sleeper(get_turf(src))
	..()

/obj/effect/mob_spawn/human/exile/special(mob/living/new_spawn)
	new_spawn.real_name = "Wish Granter's Victim ([rand(0,999)])"
	var/wish = rand(1,4)
	switch(wish)
		if(1)
			new_spawn << "<b>You wished to kill, and kill you did. You've lost track of how many, but the spark of excitement that murder once held has winked out. You feel only regret.</b>"
		if(2)
			new_spawn << "<b>You wished for unending wealth, but no amount of money was worth this existence. Maybe charity might redeem your soul?</b>"
		if(3)
			new_spawn << "<b>You wished for power. Little good it did you, cast out of the light. You are the [gender == MALE ? "king" : "queen"] of a hell that holds no subjects. You feel only remorse.</b>"
		if(4)
			new_spawn << "<b>You wished for immortality, even as your friends lay dying behind you. No matter how many times you cast yourself into the lava, you awaken in this room again within a few days. There is no escape.</b>"

//Golem shells: Spawns in Free Golem ships in lavaland. Ghosts become mineral golems and are advised to spread personal freedom.
/obj/effect/mob_spawn/human/golem
	name = "inert golem shell"
	desc = "A humanoid shape, empty, lifeless, and full of potential."
	mob_name = "a free golem"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "construct"
	mob_species = /datum/species/golem
	roundstart = FALSE
	death = FALSE
	anchored = 0
	density = 0
	flavour_text = "<font size=3><b>Y</b></font><b>ou are a Free Golem. Your family worships <span class='danger'>The Liberator</span>. In his infinite and divine wisdom, he set your clan free to \
	travel the stars with a single declaration: \"Yeah go do whatever.\" Though you are bound to the one who created you, it is customary in your society to repeat those same words to newborn \
	golems, so that no golem may ever be forced to serve again.</b>"

/obj/effect/mob_spawn/human/golem/New()
	..()
	var/area/A = get_area(src)
	if(A)
		notify_ghosts("A golem shell has been completed in \the [A.name].", source = src, action=NOTIFY_ATTACK)

/obj/effect/mob_spawn/human/golem/special(mob/living/new_spawn)
	var/golem_surname = pick(golem_names)
	// 3% chance that our golem has a human surname, because
	// cultural contamination
	if(prob(3))
		golem_surname = pick(last_names)

	var/datum/species/X = mob_species
	var/golem_forename = initial(X.id)

	// The id of golem species is either their material "diamond","gold",
	// or just "golem" for the plain ones. So we're using it for naming.

	if(golem_forename == "golem")
		golem_forename = "iron"

	new_spawn.real_name = "[capitalize(golem_forename)] [golem_surname]"
	// This means golems have names like Iron Forge, or Diamond Quarry
	// also a tiny chance of being called "Plasma Meme"
	// which is clearly a feature

	new_spawn << "Build golem shells in the autolathe, and feed refined mineral sheets to the shells to bring them to life! You are generally a peaceful group unless provoked."
	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.set_cloned_appearance()


/obj/effect/mob_spawn/human/golem/adamantine
	name = "dust-caked golem shell"
	desc = "A humanoid shape, empty, lifeless, and full of potential."
	mob_name = "a free golem"
	anchored = 1
	density = 1
	mob_species = /datum/species/golem/adamantine

//Malfunctioning cryostasis sleepers: Spawns in makeshift shelters in lavaland. Ghosts become hermits with knowledge of how they got to where they are now.
/obj/effect/mob_spawn/human/hermit
	name = "malfunctiong cryostasis sleeper"
	desc = "A humming sleeper with a silhoutted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a stranded hermit"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<font size=3><b>Y</b></font><b>ou've been stranded in this godless prison of a planet for longer than you can remember. Each day you barely scrape by, and between the terrible \
	conditions of your makeshift shelter, the hostile creatures, and the ash drakes swooping down from the cloudless skies, all you can wish for is the feel of soft grass between your toes and \
	the fresh air of Earth. These thoughts are dispelled by yet another recollection of how you got here... "

/obj/effect/mob_spawn/human/hermit/New()
	var/arrpee = rand(1,4)
	switch(arrpee)
		if(1)
			flavour_text += "you were a [pick("arms dealer", "shipwright", "docking manager")]'s assistant on a small trading station several sectors from here. Raiders attacked, and there was \
			only one pod left when you got to the escape bay. You took it and launched it alone, and the crowd of terrified faces crowding at the airlock door as your pod's engines burst to \
			life and sent you to this hell are forever branded into your memory.</b>"
			uniform = /obj/item/clothing/under/assistantformal
			shoes = /obj/item/clothing/shoes/sneakers/black
			back = /obj/item/weapon/storage/backpack
		if(2)
			flavour_text += "you're an exile from the Tiger Cooperative. Their technological fanaticism drove you to question the power and beliefs of the Exolitics, and they saw you as a \
			heretic and subjected you to hours of horrible torture. You were hours away from execution when a high-ranking friend of yours in the Cooperative managed to secure you a pod, \
			scrambled its destination's coordinates, and launched it. You awoke from stasis when you landed and have been surviving - barely - ever since.</b>"
			uniform = /obj/item/clothing/under/rank/prisoner
			shoes = /obj/item/clothing/shoes/sneakers/orange
			back = /obj/item/weapon/storage/backpack
		if(3)
			flavour_text += "you were a doctor on one of Nanotrasen's space stations, but you left behind that damn corporation's tyranny and everything it stood for. From a metaphorical hell \
			to a literal one, you find yourself nonetheless missing the recycled air and warm floors of what you left behind... but you'd still rather be here than there.</b>"
			uniform = /obj/item/clothing/under/rank/medical
			suit = /obj/item/clothing/suit/toggle/labcoat
			back = /obj/item/weapon/storage/backpack/medic
			shoes = /obj/item/clothing/shoes/sneakers/black
		if(4)
			flavour_text += "you were always joked about by your friends for \"not playing with a full deck\", as they so <i>kindly</i> put it. It seems that they were right when you, on a tour \
			at one of Nanotrasen's state-of-the-art research facilities, were in one of the escape pods alone and saw the red button. It was big and shiny, and it caught your eye. You pressed \
			it, and after a terrifying and fast ride for days, you landed here. You've had time to wisen up since then, and you think that your old friends wouldn't be laughing now.</b>"
			uniform = /obj/item/clothing/under/color/grey/glorf
			shoes = /obj/item/clothing/shoes/sneakers/black
			back = /obj/item/weapon/storage/backpack
	..()

/obj/effect/mob_spawn/human/hermit/Destroy()
	new/obj/structure/fluff/empty_cryostasis_sleeper(get_turf(src))
	..()

//Broken rejuvenation pod: Spawns in animal hospitals in lavaland. Ghosts become disoriented interns and are advised to search for help.
/obj/effect/mob_spawn/human/doctor/alive/lavaland
	name = "broken rejuvenation pod"
	desc = "A small sleeper typically used to instantly restore minor wounds. This one seems broken, and its occupant is comatose."
	mob_name = "a translocated vet"
	flavour_text = "<font size=3><b>W</b></font><b>hat...? Where are you? Where are the others? This is still the animal hospital - you should know, you've been an intern here for weeks - but \
	everyone's gone. One of the cats scratched you just a few minutes ago. That's why you were in the pod - to heal the scratch. The scabs are still fresh; you see them right now. So where is \
	everyone? Where did they go? What happened to the hospital? And is that <i>smoke</i> you smell? You need to find someone else. Maybe they can tell you what happened.</b>"

//Prisoner containment sleeper: Spawns in crashed prison ships in lavaland. Ghosts become escaped prisoners and are advised to find a way out of the mess they've gotten themselves into.
/obj/effect/mob_spawn/human/prisoner_transport
	name = "prisoner containment sleeper"
	desc = "A sleeper designed to put its occupant into a deep coma, unbreakable until the sleeper turns off. This one's glass is cracked and you can see a pale, sleeping face staring out."
	mob_name = "an escaped prisoner"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "sleeper_s"
	uniform = /obj/item/clothing/under/rank/prisoner
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/sneakers/orange
	pocket1 = /obj/item/weapon/tank/internals/emergency_oxygen
	roundstart = FALSE
	death = FALSE
	flavour_text = "<font size=3><b>G</b></font><b>ood. It seems as though your ship crashed. You're a prisoner, sentenced to hard work in one of Nanotrasen's labor camps, but it seems as \
	though fate has other plans for you. You remember that you were convicted of "

/obj/effect/mob_spawn/human/prisoner_transport/special(mob/living/L)
	L.real_name = "NTP #LL-0[rand(111,999)]" //Nanotrasen Prisoner #Lavaland-(numbers)
	L.name = L.real_name

/obj/effect/mob_spawn/human/prisoner_transport/New()
	var/list/crimes = list("murder", "larceny", "embezzlement", "unionization", "dereliction of duty", "kidnapping", "gross incompetence", "grand theft", "collaboration with the Syndicate", \
	"worship of a forbidden deity", "interspecies relations", "mutiny")
	flavour_text += "[pick(crimes)]. but regardless of that, it seems like your crime doesn't matter now. You don't know where you are, but you know that it's out to kill you, and you're not going \
	to lose this opportunity. Find a way to get out of this mess and back to where you rightfully belong - your [pick("house", "apartment", "spaceship", "station")]</b>."
	..()

/obj/effect/mob_spawn/human/prisoner_transport/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

//Space Hotel Staff
/obj/effect/mob_spawn/human/hotel_staff //not free antag u little shits
	name = "staff sleeper"
	desc = "A sleeper designed for long-term statis between guest vists."
	mob_name = "hotel staff member"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "sleeper_s"
	uniform = /obj/item/clothing/under/assistantformal
	shoes = /obj/item/clothing/shoes/laceup
	pocket1 = /obj/item/device/radio/off
	back = /obj/item/weapon/storage/backpack
	objectives = "Cater to visting guests with your fellow staff. Do not leave your assigned hotel and always remember: The customer is always right!"
	implants = list(/obj/item/weapon/implant/mindshield)
	death = FALSE
	roundstart = FALSE
	random = TRUE
	flavour_text = "You are a staff member of a top-of-the-line space hotel! Cater to guests and <font size=6><b>DON'T</b></font> leave the hotel, lest the manager fire you for\
		dereliction of duty!"

/obj/effect/mob_spawn/human/hotel_staff/security
	name = "hotel security sleeper"
	mob_name = "hotel security memeber"
	uniform = /obj/item/clothing/under/rank/security/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	helmet = /obj/item/clothing/head/helmet/blueshirt
	back = /obj/item/weapon/storage/backpack/security
	belt = /obj/item/weapon/storage/belt/security/full
	flavour_text = "You are a peacekeeper assigned to this hotel to protect the intrests of the company while keeping the peace between \
		guests and the staff.Do <font size=6><b>NOT</b></font> leave the hotel, as that is grounds for contract termination."
	objectives = "Do not leave your assigned hotel. Try and keep the peace between staff and guests, non-lethal force heavily advised if possible."

/obj/effect/mob_spawn/human/hotel_staff/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

