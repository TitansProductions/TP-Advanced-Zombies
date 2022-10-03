Config = {}
Config.Debug              = false

-- [FRAMEWORKS SUPPORTED]: ESX, QBCore, Standalone
Config.Framework          = "ESX"

-- When set to true, all the default fivem vehicles and peds (npcs) will not be spawned.
Config.DisableTrafficAdjuster    = true

-- If you set it to true, make sure tp_user_statistics sql file exists in your database.
Config.UserStatisticsRanking = true

Config.UserStatistics = {
    OpenCommand = "ranking",
    OpenKey = "F7",
}

------------------------------------------------------------------------------------------------------------------
-- Developers Mode.
------------------------------------------------------------------------------------------------------------------

-- This is for developers, do not enable it if you are not going to use it.
-- "tp-advancedzombies:onPlayerZombieKill" (Client Event)
-- This event will trigger when a player kills a zombie in order to send any kind of rewards you want (manually).

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
-- Zombie Peds System Configuration.
------------------------------------------------------------------------------------------------------------------

-- Default whitelisted zombie peds to be spawned in the game.
Config.ZombiePedModels    = {
	"u_m_m_prolsec_01",
    "a_m_m_hillbilly_01",
    "a_m_m_polynesian_01",
    "a_m_m_skidrow_01",
    "a_m_m_salton_02",
    "a_m_m_fatlatin_01",
	"a_m_m_beach_01",
    "a_m_m_farmer_01",
    "a_m_m_malibu_01",
    "a_m_m_rurmeth_01",
    "a_m_y_salton_01",
    "a_m_m_skater_01",
    "a_m_m_tennis_01",
	"a_m_o_acult_02",
    "a_m_y_genstreet_01",
    "a_m_y_genstreet_02",
    "a_m_y_methhead_01",
    "a_m_y_stlat_01",
    "s_m_m_paramedic_01",
	"s_m_y_cop_01",
    "s_m_y_prismuscl_01",
    "s_m_y_prisoner_01",
    "a_m_m_og_boss_01",
    "a_m_m_eastsa_02",
    "a_f_y_juggalo_01",
}

Config.ZombiePedModelsData = {
    ["u_m_m_prolsec_01"]    = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_hillbilly_01"]  = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_polynesian_01"] = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_skidrow_01"]    = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_salton_02"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_fatlatin_01"]   = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_beach_01"]      = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_farmer_01"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_malibu_01"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_rurmeth_01"]    = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_y_salton_01"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_skater_01"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_tennis_01"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_o_acult_02"]      = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_y_genstreet_01"]  = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_y_genstreet_02"]  = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_y_methhead_01"]   = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_y_stlat_01"]      = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["s_m_m_paramedic_01"]  = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["s_m_y_cop_01"]        = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["s_m_y_prismuscl_01"]  = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["s_m_y_prisoner_01"]   = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_og_boss_01"]    = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_m_m_eastsa_02"]     = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
    ["a_f_y_juggalo_01"]    = { data = { health = 200, damage_without_armor = 15, damage_with_armor = 10, headshot_instakill = true }, loot = "level_1" },
}

Config.ZombiePedModelWalks = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

Config.High3DSounds      = false     -- Enables intergration with High3DSounds and disables NUI Player
                                    -- https://www.high-scripts.com/package/5035810
Config.MuteAmbience      = true
Config.NotHealthRecharge = true


Config.Zombies = {
    SpawnDelay        = 1000,     -- The time is in milliseconds, 1000 = 1 second.

    -- If you set this to true, zombies will only spawn in zones where you allow.
    SpawnZombiesOnlyInZones = false,

    SpawnZombieAtDaylight = 5,
    SpawnZombieAtNight    = 10,
	
    MinSpawnDistance      = 30,
    MaxSpawnDistance      = 45,
    DespawnDistance       = 50,

    AttackPlayersOnShooting = true,
    AttackPlayersBasedInDistance = true,

    DistanceAttackData = {
        SleepTime = 1000,

        Crouching = 10,
        Walking = 35,
        Sprinting = 45,
    },
	
    PlayCustomSpeakingSounds = true,

    SpeakingSounds = {

        DistanceSounds = {

            far = { 
                'zombie_growl_1.mp3', 
                'zombie_growl_2.mp3', 
            },

            close  = { 
                'zombie_aggressive_1.mp3', 
                'zombie_aggressive_2.mp3', 
                'zombie_aggressive_3.mp3', 
                'zombie_aggressive_4.mp3', 
                'zombie_aggressive_5.mp3',
            },
        },
    },
	
    HumanEatingAndAttackingAnimation = true,

    DropLoot = true,

    Loot = {

        PickupKey = 51,
        
        DropLootChance = 70,
		
	-- RemoveLootSleepTime is in minutes to remove the loot after an amount of time if the player is not picking it up.
        RemoveLootSleepTime = 2,

        LootMarker = {
    
            MarkerDistance = 50, 
            SleepTime = 1000,
    
            Type = 0, 
    
            ScaleX = 0.2, 
            ScaleY = 0.5, 
            ScaleZ = 0.2, 
    
            R = 255,
            G = 0,
            B = 0,
            A = 100,

            DrawText3Ds = true,
        },
    
        DropData = {
            SleepTime = 1000,
            DistanceToPickup = 1.5,
        },
    
        -- If you dont want to add any items or any weapons, just set it to nil, for example, it should be `items = nil`, same for weapons(`weapons = nil`).
        -- If you want to give a random amount, set the random to true, and set the min, max. 
        -- If you dont want to give a random amount, set the random to false and set the max to any amount you want.
        -- The Loot Reward Packages are for Config.ZombiePedModelsData, in order to use a specific loot package dropping for every custom zombie ped.
        LootRewardPackages = {
            ['level_1'] = { 

                account = { cash = 0, black_money = 0 },

                items = { -- start of items

                    water = {
                        randomAmount = true,
                        min    = 0,
                        max    = 1,

                        chance = 70,
                    },

                    disc_ammo_rifle = {
                        randomAmount = true,
                        min    = 0,
                        max    = 2,

                        chance = 30,
                    },

                }, -- end of items

                weapons = nil, 


            },

            ['level_2'] = { 

                account = { cash = 0, black_money = 0 },

                items = nil,

                weapons = { -- start of weapons
                    
                    WEAPON_PISTOL = {
                        randomAmount = true, -- randomAmount is the ammunition for weapons.
                        min    = 1,
                        max    = 7,

                        chance = 5,
                    },
                }, -- end of weapons

            },

        
        },
    },

}


-- The time is in milliseconds, 1250 as default, equals to 1,25 seconds. 
-- Default is preffered in order to have the lowest ms usage.
Config.EnteringZoneDelay = 1250

Config.Zones = {

	VineWoodHills = { 
		ZoneType = "SAFEZONE",
		Pos   = {x = -418.36, y = 1151.68, z = 326.0},
		ZoneDistance  = 300.0,
        BlockPlayerAggressiveActions = true,
        BlockZombiePedSpawning = true,

        EnableZoneBlipData = true,

        BlipData = {

            Title = "Vinewood Hills", 
            CircleColor = 2, 
            IdColour = 2, 
            Scale = 1.0, 
            Display = 4, 
            Id = 557, 
        },
	},

	Palmer = {
		ZoneType = "DARKZONE",
		Pos   = {x = 2744.16, y = 1553.64, z = 35.12},
        ZoneDistance  = 400.0,
        BlockPlayerAggressiveActions = false,
        BlockZombiePedSpawning = false,

        EnableZoneBlipData = true,

        BlipData = {
            
            Title = "Palmer T. Power Station", 
            CircleColor = 40, 
            IdColour = 40, 
            Scale = 1.0, 
            Display = 4, 
            Id = 310, 
        },

        -- if you add external zombie ped models, make sure to add them in the Config.ZombiePedModelsData.
        ExtendedSpawnedZombies  = 5,
        ExtendedZombiePedModels = {"zombie_ped_example1", "zombie_ped_example2"},
	},

	HumaneLabs = { 
		ZoneType = "DARKZONE",
		Pos   = {x = 3527.24, y = 3712.64, z = 36.64},
        ZoneDistance  = 400.0,
        BlockPlayerAggressiveActions = false,
        BlockZombiePedSpawning = false,

        EnableZoneBlipData = true,

        BlipData = {
            
            Title = "Humane Labs & Research", 
            CircleColor = 40, 
            IdColour = 40, 
            Scale = 1.0, 
            Display = 4, 
            Id = 310, 
        },

        ExtendedSpawnedZombies  = 0,
        ExtendedZombiePedModels = nil,
	},

    Cayo = {
		ZoneType = "DARKZONE",
		Pos   = {x = 4995.08, y = -5094.12, z = 4.96},
        ZoneDistance  = 1300.0,
        BlockPlayerAggressiveActions = false,
        BlockZombiePedSpawning = false,
        
        EnableZoneBlipData = true,

        BlipData = {
            
            Title = "Cayo", 
            CircleColor = 40, 
            IdColour = 40, 
            Scale = 1.0, 
            Display = 4, 
            Id = 310, 
        },

        ExtendedSpawnedZombies  = 0,
        ExtendedZombiePedModels = nil,
	},

	MountChiliad = { 
		ZoneType = "REDZONE",
		Pos   = {x = -526.4, y = 5313.24, z = 94.0},
        ZoneDistance  = 400.0,
        BlockPlayerAggressiveActions = false,
        BlockZombiePedSpawning = false,

        EnableZoneBlipData = true,

        BlipData = {
            
            Title = "Mount Chiliad Lumber Mill", 
            CircleColor = 6, 
            IdColour = 6, 
            Scale = 1.0, 
            Display = 4, 
            Id = 429, 
        },

        ExtendedSpawnedZombies  = 0,
        ExtendedZombiePedModels = nil,
	},

    StabCity = {
	    ZoneType = "REDZONE",
    	Pos   = {x = 57.2, y = 3703.28, z = 39.76},
        ZoneDistance  = 400.0,
        BlockPlayerAggressiveActions = false,
        BlockZombiePedSpawning = false,
        
        EnableZoneBlipData = true,

        BlipData = {
            
            Title = "Stab City", 
            CircleColor = 6, 
            IdColour = 6, 
            Scale = 1.0, 
            Display = 4, 
            Id = 429, 
        },

        ExtendedSpawnedZombies  = 0,
        ExtendedZombiePedModels = nil,
    },

}
