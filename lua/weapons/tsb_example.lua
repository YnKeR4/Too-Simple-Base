AddCSLuaFile()

DEFINE_BASECLASS("too_simple_base")

SWEP.Base 						= "too_simple_base"	-- not really xd

---------------------
-->> SCK SUPPORT <<--
---------------------

SWEP.VElements 					= {
	["1"] = { type = "Model", model = "models/props/cs_office/trash_can_p5.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(-1.558, 0.518, -9.87), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(150, 150, 150, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = "Model", model = "models/weapons/shell.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(0, -0.519, 0), angle = Angle(31.558, -64.287, 19.87), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["scope"] = { type = "Model", model = "models/props_c17/metalPot001a.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(0, -2.151, 2.596), angle = Angle(0, 0, 180), size = Vector(0.2, 0.2, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["scope++"] = { type = "Model", model = "models/hunter/blocks/cube025x05x025.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(1.1, -1.558, 3.635), angle = Angle(0, 0, 180), size = Vector(0.2, 0.107, 0.237), color = Color(81, 78, 0, 255), surpresslightning = false, material = "phoenix_storms/construct/concrete_barrier2_00", skin = 0, bodygroup = {} },
	["scope+"] = { type = "Model", model = "models/hunter/misc/sphere025x025.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(0, -2.151, -0.519), angle = Angle(0, 0, 180), size = Vector(0.25, 0.25, 0.25), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}

SWEP.WElements 					= {
	["1"] = { type = "Model", model = "models/weapons/shell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.5, 1.899, -4.676), angle = Angle(22.208, -38.571, 3.506), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = "Model", model = "models/props/cs_office/trash_can_p5.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2.596, -11.948), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(150, 150, 150, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods 			= {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, -2.037, 1.667), angle = Angle(-14.445, -1, 0) },
	["ValveBiped.clip"] = { scale = Vector(1, 1.25, 1), pos = Vector(0, 0, 0.75), angle = Angle(0, 0, 0) }
}

-------------------
-->> MAIN SH!T <<--
-------------------

SWEP.PrintName 					= "Heckler & Koch USP bro what the..."
SWEP.Category 					= "TSB Example"
SWEP.Slot 						= 1
SWEP.Spawnable 					= true	-- can spawn by normal people (by default, it is false)
SWEP.AdminSpawnable 			= true	-- can spawn by admin people (by default, it is false)

SWEP.AutoSwitchTo 				= true	-- you can delete this (by default, it is true)
SWEP.AutoSwitchFrom 			= true	-- you can delete this (by default, it is true)

SWEP.HoldType 					= "pistol"	-- pistol, revolver, smg, ar2, shotgun, rpg
-- https://wiki.facepunch.com/gmod/Hold_Types

SWEP.DrawCrosshair 				= false	-- false to use the dynamic crosshair, true to use the def crosshair, you can delete this
SWEP.DrawAmmo 					= true	-- you can delete this (by default, it is true)

SWEP.ShotgunReload 				= false	-- requires anims (ACT_SHOTGUN_RELOAD_START, ACT_SHOTGUN_RELOAD_FINISH)
-- you can delete this (by default, it is false)

------------------------------------
-->> VIEW MODEL AND WORLD MODEL <<--
------------------------------------

SWEP.ViewModel 					= "models/weapons/c_pistol.mdl"	-- model path in 1st person
SWEP.ShowViewModel 				= true	-- render the ViewModel? you can delete this (by default, it is true)
SWEP.ViewModelFlip 				= false	-- mirror your gun? you can delete this (by default, it is false)
SWEP.ViewModelFOV 				= 54	-- default value is 54, you can delete this
SWEP.UseHands 					= true	-- use c_arms (by default, it is false)
SWEP.WorldModel 				= "models/weapons/w_pistol.mdl"	-- model path in 3rd person
SWEP.ShowWorldModel 			= true	--- render the WorldModel? you can delete this (by default, it is true)

----------------
-->> SOUNDS <<--
----------------

SWEP.Primary.Sound 				= Sound( "Weapon_Pistol.Single" )	-- firing sound, you can delete this
SWEP.DrawSound 					= nil	-- deploy sound, you can delete this
SWEP.ReloadSound 				= Sound( "Weapon_Pistol.Reload" )	-- reloading sound, you can delete this

------------------------
-->> PRIMARY ATTACK <<--
------------------------

SWEP.Primary.ClipSize 			= 22	-- clip size
SWEP.Primary.DefaultClip 		= SWEP.Primary.ClipSize * 3	-- added ammo when you spawn your gun
SWEP.Primary.FireMode 			= 0	-- 0 is semi, 1 is burst and 2 is auto mode
SWEP.Primary.Ammo 				= "pistol"	-- pistol, 357, smg1, ar2, buckshot
-- https://wiki.facepunch.com/gmod/Default_Ammo_Types
SWEP.Primary.Damage 			= 10	-- NPCs deal /2 Damage
SWEP.Primary.TakeAmmo 			= 2	-- lost bullets after shot, you can delete this (by default, it is 1)
SWEP.Primary.StrenghtRecoil 	= 2.1214	-- recoil up, you can delete this
SWEP.Primary.Spread 			= 2.857	-- spread / 100 = real spread
SWEP.Primary.SpreadTimerNumber 	= 0.6324	-- timer to set spread to def value
SWEP.Primary.NumberofShots 		= 2	-- bullets per shot, you can delete this (by default, it is 1)
SWEP.Primary.RPM 				= 525	-- 60 / RPM = Delay between shots

SWEP.RecoilType 				= 0	-- you can delete this, by def it is 0
-- 0 - default simple recoil, 1 - S.T.A.L.K.E.R. recoil
-- 2 - dynamic recoil (and ViewPunch), 3 - smooth recoil
-- 5 - the recoil returns to its original position

--------------------
-->> VIEW PUNCH <<--
--------------------

SWEP.Primary.ViewPunchUp 		= 1.031	-- up/down, you can delete this
SWEP.Primary.ViewPunchRight 	= 0.6535	-- right/left, you can delete this
SWEP.ResetViewPunch 			= true	-- reset view punch after shot, true/false, you can delete this

--------------------------------
-->> MUZZLE ATT AND EFFECTS <<--
--------------------------------

SWEP.MuzzleAtt 					= "muzzle"	-- "1" for css guns, "muzzle" for hl2 guns, you can delete this (by default, it is nil)
SWEP.MuzzleEffect 				= "tsb_universal_muzzle_flash"	-- you can delete this (by default, it is nil)
-- "tsb_shotgun_muzzle", "tsb_muzzle_flash_X", "tsb_muzzle_flash_X_bright", "tsb_silenced_muzzle", "tsb_universal_muzzle_flash", "tsb_hl2style_muzzle_flash", "tsb_m9k_style_muzzle_flash"

SWEP.ShowTracerInXChance 		= 1	-- you can delete this
SWEP.TracerName 				= "Tracer"	-- def name is Tracer, you can delete this
SWEP.BulletImpactName 			= "RagdollImpact"	-- def name is Impact, you can delete this
-- https://wiki.facepunch.com/gmod/Effects

----------------------
-->> IRONS SIGHTS <<--
----------------------

-- SWEP Construction Kit is needed
SWEP.IronSightsPos 				= Vector(-0.201, -5.026, -1.601)	-- delete it or write: nil, if you don't want to use the iron sights
SWEP.IronSightsAng 				= Vector(0, 0, 0)	-- delete it or write: nil, if you don't want to use the iron sights
SWEP.ScopeTexture 				= 1	-- you can delete this
-- 0 - no scope texture, 1 - normal Scope, 2 - PSO scope, 3 - ACOG, 4 - Eotech, 5 - green aimpoint

SWEP.IronTime 					= 0.3	-- time before aiming, you can delete this
SWEP.IronFOVMult 				= 5	-- default value is 1.35, you can delete this

---------------
-->> OTHER <<--
---------------

SWEP.RunPos 					= Vector(-0.801, -18.894, -11.056)	-- delete it or write: nil, if you don't want to use the sprint function
SWEP.RunAng 					= Vector(70, -0.704, -0.704)	-- delete it or write: nil, if you don't want to use the sprint function
SWEP.ReloadingTime 				= 1	-- reloading timer only for non-shotgun reloads, you can delete this (it will use the sequence duration)
SWEP.m_WeaponDeploySpeed 		= 2	-- deploy speed (0.5 is long, 2 is pretty fast), you can delete this
SWEP.SwitchTo 					= "Auto"	-- switch fire mode to: "Semi-Auto", "Auto", "Burst" (by default, it is nil)
SWEP.CustomPos 					= Vector( 0, 0, 0 )	-- you can remove this

--[[ if you using 1 RecoilType

SWEP.CamdDispersion 			= 0	-- strenght recoil
SWEP.CamdDispersionInc 			= nil	-- added recoil to CamdDispersion after shot, you can delete this
SWEP.CamMaxAngle 				= 0	-- max recoil
SWEP.CamStepAngleHorz 			= nil	-- strenght recoil (right or left), you can delete this
SWEP.CamdDispersionFrac 		= nil	-- the weapon will be raised to CamdDispersion * CamdDispersionFrac - CamdDispersion * ( 1 - CamdDispersionFrac ), you can delete this

]]

---------------------------------------------
-->> SEC. ATTACK AND BURST FIRE MODE FIX <<--
---------------------------------------------

--[[

function SWEP:SecondaryAttack()	-- custom sec. attack
	if !self:CanSecondary() then return end
end

function SWEP:CanSecondary()
	return true
end

SWEP.Burst 						= 0	-- fix burst fire mode
SWEP.BurstTimer 				= CurTime()	-- fix burst fire mode
-- i do not know how it fixes this...

]]

---------------------
-->> NPC SUPPORT <<--
---------------------

SWEP.NPCFires 					= 4	-- how much they need to shoot
list.Add( "NPCUsableWeapons", { class = "tsb_example", title = "TSB - " .. SWEP.PrintName } )	-- type without CAPS LOCK

------------------------------------
-->> IF YOU WANT TO CHANGE SMTH <<--
------------------------------------

--[[

	In this base have a lot of functions, that can be changed
	
	\/\/\/\/\/\/\/\/\/\/\/\/\/\/
	
	1. Primary Attack:
	
	OverHeatPA;
	JamPA;
	BulletTable;
	CustomPrimaryA;
	EmitFireSound;
	EmitEmptySound;
	EmitOverheatSound;
	EmitJamSound;
	EmitLowAmmoSound;
	EmitNoAmmoSound;
	SpreadFuturePA;
	CanPrimaryAttack.
	
		--
	
	2. Reload:
	
	CustomReload;
	CanReload;
	Finish.
	
		--
	
	3. Think:
	
	Bobbing;
	CustomThink;
	IdleAnim;
	ReloadBase;
	SpreadFuture;
	CrosshairThink;
	FireMode;
	OverHeatSimple;
	DynamicHoldType;
	SprintRelated;
	IronRelated.
	
		--
	
	4. Deploy:
	
	Draw.
	
		--
	
	5. Holster:
	
	CustomHolster;
	
		--
	
	6. Other:
	
	IronDisabler;
	ShotRel;
	ShotRelDisable.
	
]]

--───────────────▄──────────────▄
--──────────────▌▒█───────────▄▀▒▌
--──────────────▌▒▒▀▄───────▄▀▒▒▒▐
--─────────────▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐
--───────────▄▄▀▒▒▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐
--─────────▄▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀██▀▒▌
--────────▐▒▒▒▄▄▄▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄▒▒▌
--────────▌▒▒▐▄█▀▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐
--───────▐▒▒▒▒▒▒▒▒▒▒▒▌██▀▒▒▒▒▒▒▒▒▀▄▌
--───────▌▒▀▄██▄▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▌
--───────▌▀▐▄█▄█▌▄▒▀▒▒▒▒▒▒░░░░░░▒▒▒▐
--──────▐▒▀▐▀▐▀▒▒▄▄▒▄▒▒▒▒▒░░░░░░▒▒▒▒▌
--──────▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒░░░░░░▒▒▒▐
--───────▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▒▒░░░░▒▒▒▒▌
--───────▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
--────────▀▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▌
--──────────▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀
--─────────▐▀▒▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀