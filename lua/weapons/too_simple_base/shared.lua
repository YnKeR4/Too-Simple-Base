AddCSLuaFile()


SWEP.Base = "weapon_base"
SWEP.language = ( GetConVar( "gmod_language" ) )
SWEP.PrintName = nil
SWEP.PrintNameRus = nil
if ( SWEP.language:GetString() == "ru" ) and SWEP.PrintNameRus != nil then
	SWEP.PrintName = SWEP.PrintNameRus
end
SWEP.LuaName = ""
SWEP.SelectIconPath = ""
SWEP.Category = ""
SWEP.Spawnable= false
SWEP.AdminSpawnable= false
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 54
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ViewModelFlip = false

SWEP.SwayScale = 1
SWEP.BobScale = 1

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.Weight = 25

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.UseHands = false
SWEP.HoldType = ""
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = true

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.DrawSound = nil
SWEP.ReloadSound = nil

SWEP.Primary.Sound = nil
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.FireMode = nil
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = nil
SWEP.Primary.Damage = nil
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.StrenghtRecoil = nil
SWEP.Primary.RealSpread = 5
SWEP.Primary.Spread = nil
SWEP.Primary.SpreadTimer = CurTime()
SWEP.Primary.SpreadTimerNumber = nil
SWEP.Primary.NumberofShots = 1
SWEP.Primary.RPM = nil

SWEP.Secondary.Sound = nil
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Damage = nil
SWEP.Secondary.Delay = nil

SWEP.ShowTracerInXChance = nil
SWEP.TracerName = nil
SWEP.BulletImpactName = nil

SWEP.ShowViewModel = nil
SWEP.ShowWorldModel = nil

SWEP.Primary.ViewPunchUp = nil
SWEP.Primary.ViewPunchRight = nil
SWEP.Primary.ViewPunchRoll = nil

SWEP.WhenRoll = 0
SWEP.ResetViewPunch = false

SWEP.VElements = {}
SWEP.WElements = {}

SWEP.Burst = 0
SWEP.BurstDelay = CurTime()
SWEP.ShootsOnlyInIron = false
SWEP.Primary.SoundExtra = nil
SWEP.Jam = 0
SWEP.JamActive = 0

local damageMult = 1

if GetConVar( "tsb_damage_multi" ) == nil then
	damageMult = 1
	else
	damageMult = GetConVar("tsb_damage_multi"):GetFloat()
	if damageMult > 9999999999 then
		damageMult = 1
	end
	if damageMult <= 0 then
		damageMult = 1
	end
end

function RefreshTheDmgMulti(cvar, previous, new)
	if GetConVar( "tsb_damage_multi" ) == nil then
		damageMult = 1
		else
		damageMult = GetConVar("tsb_damage_multi"):GetFloat()
		if damageMult > 9999999999 then
			damageMult = 1
		end
		if damageMult <= 0 then
			damageMult = 1
		end
	end
end

cvars.AddChangeCallback("tsb_damage_multi", RefreshTheDmgMulti)

local disableJamming = 0

if GetConVar( "tsb_force_disable_jamming" ) == nil then
	disableJamming = 0
	else
	disableJamming = GetConVar("tsb_force_disable_jamming"):GetFloat()
end

function RefreshTheDisableJamming(cvar, previous, new)
	if GetConVar( "tsb_force_disable_jamming" ) == nil then
		disableJamming = 0
		else
		disableJamming = GetConVar("tsb_force_disable_jamming"):GetFloat()
	end
end

cvars.AddChangeCallback("tsb_force_disable_jamming", RefreshTheDisableJamming)

local forceCanShootWhileR = 0

if GetConVar( "tsb_force_shoot_while_running" ) == nil then
	forceCanShootWhileR = 0
	else
	forceCanShootWhileR = GetConVar("tsb_force_shoot_while_running"):GetFloat()
end

function RefreshTheDisableSprintFunction(cvar, previous, new)
	if GetConVar( "tsb_force_shoot_while_running" ) == nil then
		forceCanShootWhileR = 0
		else
		forceCanShootWhileR = GetConVar("tsb_force_shoot_while_running"):GetFloat()
	end
end

cvars.AddChangeCallback("tsb_force_shoot_while_running", RefreshTheDisableSprintFunction)

local forceDisableCustomE = 0

if GetConVar( "tsb_force_disable_custom_effects" ) == nil then
	forceDisableCustomE = 0
	else
	forceDisableCustomE = GetConVar("tsb_force_disable_custom_effects"):GetFloat()
end

function RefreshTheDisableCustomE(cvar, previous, new)
	if GetConVar( "tsb_force_disable_custom_effects" ) == nil then
		forceDisableCustomE = 0
		else
		forceDisableCustomE = GetConVar("tsb_force_disable_custom_effects"):GetFloat()
	end
end

cvars.AddChangeCallback("tsb_force_disable_custom_effects", RefreshTheDisableCustomE)

local shootOnlyInIron = 0

if GetConVar( "tsb_force_shoot_only_in_iron" ) == nil then
	shootOnlyInIron = 0
	else
	shootOnlyInIron = GetConVar("tsb_force_shoot_only_in_iron"):GetFloat()
end

function RefreshTheShootingInIron(cvar, previous, new)
	if GetConVar( "tsb_force_shoot_only_in_iron" ) == nil then
		shootOnlyInIron = 0
		else
		shootOnlyInIron = GetConVar("tsb_force_shoot_only_in_iron"):GetFloat()
	end
end

cvars.AddChangeCallback("tsb_force_shoot_only_in_iron", RefreshTheShootingInIron)

function SWEP:PrimaryAttack()
	if ( self.ShootsOnlyInIron == true || shootOnlyInIron == 1 ) and self.Iron == 0 then return end
	local owner = self:GetOwner()
	if self.Weapon:Clip1() == 0 and self.Weapon:Ammo1() >= 1 and (!owner:IsNPC()) then
		self:Reload()
	end
	if (!self:CanPrimaryAttack()) then return end
	local bullet = {}
	bullet.Num = self.Primary.NumberofShots
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	if self.ShowTracerInXChance >= 0 then
		bullet.Tracer = self.ShowTracerInXChance
	end
	if self.ShowTracerInXChance == nil then
		bullet.Tracer = 1
	end
	if self.TracerName != nil then
		bullet.TracerName = self.TracerName
	end
	if self.TracerName == nil then
		bullet.TracerName = "Tracer"
	end
	bullet.Force = self.Primary.Damage * damageMult / 4
	if (!owner:IsNPC()) then
		bullet.Damage = self.Primary.Damage * damageMult
		bullet.Spread = Vector( self.Primary.RealSpread, self.Primary.RealSpread, 0 )
	end
	if owner:IsNPC() then
		bullet.Damage = self.Primary.Damage * damageMult / 2
		bullet.Spread = Vector( self.Primary.RealSpread / 100, self.Primary.RealSpread / 100, 0 )
	end
	if self.Primary.Ammo != nil then
		bullet.AmmoType = self.Primary.Ammo
	end
	if self.Primary.Ammo == nil then
		if self.HoldType == "pistol" then
			bullet.AmmoType = "pistol"
		end
		if self.HoldType == "ar2" then
			bullet.AmmoType = "ar2"
		end
		if self.HoldType == "smg" then
			bullet.AmmoType = "smg1"
		end
		if self.HoldType == "revolver" then
			bullet.AmmoType = "357"
		end
		if self.HoldType == "shotgun" then
			bullet.AmmoType = "buckshot"
		end
		if self.HoldType == "rpg" then
			bullet.AmmoType = "SniperPenetratedRound"
		end
		if self.HoldType == "crossbow" then
			bullet.AmmoType = "XBowBolt"
		end
	end
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:FireBullets( bullet )
	if self.Primary.Sound != nil then
		self.Owner:EmitSound( self.Primary.Sound )
	end
	if self.Primary.SoundExtra != nil then
		self:StopSound( self.Primary.SoundExtra )
		self.Owner:EmitSound( self.Primary.SoundExtra )
	end
	self.Owner:MuzzleFlash()
	self:TakePrimaryAmmo( self.Primary.TakeAmmo )
	if self.Primary.RPM > 0 then
		if self.Primary.FireMode == 0 or self.Primary.FireMode == 2 then
			self:SetNextPrimaryFire( CurTime() + ( 60 / self.Primary.RPM ) )
			self:SetNextSecondaryFire( CurTime() + ( 60 / self.Primary.RPM ) )
		end
		if self.Primary.FireMode == 1 then
			if self.Burst == 0 then
				self.Burst = 1
				self.BurstDelay = CurTime() + ( 60 / self.Primary.RPM )
			end
			self:SetNextPrimaryFire( CurTime() + ( 60 / self.Primary.RPM * 4 ) )
			self:SetNextSecondaryFire( CurTime() + ( 60 / self.Primary.RPM * 4 ) )
		end
	end
	if self.Primary.RPM == nil then
		if self.Primary.FireMode == 0 or self.Primary.FireMode == 2 then
			self:SetNextPrimaryFire( CurTime() + ( self.Owner:GetViewModel():SequenceDuration() ) )
			self:SetNextSecondaryFire( CurTime() + ( self.Owner:GetViewModel():SequenceDuration() ) )
		end
		if self.Primary.FireMode == 1 then
			self:SetNextPrimaryFire( CurTime() + ( self.Owner:GetViewModel():SequenceDuration() * 3 ) )
			self:SetNextSecondaryFire( CurTime() + ( self.Owner:GetViewModel():SequenceDuration() * 3 ) )
			if self.Burst == 0 then
				self.Burst = 1
				self.BurstDelay = CurTime() + ( self.Owner:GetViewModel():SequenceDuration() )
			end
		end
	end
	if self.WhenRoll == 0 then
		self.WhenRoll = 1
		else
		if self.WhenRoll == 1 then
			self.WhenRoll = 0
		end
	end
	if (!owner:IsNPC()) then
		self.Jam = math.Rand( 0, 100 )
		if disableJamming == 0 then
			if self.Primary.Ammo == "pistol" then
				if self.Jam <= 0.75 and self.Weapon:Clip1() > 0 then
					self.Owner:EmitSound( "TooSimpleBase.Jam" )
					self.JamActive = 1
				end
			end
			if self.Primary.Ammo == "ar2" or self.Primary.Ammo == "smg1" then
				if self.Jam <= 0.8 and self.Weapon:Clip1() > 0 then
					self.Owner:EmitSound( "TooSimpleBase.Jam" )
					self.JamActive = 1
				end
			end
			if self.Primary.Ammo == "357" or self.Primary.Ammo == "SniperPenetratedRound" then
				if self.Jam <= 0.85 and self.Weapon:Clip1() > 0 then
					self.Owner:EmitSound( "TooSimpleBase.Jam" )
					self.JamActive = 1
				end
			end
			if self.Primary.Ammo == "buckshot" then
				if self.Jam <= 0.65 and self.Weapon:Clip1() > 0 then
					self.Owner:EmitSound( "TooSimpleBase.Jam" )
					self.JamActive = 1
				end
				else
				if self.Jam <= 0.7 and self.Weapon:Clip1() > 0 then
					self.Owner:EmitSound( "TooSimpleBase.Jam" )
					self.JamActive = 1
				end
			end
		end
		if self.ReloadShot > 0 then
			self:ShotRelDisable()
		end
		if self.ResetViewPunch == true then
			self.Owner:ViewPunchReset()
		end
		if self.Weapon:Clip1() >= 1 then
			self.Idle = 0
		end
		if self.Weapon:Clip1() < 1 or self.Iron == 1 then
			self.Idle = 2
		end
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		if self.Iron == 0 then
			if self.WhenRoll == 0 then
				if self.Primary.ViewPunchRoll != nil then
					self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchRoll ) )
				end
				if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchUp ) )
				end
				if self.Primary.StrenghtRecoil != nil then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, self.Primary.StrenghtRecoil / 2, 0 ) )
				end
				if self.Primary.ViewPunchRight != nil then
					self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchRight, 0 ) )
				end
				if self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchUp / 2, 0 ) )
				end
			end
			if self.WhenRoll == 1 then
				if self.Primary.ViewPunchRoll != nil then
					self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchRoll ) )
				end
				if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchUp ) )
				end
				if self.Primary.StrenghtRecoil != nil then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, -1 * self.Primary.StrenghtRecoil / 2, 0 ) )
				end
				if self.Primary.ViewPunchRight != nil then
					self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchRight, 0 ) )
				end
				if self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchUp / 2, 0 ) )
				end
			end
			if self.Primary.StrenghtRecoil != nil then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.StrenghtRecoil, 0, 0 ) )
			end
			self.Primary.SpreadTimer = CurTime() + self.Primary.SpreadTimerNumber
			if self.Primary.RealSpread >= self.Primary.Spread / 100 and self.Primary.RealSpread < self.Primary.Spread then
				self.Primary.RealSpread = self.Primary.RealSpread + self.Primary.Spread / 250
				self.Primary.SpreadTimer = CurTime() + self.Primary.SpreadTimerNumber
			end
			if self.Primary.ViewPunchUp != nil then
				self.Owner:ViewPunch( Angle( -1 * self.Primary.ViewPunchUp, 0, 0 ) )
			end
		end
		if self.Iron == 1 then
			if self.WhenRoll == 0 then
				if self.Primary.ViewPunchRoll != nil then
					self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchRoll / 2 ) )
				end
				if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchUp / 2 ) )
				end
				if self.Primary.StrenghtRecoil != nil then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, self.Primary.StrenghtRecoil / 4, 0 ) )
				end
				if self.Primary.ViewPunchRight != nil then
					self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchRight / 2, 0 ) )
				end
				if self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchUp / 4, 0 ) )
				end
			end
			if self.WhenRoll == 1 then
				if self.Primary.ViewPunchRoll != nil then
					self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchRoll / 2 ) )
				end
				if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchUp / 2 ) )
				end
				if self.Primary.StrenghtRecoil != nil then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, -1 * self.Primary.StrenghtRecoil / 4, 0 ) )
				end
				if self.Primary.ViewPunchRight != nil  then
					self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchRight / 2, 0 ) )
				end
				if self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
					self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchUp / 4, 0 ) )
				end
			end
			if self.Primary.StrenghtRecoil != nil then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.StrenghtRecoil / 1.5, 0, 0 ) )
			end
			self.Primary.SpreadTimer = CurTime() + self.Primary.SpreadTimerNumber
			if self.Primary.RealSpread >= self.Primary.Spread / 100 and self.Primary.RealSpread < self.Primary.Spread then
				self.Primary.RealSpread = self.Primary.RealSpread + self.Primary.Spread / 300
				self.Primary.SpreadTimer = CurTime() + self.Primary.SpreadTimerNumber
			end
			if self.Primary.ViewPunchUp != nil then
				self.Owner:ViewPunch( Angle( -1 * self.Primary.ViewPunchUp / 2, 0, 0 ) )
			end
		end
		if self.MuzzleAtt != nil and self.MuzzleEffect != nil and forceDisableCustomE == 0 then
			local FX = EffectData{}
			local fx = EffectData()
			fx:SetEntity(self.Weapon)
			fx:SetOrigin(self.Owner:GetShootPos())
			fx:SetNormal(self.Owner:GetAimVector())
			fx:SetAttachment(self:LookupAttachment(self.MuzzleAtt))
			util.Effect(self.MuzzleEffect,fx)
		end
		self.Reloading = 0
		self.ReloadingTimer = CurTime() + 0.1
	end
	self:PAC()
end

SWEP.MuzzleEffect = nil

function SWEP:CanPrimaryAttack()
	if self.Weapon:Clip1() == 0 or self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 or self.Reloading == 1 then
		self.Owner:EmitSound( "TooSimpleBase.Empty" )
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:SetNextSecondaryFire( CurTime() + 1 )
		return false
	end
	if self.Sprint == 1 then
		return false
	end
	if self.JamActive == 1 then
		self.Owner:EmitSound( "TooSimpleBase.Alert" )
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:SetNextSecondaryFire( CurTime() + 1 )
		return false
	end
	return true
end

SWEP.Chambering = true
SWEP.m_WeaponDeploySpeed = 1
SWEP.Reloading = 0
SWEP.ReloadingTimer = CurTime()

function SWEP:Reload()
	if self.UseFireMode == 0 and self.Reloading == 0 and self.ReloadingTimer <= CurTime() and self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 and self.ReloadShot == 0 and self.ReloadShotTimer <= CurTime() then
		self.Owner:SetAnimation( PLAYER_RELOAD )
		self.Primary.SpreadTimer = CurTime()
		self.Idle = 0
		self:IronDisabler()
		self.Owner:SetFOV( 0, 0.1 )
		self.JamActive = 0
		if self.ShotgunReload == false then
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			if self.ReloadSound != nil then
				self:EmitSound( self.ReloadSound )
			end
			local owner = self:GetOwner()
			if (!owner:IsNPC()) then
				self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
				self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
				self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
				self.Reloading = 1
				self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			end
		end
		if self.ShotgunReload == true then
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
			self.Owner:SetAnimation( PLAYER_RELOAD )
			local owner = self:GetOwner()
			if (!owner:IsNPC()) then
				self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.5
				self.ReloadShot = 1
				self.ReloadShotTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			end
		end
	end
end

function SWEP:Finish()
	if self.Weapon:Ammo1() > ( self.Primary.ClipSize - self.Weapon:Clip1() ) then
		self.Owner:SetAmmo( self.Weapon:Ammo1() - self.Primary.ClipSize + self.Weapon:Clip1(), self.Primary.Ammo )
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end
	if ( self.Weapon:Ammo1() - self.Primary.ClipSize + self.Weapon:Clip1() ) + self.Weapon:Clip1() < self.Primary.ClipSize then
		self.Weapon:SetClip1( self.Weapon:Clip1() + self.Weapon:Ammo1() )
		self.Owner:SetAmmo( 0, self.Primary.Ammo )
	end
	self.Reloading = 0
end

SWEP.ReloadShot = 0
SWEP.ReloadShotTimer = CurTime()
SWEP.ShotgunReload = false

function SWEP:ShotRelDisable()
	self.ReloadShot = 0
	self.ReloadShotTimer = CurTime()
	self.Primary.SpreadTimer = CurTime()
	self.Idle = 0
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.5
	end
end

local disableIron = 0

if GetConVar( "tsb_force_disable_iron" ) == nil then
	disableIron = 0
	else
	disableIron = GetConVar( "tsb_force_disable_iron" ):GetFloat()
end

function RefreshTheDIron(cvar, previous, new)
	if GetConVar( "tsb_force_disable_iron" ) == nil then
		disableIron = 0
		else
		disableIron = GetConVar( "tsb_force_disable_iron" ):GetFloat()
	end
end

cvars.AddChangeCallback("tsb_force_disable_iron", RefreshTheDIron)

function SWEP:Think()
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		if self.ReloadShot == 1 and self.ReloadShotTimer <= CurTime() then
			if self.ReloadSound != nil then
				self:EmitSound( self.ReloadSound )
			end
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.5
			self.ReloadShot = 2
			self.ReloadShotTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		end
		if self.ReloadShot == 2 and self.ReloadShotTimer <= CurTime() and self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 then
			if self.ReloadSound != nil then
				self:EmitSound( self.ReloadSound )
			end
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.5
			self.ReloadShot = 2
			self.ReloadShotTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		end
		if !( self.ReloadShot == 0 ) and self.ReloadShotTimer <= CurTime() then
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			if self.Weapon:Clip1() == self.Primary.ClipSize then
				self:ShotRelDisable()
			end
			if self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() <= 0 then
				self:ShotRelDisable()
			end
		end
		if self.Reloading == 1 and self.ReloadingTimer <= CurTime() then
			self:Finish()
		end
		if self.Owner:IsOnGround() then
			if self.Iron == 0 then
				if self.Owner:GetVelocity():Length() <= 100 then
					if self.Owner:KeyDown( IN_DUCK ) then
						self.Primary.RealSpread = self.Primary.Spread / 125
					end
					if self.Primary.SpreadTimer <= CurTime() then
						self.Primary.RealSpread = self.Primary.Spread / 100
					end
				end
				if self.Owner:KeyDown( IN_FORWARD ) or self.Owner:KeyDown( IN_BACK ) or self.Owner:KeyDown( IN_MOVELEFT ) or self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_SPEED ) and self.Primary.RealSpread <= self.Primary.Spread / 100 then
					self.Primary.RealSpread = self.Primary.Spread / 50
				end
				if self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
					self.Primary.RealSpread = self.Primary.Spread / 25
				end
				if self.Owner:GetVelocity():Length() <= 100 and self.Primary.RealSpread > self.Primary.Spread / 15 then
					self.Primary.RealSpread = self.Primary.Spread / 15
				end
			end
			if self.Iron == 1 then
				if self.Owner:GetVelocity():Length() <= 100 then
					if self.Owner:KeyDown( IN_DUCK ) then
						self.Primary.RealSpread = self.Primary.Spread / 150
					end
					if self.Primary.SpreadTimer <= CurTime() then
						self.Primary.RealSpread = self.Primary.Spread / 125
					end
				end
				if self.Owner:KeyDown( IN_FORWARD ) or self.Owner:KeyDown( IN_BACK ) or self.Owner:KeyDown( IN_MOVELEFT ) or self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_SPEED ) and self.Primary.RealSpread <= self.Primary.Spread / 125 then
					self.Primary.RealSpread = self.Primary.Spread / 75
				end
				if self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
					self.Primary.RealSpread = self.Primary.Spread / 50
				end
				if self.Owner:GetVelocity():Length() <= 100 and self.Primary.RealSpread > self.Primary.Spread / 25 then
					self.Primary.RealSpread = self.Primary.Spread / 25
				end
			end
		end
		if !self.Owner:IsOnGround() then
			if self.Primary.Ammo != "buckshot" then
				self.Primary.RealSpread = self.Primary.Spread / 15
			end
			if self.Primary.Ammo == "buckshot" then
				self.Primary.RealSpread = self.Primary.Spread / 25
			end
			self.Primary.SpreadTimer = CurTime() + 0.1
		end
		if self.Idle == 0 and self.IdleTimer > CurTime() and self.IdleTimer < CurTime() + 0.1 then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
			self.Idle = 1
		end
		if SERVER and self.DrawCrosshair == false then
			self.Weapon:SetNWString( "Crosshair1", ( ( self.Primary.RealSpread + self.Primary.Spread / 45 ) / ( self.Primary.Spread / 45  ) * 20 ) )
			self.Weapon:SetNWString( "Crosshair2", ( ( self.Primary.RealSpread + self.Primary.Spread / 45 ) / ( self.Primary.Spread / 45  ) * 20 - 7.5 ) )
		end
		self.BobScale = self.Weapon:GetNWString( "BobSway", 1.5 )
		self.SwayScale = self.Weapon:GetNWString( "BobSway", 1.5 )
		if self.Owner:KeyDown( IN_USE ) and self.Owner:KeyPressed( IN_RELOAD ) then
			self.UseFireMode = 1
			self:FireMode()
		end
		if self.TextTimer <= CurTime() then
			self.Weapon:SetNWInt( "text", "" )
		end
		if self.Sprint == 0 and self.Reloading == 0 and self.ReloadShot == 0 and self.Iron == 0 then
			if self.Owner:KeyDown( IN_DUCK ) then
				self.Pos = self.WalkPos
				self.Ang = self.WalkAng
				self:SetRun( true, self.Owner )
			end
			if self.Owner:KeyReleased( IN_DUCK ) then
				self:SetRun( false, self.Owner )
			end
		end
	end
	if self.Primary.FireMode <= 1 then
		self.Primary.Automatic = self.Weapon:GetNWString( "Automatic", false )
	end
	if self.Primary.FireMode == 2 then
		self.Primary.Automatic = self.Weapon:GetNWString( "Automatic", true )
	end
	if self.Burst == 1 and self.BurstDelay <= CurTime() then
		self:PrimaryAttack()
		self.Burst = 2
		if self.Primary.RPM != nil then
			self.BurstDelay = CurTime() + ( 60 / self.Primary.RPM )
		end
		if self.Primary.RPM == nil then
			self.BurstDelay = CurTime() + ( self.Owner:GetViewModel():SequenceDuration() )
		end
		else
		if self.Burst == 2 and self.BurstDelay <= CurTime() then
			self:PrimaryAttack()
			self.Burst = 0
		end
	end
	if self.Iron == 1 and self.Sprint == 0 then
		self:SetWeaponHoldType( self.HoldTypeIron )
	end
	if disableIron == 0 then
		if self.IronSightsPos != nil and self.IronSightsAng != nil and self.Sprint == 0 and self.Reloading == 0 and self.ReloadShot == 0 then
			if self.Owner:KeyDown( IN_ATTACK2 ) and !self.Owner:KeyDown( IN_SPEED ) and self.Iron == 0 then
				if self.ScopeTexture > 0 then
					self.Owner:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), self.IronTime, self.IronTime )
				end
				self.Iron = 1
				self.IronIn = 1
				self.IronTimer = CurTime() + self.IronTime
			end
			if self.Owner:KeyReleased( IN_ATTACK2 ) and self.Iron == 1 then
				self.Iron = 0
				self.IronIn = 2
				self.IronTimer = CurTime() + self.IronTime / 2
				self.Owner:SetFOV( 0, self.IronTime )
			end
			if self.IronIn == 1 and self.IronTimer <= CurTime() then
				self.Owner:SetFOV( self.Owner:GetFOV() / self.IronFOVMult, self.IronTime / 2 )
				self.Weapon:SetNWString( "BobSway", 0.125 )
				self.Weapon:SetNWString( "MouseSensitivity", 1 / self.IronFOVMult - 0.125 )
				self.Pos = self.IronSightsPos
				self.Ang = self.IronSightsAng
				self:SetRun( true, self.Owner )
				self.IronIn = 0
				if self.ScopeTexture == 1 then
					self.Weapon:SetNWString( "typical_scope", 1 )
				end
				if self.ScopeTexture == 2 then
					self.Weapon:SetNWString( "scope_math", 1 )
				end
				if self.ScopeTexture == 3 then
					self.Weapon:SetNWString( "gdcw_acog", 1 )
				end
				if self.ScopeTexture == 4 then
					self.Weapon:SetNWString( "eotech_sight", 1 )
				end
			end
			if self.IronIn == 2 and self.IronTimer <= CurTime() then
				if self.ScopeTexture > 0 then
					self.Owner:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), self.IronTime / 2, self.IronTime / 2 )
				end
				self:IronDisabler()
			end
		end
	end
	if self.RunPos != nil and self.RunAng != nil and forceCanShootWhileR == 0 then
		if self.Owner:KeyDown( IN_SPEED ) and self.Owner:GetVelocity():Length() > 100 then
			self.Sprint = 1
			self.Pos = self.RunPos
			self.Ang = self.RunAng
			self:SetRun( true, self.Owner )
		end
		if self.Owner:KeyReleased( IN_SPEED ) and self.Sprint == 1 then
			self.Sprint = 0
			self.Pos = self.RunPos
			self.Ang = self.RunAng
			self:SetRun( false, self.Owner )
			self:SetNextPrimaryFire( CurTime() + 0.35 )
			self:SetNextSecondaryFire( CurTime() + 0.35 )
		end
		if self.Iron == 1 and self.Sprint == 1 then
			self.Iron = 0
			self:IronDisabler()
			self.Owner:SetFOV( 0, 0.1 )
		end
		if self.Sprint == 1 and self.Iron == 0 then
			self:SetWeaponHoldType( self.HoldTypeSprint )
		end
	end
	if self.Sprint == 0 and self.Iron == 0 then
		self:SetWeaponHoldType( self.HoldType )
	end
	self:TC()
end

SWEP.SwitchTo = nil

function SWEP:FireMode()
	if self.SwitchTo == nil or self.Reloading == 1 then return end
	if SERVER then
		timer.Simple(0.25, function() self.UseFireMode = 0 end)
		self.Owner:EmitSound( "TooSimpleBase.FireMode" )
	end
	self.TextTimer = CurTime() + 1.5
	if self.SwitchTo == "Semi-Auto" then
		if self.Primary.FireMode == 1 then
			self.Burst = true
		end
		if self.Primary.FireMode == 2 then
			self.Auto = true
		end
		if self.Primary.FireMode >= 1 then
			if IsFirstTimePredicted() then
				self.Primary.FireMode = 0
				self.Weapon:SetNWInt( "text", "Semi-Auto" )
				if ( self.language:GetString() == "ru" ) then
					self.Weapon:SetNWInt( "text", "Одиночный" )
				end
			end
			else
			if self.Primary.FireMode == 0 then
				if self.Auto == true then
					self.Primary.FireMode = 2
					self.Weapon:SetNWInt( "text", "Auto" )
					if ( self.language:GetString() == "ru" ) then
						self.Weapon:SetNWInt( "text", "Авто" )
					end
				end
				if self.Burst == true then
					self.Primary.FireMode = 1
					self.Weapon:SetNWInt( "text", "Burst" )
					if ( self.language:GetString() == "ru" ) then
						self.Weapon:SetNWInt( "text", "Очередями" )
					end
				end
			end
		end
	end
	if self.SwitchTo == "Auto" then
		if self.Primary.FireMode == 1 then
			self.Burst = true
		end
		if self.Primary.FireMode == 0 then
			self.Semi = true
		end
		if self.Primary.FireMode <= 1 then
			if IsFirstTimePredicted() then
				self.Primary.FireMode = 2
				self.Weapon:SetNWInt( "text", "Auto" )
				if ( self.language:GetString() == "ru" ) then
					self.Weapon:SetNWInt( "text", "Авто" )
				end
			end
			else
			if self.Primary.FireMode == 2 then
				if self.Semi == true then
					self.Primary.FireMode = 0
					self.Weapon:SetNWInt( "text", "Semi-Auto" )
					if ( self.language:GetString() == "ru" ) then
						self.Weapon:SetNWInt( "text", "Одиночный" )
					end
				end
				if self.Burst == true then
					self.Primary.FireMode = 1
					self.Weapon:SetNWInt( "text", "Burst" )
					if ( self.language:GetString() == "ru" ) then
						self.Weapon:SetNWInt( "text", "Очередями" )
					end
				end
			end
		end
	end
	if self.SwitchTo == "Burst" then
		if self.Primary.FireMode == 2 then
			self.Auto = true
		end
		if self.Primary.FireMode == 0 then
			self.Semi = true
		end
		if self.Primary.FireMode != 1 then
			if IsFirstTimePredicted() then
				self.Primary.FireMode = 1
				self.Weapon:SetNWInt( "text", "Burst" )
				if ( self.language:GetString() == "ru" ) then
					self.Weapon:SetNWInt( "text", "Очередями" )
				end
			end
			else
			if self.Primary.FireMode == 1 then
				if self.Semi == true then
					self.Primary.FireMode = 0
					self.Weapon:SetNWInt( "text", "Semi-Auto" )
					if ( self.language:GetString() == "ru" ) then
						self.Weapon:SetNWInt( "text", "Одиночный" )
					end
				end
				if self.Auto == true then
					self.Primary.FireMode = 2
					self.Weapon:SetNWInt( "text", "Auto" )
					if ( self.language:GetString() == "ru" ) then
						self.Weapon:SetNWInt( "text", "Авто" )
					end
				end
			end
		end
	end
end

SWEP.Auto = false
SWEP.Semi = false
SWEP.Burst = false
SWEP.TextTimer = CurTime()
SWEP.UseFireMode = 0

SWEP.HoldTypeSprint = ""
SWEP.HoldTypeIron = ""
SWEP.Sprint = 0
SWEP.RunPos = nil
SWEP.RunAng = nil
SWEP.ScopeTexture = 0
SWEP.Iron = 0
SWEP.IronTimer = CurTime()
SWEP.IronTime = 0.35
SWEP.IronFOVMult = 1.45

function SWEP:IronDisabler()
	self.IronIn = 0
	self.Iron = 0
	self.IronTimer = CurTime()
	self.Weapon:SetNWString( "BobSway", 1 )
	self.Weapon:SetNWString( "MouseSensitivity", 1 )
	self.Pos = self.IronSightsPos
	self.Ang = self.IronSightsAng
	self:SetRun( false, self.Owner )
	self.Weapon:SetNWString( "eotech_sight", 0 )
	self.Weapon:SetNWString( "typical_scope", 0 )
	self.Weapon:SetNWString( "scope_math", 0 )
	self.Weapon:SetNWString( "gdcw_acog", 0 )
end

function SWEP:Equip()
	self:SetRun( false, self.Owner )
	self.Weapon:SetNWString( "eotech_sight", 0 )
	self.Weapon:SetNWString( "typical_scope", 0 )
	self.Weapon:SetNWString( "scope_math", 0 )
	self.Weapon:SetNWString( "gdcw_acog", 0 )
	if self.Weapon:Clip1() > self.Primary.ClipSize then
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end
end

function SWEP:AdjustMouseSensitivity()
	return self.Weapon:GetNWString( "MouseSensitivity", 1 )
end

function SWEP:DrawHUD()
	local owner = self:GetOwner()
	if CLIENT and (!owner:IsNPC()) then
		draw.SimpleText( self.Weapon:GetNWInt( "text", "" ), "CloseCaption_Bold", ScrW() * 0.5, ScrH() * 0.35, Color( 124, 252, 0, 75 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	self:HUDC()
	if CLIENT then
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("eotech_sight",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_dirty" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_eotech2" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
	end
	if CLIENT then
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("typical_scope",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_lens" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_default" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
	end
	if CLIENT then
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("scope_math",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_lens" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_math" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
	end
	if CLIENT then
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("gdcw_acog",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_dirty" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/gdcw_acog" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_arc" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
	end
	if self.DrawCrosshair == false then
		if (owner:IsNPC()) or self.Iron == 1 or self.Sprint == 1 or self.ShootsOnlyInIron == true or shootOnlyInIron == 1 then return end
		if CLIENT then
			local x = ScrW() / 2
			local y = ScrH() / 2
			surface.SetDrawColor( 124, 252, 0, 75 )
			surface.DrawLine( x - self.Weapon:GetNWString( "Crosshair1", 0 ), y, x - self.Weapon:GetNWString( "Crosshair2", 0 ), y )
			surface.DrawLine( x + self.Weapon:GetNWString( "Crosshair1", 0 ), y, x + self.Weapon:GetNWString( "Crosshair2", 0 ), y )
			surface.DrawLine( x, y - self.Weapon:GetNWString( "Crosshair1", 0 ), x, y - self.Weapon:GetNWString( "Crosshair2", 0 ) )
			surface.DrawLine( x, y + self.Weapon:GetNWString( "Crosshair1", 0 ), x, y + self.Weapon:GetNWString( "Crosshair2", 0 ) )
		end
	end
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
	self.Reloading = 0
	self.ReloadingTimer = CurTime()
	self.UseFireMode = 0
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		self.TextTimer = CurTime() + 2.5
		self.Weapon:SetNWInt( "text", "E+R - To change the fire mode" )
		if ( self.language:GetString() == "ru" ) then
			self.Weapon:SetNWInt( "text", "E+R - Чтобы переключть режим огня" )
		end
		self.Idle = 0
		self.IdleTimer = CurTime() + 1
		self:IronDisabler()
		if CLIENT then
			self.VElements = table.FullCopy( self.VElements )
			self.WElements = table.FullCopy( self.WElements )
			self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
			self:CreateModels(self.VElements)
			self:CreateModels(self.WElements)
			if IsValid(self.Owner) then
				local vm = self.Owner:GetViewModel()
				if IsValid(vm) then
					self:ResetBonePositions(vm)
					if (self.ShowViewModel == nil or self.ShowViewModel) then
						vm:SetColor(Color(255,255,255,255))
					else
						vm:SetColor(Color(255,255,255,1))
						vm:SetMaterial("Debug/hsv")			
					end
				end
			end
		end
	end
end

function SWEP:Deploy()
	self:DC()
	self:SetWeaponHoldType( self.HoldType )
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	if self.DrawSound != nil then
		self.Owner:EmitSound( self.DrawSound )
	end
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		self.Primary.SpreadTimer = CurTime()
		self.Idle = 0
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.Owner:ViewPunchReset()
		self.Reloading = 0
		self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	end
end

function SWEP:Holster( wep )
	if self.BurstDelay > CurTime() then return end
	self.Primary.SpreadTimer = CurTime()
	self.Idle = 0
	self.IdleTimer = CurTime()
	self.Reloading = 0
	self.ReloadingTimer = CurTime()
	self:ShotRelDisable()
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		self:IronDisabler()
		self.Owner:SetFOV( 0, 0.1 )
		if CLIENT and IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
			end
		end
		self.Weapon:SetNWInt( "text", "" )
	end
	self:HC()
	return true
end

function SWEP:OnRemove()
	local owner = self:GetOwner()
	if CLIENT and IsValid(self.Owner) and (!owner:IsNPC()) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
end

function SWEP:CanBePickedUpByNPCs() return true end

function SWEP:ShouldDropOnDie() return true end

function SWEP:GetNPCRestTimes() 
	return 0.6, 0.8
end

SWEP.NPCFires = nil

function SWEP:GetNPCBurstSettings() 
	return
	self.NPCFires,
	self.NPCFires,
	60 / self.Primary.RPM	--[[ Firerate ]] 
end

function SWEP:GetNPCBulletSpread( proficiency ) return self.Primary.Spread * 2 - proficiency end	-- Spread for NPCs

if CLIENT then
	SWEP.DrawWeaponInfoBox	= false
	SWEP.BounceWeaponIcon = false
end

if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		if (!self.VElements) then return end
		self:UpdateBonePositions(vm)
		if (!self.vRenderOrder) then
			self.vRenderOrder = {}
			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
		end
		for k, name in ipairs( self.vRenderOrder ) do
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			if (!v.bone) then continue end
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			if (!pos) then continue end
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
			elseif (v.type == "Sprite" and sprite) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif (v.type == "Quad" and v.draw_func) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
		end
	end
	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		if (!self.WElements) then return end
		if (!self.wRenderOrder) then
			self.wRenderOrder = {}
			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end
		end
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			bone_ent = self
		end
		for k, name in pairs( self.wRenderOrder ) do
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			local pos, ang
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			if (!pos) then continue end
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
			elseif (v.type == "Sprite" and sprite) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
			elseif (v.type == "Quad" and v.draw_func) then
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
		end
	end
	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			local v = basetab[tab.rel]
			if (!v) then return end
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			if (!pos) then return end
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
		else
			bone = ent:LookupBone(bone_override or tab.bone)
			if (!bone) then return end
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r
			end
		end
		return pos, ang
	end
	function SWEP:CreateModels( tab )
		if (!tab) then return end
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end
				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
			end
		end
	end
	local allbones
	local hasGarryFixedBoneScalingYet = false
	function SWEP:UpdateBonePositions(vm)
		if self.ViewModelBoneMods then
			if (!vm:GetBoneCount()) then return end
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				loopthrough = allbones
			end
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				s = s * ms
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
	end
	function SWEP:ResetBonePositions(vm)
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
	end
	function table.FullCopy( tab )
		if (!tab) then return nil end
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v)
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		return res
	end
end

function SWEP:DoImpactEffect( tr, nDamageType )
	if self.BulletImpactName == nil then return end
	if ( tr.HitSky ) then return end
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )
	util.Effect( self.BulletImpactName, effectdata )
end

SWEP.IronSightsPos = nil
SWEP.IronSightsAng = nil

SWEP.Pos = Vector( 0, 0, 0 )
SWEP.Angle = Vector( 0, 0, 0 )

SWEP.WalkPos = Vector(-0.75, -2, -1)
SWEP.WalkAng = Vector(0, 0, 0)

local RunSpeed = 0.25

function SWEP:GetViewModelPosition(EyePos, EyeAng)
	local owner = self:GetOwner()
	if (owner:IsNPC()) then return end
	if (not self.Pos) then return pos, ang end
	local Mul = 1.0
	local bSprint = self.Weapon:GetNWBool("Iron")
	local Offset = self.Pos
	if (bSprint != self.bLastRun) then
		self.bLastRun = bSprint
		self.fRunSpeed = CurTime()
	end
	local fRunSpeed = self.fRunSpeed or 0
	if (not bSprint and fRunSpeed < CurTime() - RunSpeed) then
			return pos, ang
	end
	local Mul = 1.0
	if (fRunSpeed > CurTime() - RunSpeed) then
		Mul = math.Clamp((CurTime() - fRunSpeed) / RunSpeed, 0, 1)
		if not bSprint then Mul = 1 - Mul end
	end
	if (self.Ang) then
        EyeAng = EyeAng * 1    
		EyeAng:RotateAroundAxis(EyeAng:Right(), 	self.Ang.x * Mul)
		EyeAng:RotateAroundAxis(EyeAng:Up(), 		self.Ang.y * Mul)
		EyeAng:RotateAroundAxis(EyeAng:Forward(),   self.Ang.z * Mul)
	end
	local Right 	= EyeAng:Right()
	local Up 		= EyeAng:Up()
	local Forward 	= EyeAng:Forward()
	EyePos = EyePos + Offset.x * Right * Mul
	EyePos = EyePos + Offset.y * Forward * Mul
	EyePos = EyePos + Offset.z * Up * Mul
	return EyePos, EyeAng
end

function SWEP:SetRun(b)
	self.Weapon:SetNWBool("Iron", b)
end
 
function SWEP:GetRun()
	return self.Weapon:GetNWBool("Iron")
end

function SWEP:Ammo1()
	return self:GetOwner():GetAmmoCount( self.Weapon:GetPrimaryAmmoType() )
end

function SWEP:Ammo2()
	return self:GetOwner():GetAmmoCount( self.Weapon:GetSecondaryAmmoType() )
end

SWEP.MuzzleAtt = nil

function SWEP:PAC()
end

function SWEP:IC()
end

function SWEP:DC()
end

function SWEP:HC()
end

function SWEP:RC()
end

function SWEP:TC()
end

function SWEP:HUDC()
end

function SWEP:SecondaryAttack()
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	if self.MuzzleAtt != nil and forceDisableCustomE == 0 then
		-- Disables animation based muzzle event
		if ( event == 21 ) then return true end	
		-- Disable thirdperson muzzle flash
		if ( event == 5001 or event == 5011 or event == 5021 or event == 5031 ) then return true end
	end
end