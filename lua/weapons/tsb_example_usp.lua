AddCSLuaFile()

DEFINE_BASECLASS("too_simple_base")

SWEP.Base 						= "too_simple_base"	-- not really xd

if CLIENT then
	SWEP.VElements = {
		["laser+"] = { type = "Model", model = "models/props_c17/FurnitureRadiator001a.mdl", bone = "v_weapon.USP_Parent", rel = "", pos = Vector(0, -0.519, -4.676), angle = Angle(0, -90, -90), size = Vector(0.064, 0.064, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/cs_italy/plaster", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_interiors/refrigerator01a.mdl", bone = "v_weapon.USP_Parent", rel = "", pos = Vector(0, -1.8, -4.676), angle = Angle(0, 0, 0), size = Vector(0.064, 0.064, 0.064), color = Color(48, 48, 48, 255), surpresslightning = false, material = "models/cs_italy/plaster", skin = 0, bodygroup = {} },
		["laser++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x6.mdl", bone = "v_weapon.USP_Parent", rel = "", pos = Vector(0, -1.8, -6.753), angle = Angle(0, 0, -180), size = Vector(0.009, 0.009, 10), color = Color(255, 0, 0, 90), surpresslightning = false, material = "models/cs_italy/plaster", skin = 0, bodygroup = {} }
	}
end

SWEP.PrintName 					= "Heckler & Koch USP"
SWEP.Category 					= "TSB Example"
SWEP.Slot 						= 1
SWEP.Spawnable 					= true	-- can spawn by normal people (by default, it is false)
SWEP.AdminSpawnable 			= true	-- can spawn by admin people (by default, it is false)

SWEP.HoldType 					= "pistol"	-- pistol, revolver, smg, ar2, shotgun, rpg

SWEP.ViewModel 					= "models/weapons/cstrike/c_pist_usp.mdl"	-- model path in 1st person
SWEP.UseHands 					= true	-- use c_arms (by default, it is false)
SWEP.WorldModel 				= "models/weapons/w_pist_usp_silencer.mdl"	-- model path in 3rd person

SWEP.Primary.Sound 				= Sound( "Weapon_USP.Single" )	-- firing sound, you can delete this

SWEP.Primary.ClipSize 			= 12	-- clip size
SWEP.Primary.DefaultClip 		= SWEP.Primary.ClipSize * 3	-- added ammo when you spawn your gun
SWEP.Primary.FireMode 			= 0	-- 0 is semi, 1 is burst and 2 is auto mode
SWEP.Primary.Ammo 				= "357"	-- pistol, 357, smg1, ar2, buckshot
SWEP.Primary.Damage 			= 10	-- NPCs deal /2 Damage
SWEP.Primary.StrenghtRecoil 	= 5	-- recoil up, you can delete this
SWEP.Primary.Spread 			= 0.4	-- spread / 100 = real spread
SWEP.Primary.SpreadTimerNumber 	= 0.28045	-- timer to set spread to def value
SWEP.Primary.RPM 				= 300	-- 60 / RPM = Delay between shots

SWEP.RecoilType 				= 5	-- you can delete this, by def it is 0

SWEP.Primary.ViewPunchUp 		= 2.5	-- up/down, you can delete this
SWEP.Primary.ViewPunchRight 	= 0.75	-- right/left, you can delete this (autocal)
SWEP.Primary.ViewPunchRoll 		= 0	-- what? you can delete this (autocal)
SWEP.ResetViewPunch 			= true	-- reset view punch after shot, true/false, you can delete this

SWEP.MuzzleAtt 					= "1"	-- "1" for css guns, "muzzle" for hl2 guns, you can delete this (by default, it is nil)
SWEP.MuzzleEffect 				= ""	-- you can delete this (by default, it is nil)

SWEP.IronSightsPos 				= Vector(-4, 0.21, -1.4)
SWEP.IronSightsAng 				= Vector(0, 0.5, -19.698)

SWEP.RunPos 					= Vector(-0.603, -6.433, -9.447)
SWEP.RunAng 					= Vector(33.064, 3.517, -2.112)

SWEP.ReloadingTime 				= 1.6	-- reloading timer only for non-shotgun reloads, you can delete this (it will use the sequence duration)

SWEP.CustomPos 					= Vector(-2.412, 2.009, 1.608)

SWEP.Silencer 					= 0
SWEP.SilencerTimer 				= CurTime()

function SWEP:CustomPrimaryA()
	if self.Silencer == 0 then
		if self.Weapon:Clip1() > 1 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			else
			self.Weapon:SendWeaponAnim( ACT_VM_DRYFIRE )
		end
		else
		if self.Weapon:Clip1() > 1 then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_SILENCED )
			else
			self.Weapon:SendWeaponAnim( ACT_VM_DRYFIRE_SILENCED )
		end
	end
end

function SWEP:SecondaryAttack()	-- custom sec. attack
	if !self:CanSecondary() then return end
	if self.Silencer == 0 then
		self.Weapon:SendWeaponAnim( ACT_VM_ATTACH_SILENCER )
		if IsFirstTimePredicted() then
			self.Silencer = 1
		end
		else
		if self.Silencer == 2 then
			self.Weapon:SendWeaponAnim( ACT_VM_DETACH_SILENCER )
			if IsFirstTimePredicted() then
				self.Silencer = 3
			end
		end
	end
	self.SilencerTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:CanSecondary()
	if self.Reloading == 1 or !self.Owner:KeyDown( IN_USE ) then
		return false
	end
	return true
end

function SWEP:CustomReload()
	if self.Silencer == 0 then
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
		else
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD_SILENCED )
	end
end

function SWEP:CustomThink()
	if self.SilencerTimer <= CurTime() then
		if self.Silencer == 1 then
			self.Silencer = 2
			else
			if self.Silencer == 3 then
				self.Silencer = 0
			end
		end
	end
	if self.Silencer == 0 then
		self.MuzzleEffect = "tsb_universal_muzzle_flash"
		self.Primary.Sound = Sound( "Weapon_USP.Single" )
		self.ShowTracerInXChance = 1
		self.Primary.Damage = 26
		else
		self.MuzzleEffect = "tsb_silenced_muzzle"
		self.Primary.Sound = Sound( "Weapon_USP.SilencedShot" )
		self.ShowTracerInXChance = 0
		self.Primary.Damage = 18
	end
end

function SWEP:Draw()
	if self.Silencer == 0 then
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
		else
		self.Weapon:SendWeaponAnim( ACT_VM_DRAW_SILENCED )
	end
end

function SWEP:CustomHolster()
	if self.Silencer == 1 then
		self.Silencer = 0
		else
		if self.Silencer == 3 then
			self.Silencer = 2
		end
	end
end

function SWEP:IdleAnim()
	if self.Idle == 0 then
		self.Idle = 1
	end
	if SERVER and self.Idle == 1 then
		if self.Silencer == 0 then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
			else
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE_SILENCED )
		end
	end
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

SWEP.NPCFires 					= 2	-- how much they need to shoot
list.Add( "NPCUsableWeapons", { class = "tsb_example_usp", title = "TSB - " .. SWEP.PrintName } )	-- type without CAPS LOCK

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