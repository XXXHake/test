--[[
List = {			--table name
Hero_name = {		--hero name
animation = 99,		--animation 
range = 999,		--distance between me and target
ability = {"",""}	--ability to evade
vector = {"",""}	--mask for ability vector: "non","me", "aoe", "target" , "ONme" "specialS"
items = {"",""}		--items to evade
vectors = {"",""}	--mask for items vector
itemLat = number 	--sleep for item with latency
spellLat = 			--sleep for spell with latency
latency = "string"	--sleep with latency + distance(me,target)/900, 900 avarge project speed
toface = 1			--if enemy to face
]]

--Library

--[[
List = {			--table name
Hero_name = {		--hero name
animation = 99,		--animation 
range = 999,		--distance between me and target
ability = {"",""}	--ability to evade
vector = {"",""}	--mask for ability vector: "non","me", "aoe", "target" , "ONme" "specialS"
items = {"",""}		--items to evade
vectors = {"",""}	--mask for items vector
itemLat = number 	--sleep for item with latency
spellLat = 			--sleep for spell with latency
latency = "string"	--sleep with latency + distance(me,target)/900, 900 avarge project speed
toface = 1			--if enemy to face
]]

AnimationList = {


-- uti animation

npc_dota_hero_magnataur = {
animation = 21,
range = 400,
ability = {"ember_spirit_sleight_of_fist","slark_dark_pact","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_manta","item_cyclone","item_blink"},
vector = {"specialE","non","non","non"},
vectors = {"non","ONme","home"},
itemLat = 10},

npc_dota_hero_spirit_breaker = {
animation = 16,
range = 700,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","slark_dark_pact","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"specialE","non","non","non"},
vectors = {"ONme"},
spellLat = 900,
itemLat = 900},

npc_dota_hero_lich = {
animation = 8,
range = 750,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"specialE","non","non"},
vectors = {"ONme"},
spellLat = 300,
itemLat = 320},

npc_dota_hero_obsidian_destroyer = {
animation = 11,
range = 700,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"specialE","non","non"},
vectors = {"ONme"},
},

npc_dota_hero_tidehunter = {
animation = 16,
range = 1025,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
items = {"item_cyclone","item_black_king_bar"},
vector = {"specialE","non","non","non"},
vectors = {"ONme","non"},
spellLat = 10,
itemLat = 10},

npc_dota_hero_zuus = {
animation = 11,
range = 50000,
ability = {"nyx_assassin_spiked_carapace","puck_phase_shift"},
vector = {"non","non"},
items = {"item_cyclone"},
vectors = {"ONme"},
},

npc_dota_hero_sniper = {
animation = 10,
range = 3000,
ability = {"nyx_assassin_spiked_carapace","puck_phase_shift"},
items = {"item_cyclone"},
vector = {"non","non"},
vectors = {"ONme"},
spellLat = 1695,
itemLat = 1701},

-- spell animation

npc_dota_hero_slardar = {
animation = 6,
range = 350,
ability = {"ember_spirit_sleight_of_fist","slark_dark_pact","puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"specialE","non","non","non"},
spellLat = 1},

npc_dota_hero_broodmother = {
animation = 10,
range = 700,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vectors = {"ONme"},
vector = {"specialE","non","non"},
spellLat = 50,
itemLat = "60"},

npc_dota_hero_tinker = {
animation = 6,
range = 2500,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vectors = {"ONme"},
vector = {"specialE","non","non"},
spellLat = 50,
itemLat = "60"},

npc_dota_hero_visage = {
animation = 10,
range = 900,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"specialE","non","non"},
spellLat = 50},

npc_dota_hero_brewmaster = {
animation = 15,
range = 300,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"specialE","non","non"},
spellLat = 10},

npc_dota_hero_centaur = {
animation = 6,
range = 300,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"specialE","non","non"},
spellLat = 150},

npc_dota_hero_templar_assassin = {
animation = 11,
range = 350,
ability = {"puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"non","non"},
spellLat = 30,
itemLat = "60"},

npc_dota_hero_viper = {
animation = 4,
range = 500,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift"},
items = {"item_cyclone"},
vector = {"specialE","non"},
vectors = {"ONme"},
spellLat = 50,
itemLat = "60"},

npc_dota_hero_omniknight = {
animation = 9,
range = 225,
ability = {"puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"non","non"},
spellLat = 85},

npc_dota_hero_mirana = {
animation = 11,
range = 625,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"specialE","non","non"},
spellLat = 150},

npc_dota_hero_phantom_lancer = {
animation = 10,
range = 750,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"specialE","non","non"},
vectors = {"ONme"},
spellLat = 50,
itemLat = "60"},

npc_dota_hero_queenofpain = {
animation = 6,
range = 450,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift"},
vector = {"specialE","non"},
spellLat = 200},

npc_dota_hero_earthshaker = {
animation = 10,
range = 700,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
vector = {"specialE","non","non","non"},
spellLat = 150},


npc_dota_hero_alchemist = {
animation = 27,
range = 775,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
items = {"item_cyclone"},
vector = {"specialE","non","non","non"},
vectors = {"ONme"},
spellLat = 100,
itemLat = "60"},

npc_dota_hero_crystal_maiden = {
animation = 7,
range = 500,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
vector = {"specialE","non","non"},
spellLat = 50},

npc_dota_hero_bounty_hunter = {
animation = 4,
range = 700,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"specialE","non","non"},
vectors = {"ONme"},
spellLat = "10",
itemLat = "60"},

npc_dota_hero_vengefulspirit = {
animation = 12,
range = 600,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
items = {"item_cyclone"},
vector = {"specialE","non","non","non"},
vectors = {"ONme"},
spellLat = 100,
itemLat = "60"},

npc_dota_hero_skeleton_king = {
animation = 7,
range = 700,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
items = {"item_cyclone","item_blink"},
vector = {"specialE","non","non","non"},
vectors = {"ONme","non"},
spellLat = "70",
itemLat = "70"},

npc_dota_hero_sand_king = {
animation = 8,
range = 700,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
vector = {"specialE","non","non","non"},
spellLat = "60"},

npc_dota_hero_sven = {
animation = 15,
range = 700,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
items = {"item_cyclone"},
vector = {"specialE","non","non","non"},
vectors = {"ONme"},
spellLat = 70,
itemLat = "60"},

npc_dota_hero_lion = {
animation = 5,
range = 700,
toface = 1,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","nyx_assassin_spiked_carapace","slark_dark_pact"},
items = {"item_cyclone"},
vector = {"specialE","non","non","non"},
vectors = {"ONme"},
spellLat = 70,
itemLat = "60"},

npc_dota_hero_nyx_assassin = {
animation = 5,
range = 700,
ability = {"ember_spirit_sleight_of_fist","puck_phase_shift","slark_dark_pact","slark_dark_pact"},
items = {"item_cyclone"},
vector = {"specialE","non","non","non"},
vectors = {"ONme"},
spellLat = 100,
itemLat = "60"},

}

InitiativeList = {

npc_dota_hero_batrider = {
spells = "batrider_flaming_lasso",
ability = {"ember_spirit_activate_fire_remnant"},
vector = {"specialE"}
}
}


ModifierList = {

npc_dota_hero_lion = {
modifier = "modifier_lion_finger_of_death",
ability = {"ember_spirit_sleight_of_fist","phoenix_supernova","abaddon_borrowed_time","puck_phase_shift","nyx_assassin_spiked_carapace","storm_spirit_ball_lightning"},
vector = {"specialE","non","non","non","non","specialS"},
items = {"item_manta","item_bloodstone","item_black_king_bar","item_cyclone"},
vectors = {"non","me","non","ONme"}},

npc_dota_hero_lina = {
modifier = "modifier_lina_laguna_blade",
ability = {"ember_spirit_sleight_of_fist","phoenix_supernova","abaddon_borrowed_time","puck_phase_shift","nyx_assassin_spiked_carapace","storm_spirit_ball_lightning"},
vector = {"specialE","non","non","non","non","specialS"},
items = {"item_manta","item_bloodstone","item_black_king_bar","item_cyclone"},
vectors = {"non","me","non","ONme"}},

}

EnemyModifier = {

npc_dota_hero_huskar = {
range = 400,
modifier = "modifier_huskar_life_break_charge",
ability = {"puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"non","non"},
vectors = {"ONme"}},

npc_dota_hero_spirit_breaker = {
range = 400,
modifier = "modifier_spirit_breaker_charge_of_darkness_vision",
ability = {"puck_phase_shift","nyx_assassin_spiked_carapace"},
items = {"item_cyclone"},
vector = {"non","non"},
vectors = {"ONme"}},

}
