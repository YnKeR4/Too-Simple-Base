AddCSLuaFile()

SWEP.Base = "weapon_base"

SWEP.language = ( GetConVar( "gmod_language" ) )
SWEP.PrintName = nil
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
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = true

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.DrawSound = nil
SWEP.ReloadSound = nil

SWEP.Primary.Sound = nil
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.FireMode = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Primary.Damage = nil
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.StrenghtRecoil = nil
SWEP.Primary.RealSpread = 5
SWEP.Primary.Spread = nil
SWEP.Primary.SpreadTimer = CurTime()
SWEP.Primary.SpreadTimerNumber = nil
SWEP.Primary.NumberofShots = 1
SWEP.Primary.RPM = nil

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

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
SWEP.Shots = 0
SWEP.ShotsTimer = CurTime()

SWEP.VElements = {}
SWEP.WElements = {}

SWEP.ShootsOnlyInIron = false
SWEP.Primary.SoundExtra = nil
SWEP.Jam = 0
SWEP.JamActive = 0
SWEP.Hot = 0
SWEP.HotActivity = 0
SWEP.HotTimer = CurTime()

SWEP.CamRelaxSpeed = 0.25
SWEP.CamdDispersion = 0
SWEP.CamdDispersionInc = nil
SWEP.CamMaxAngle = 0
SWEP.CamMaxAngleHorz = nil
SWEP.CamStepAngleHorz = nil
SWEP.CamdDispersionFrac = nil

if SWEP.CamdDispersionFrac != nil then
	SWEP.CamdDispersionF = SWEP.CamdDispersion * SWEP.CamdDispersionFrac - SWEP.CamdDispersion * ( 1 - SWEP.CamdDispersionFrac )
	else
	SWEP.CamdDispersionF = nil
end

SWEP.RecoilStalker = 0
SWEP.RecoilStalkerHorz = 0
SWEP.RecoilStalkerTimer = CurTime()
SWEP.RecoilType = 0

SWEP.Recoil = 0
SWEP.RecoilTimer = CurTime()
SWEP.RecoilDirection = 0
SWEP.Bob = 0
SWEP.BobX = 0
SWEP.BobDirectionX = 0
SWEP.BobY = 0
SWEP.BobDirectionY = 0
SWEP.Burst = 0
SWEP.BurstTimer = CurTime()

function SWEP:PrimaryAttack()
	local owner = self:GetOwner()
	if (!self:CanPrimaryAttack()) then return end
	local bullet = {}
	bullet.Num = self.Primary.NumberofShots
	bullet.Src = self.Owner:GetShootPos()
	if self.RecoilType != 4 then
		if owner:IsNPC() then
			bullet.Dir = owner:GetAimVector()
			else
			bullet.Dir = owner:GetAimVector() - self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * self.Shots / 500
		end
		else
		if self.Iron == 0 then
			if self.Primary.StrenghtRecoil != nil then
				bullet.Dir = self.Owner:GetAimVector() - math.Rand( self.Owner:EyeAngles():Right() * self.Primary.StrenghtRecoil - self.Owner:EyeAngles():Up() * self.Primary.StrenghtRecoil, -1 * self.Owner:EyeAngles():Right() * self.Primary.StrenghtRecoil - self.Owner:EyeAngles():Up() * self.Primary.StrenghtRecoil )
			end
			if self.Primary.StrenghtRecoil == nil and self.Primary.ViewPunchUp != nil and ( !owner:IsNPC() ) then
				if self.Primary.ViewPunchUp <= 0 then
					if self.Shots <= 12 then
						bullet.Dir = self.Owner:GetAimVector() + self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * ( 0.006 * self.Shots ) + self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * ( 0.006 * self.Shots )
						else
						bullet.Dir = self.Owner:GetAimVector() + self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * 0.06  + self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * 0.06
					end
					else
					if self.Shots <= 12 then
						bullet.Dir = self.Owner:GetAimVector() - self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * ( 0.006 * self.Shots ) - self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * ( 0.006 * self.Shots )
						else
						bullet.Dir = self.Owner:GetAimVector() - self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * 0.06 - self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * 0.06
					end
				end
			end
			else
			if self.Primary.StrenghtRecoil != nil then
				bullet.Dir = self.Owner:GetAimVector() - math.Rand( 0.5 * self.Owner:EyeAngles():Right() * self.Primary.StrenghtRecoil - self.Owner:EyeAngles():Up() * self.Primary.StrenghtRecoil, -0.5 * self.Owner:EyeAngles():Right() * self.Primary.StrenghtRecoil - self.Owner:EyeAngles():Up() * self.Primary.StrenghtRecoil )
			end
			if self.Primary.StrenghtRecoil == nil and self.Primary.ViewPunchUp != nil and ( !owner:IsNPC() ) then
				if self.Primary.ViewPunchUp <= 0 then
					bullet.Dir = self.Owner:GetAimVector() + self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * 0.04 + self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * 0.04
					else
					bullet.Dir = self.Owner:GetAimVector() - self.Owner:EyeAngles():Right() * self.Owner:GetViewPunchAngles().y * 0.04 - self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * 0.04
				end
			end
		end
		if ( owner:IsNPC() ) and self.Primary.StrenghtRecoil == nil then
			bullet.Dir = self.Owner:GetAimVector() - math.Rand( self.Owner:EyeAngles():Right() * -0.06 - self.Owner:EyeAngles():Up() * -0.06, self.Owner:EyeAngles():Right() * 0.06 - self.Owner:EyeAngles():Up() * 0.06 )
		end
	end
	if self.ShowTracerInXChance == nil then
		if self.TracerName == "" then
			bullet.Tracer = 0
			else
			bullet.Tracer = 1
		end
		else
		bullet.Tracer = self.ShowTracerInXChance
	end
	if self.TracerName != nil and self.TracerName != "" then
		bullet.TracerName = self.TracerName
		else
		bullet.TracerName = "Tracer"
	end
	bullet.Force = self.Primary.Damage * GetConVar( "tsb_damage_multi" ):GetFloat() / 4
	if (!owner:IsNPC()) then
		bullet.Damage = self.Primary.Damage * GetConVar( "tsb_damage_multi" ):GetFloat()
		bullet.Spread = Vector( self.Primary.RealSpread * GetConVar( "tsb_spread_multi" ):GetFloat(), self.Primary.RealSpread * GetConVar( "tsb_spread_multi" ):GetFloat(), 0 )
		else
		bullet.Damage = self.Primary.Damage * GetConVar( "tsb_damage_multi_npc" ):GetFloat() / 2
		bullet.Spread = Vector( self.Primary.Spread / 100 * GetConVar( "tsb_spread_multi" ):GetFloat(), self.Primary.Spread / 100 * GetConVar( "tsb_spread_multi" ):GetFloat(), 0 )
	end
	bullet.AmmoType = self.Primary.Ammo
	self:BulletTable( bullet )
	self:CustomPrimaryA()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:FireBullets( bullet )
	self:EmitFireSound()
	self.Owner:MuzzleFlash()
	if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() != 2 then
		self:TakePrimaryAmmo( self.Primary.TakeAmmo )
	end
	if self.WhenRoll == 0 then
		self.WhenRoll = 1
		else
		if self.WhenRoll == 1 then
			self.WhenRoll = 0
		end
	end
	self.Shots = self.Shots + 1
	self.ShotsTimer = CurTime() + 60 / self.Primary.RPM * 2
	if SERVER and GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() <= 1 then 
		if self.Weapon:Clip1() <= math.Round( self.Primary.ClipSize * 0.2 ) and self.Weapon:Clip1() != 0 then
			self:EmitLowAmmoSound()
		end
		if self.Weapon:Clip1() <= 0 then
			self:EmitNoAmmoSound()
		end
	end
	if ( owner:IsPlayer() ) then
		if GetConVar( "tsb_force_disable_overheating" ):GetFloat() == 0 then
			self:OverHeatPA()
		end
		self.Jam = math.Rand( 0, 100 )
		if GetConVar( "tsb_force_disable_jamming" ):GetFloat() == 0 then
			self:JamPA()
		end
		if self.ResetViewPunch == true then
			self.Owner:ViewPunchReset()
		end
		if self.Weapon:Clip1() > 0 then
			self.Idle = 0
			else
			self.Idle = 2
		end
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		if ( CLIENT || game.SinglePlayer() ) then
			if self.Iron == 0 then
				if self.WhenRoll == 1 then
					if self.Primary.ViewPunchRoll != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchRoll * self.Shots ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchRoll ) )
						end
					end
					if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchUp * self.Shots / 2 ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchUp / 2 ) )
						end
					end
					if self.Primary.StrenghtRecoil != nil and self.RecoilType == 0 then
						self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, -1 * self.Primary.StrenghtRecoil / 2, 0 ) )
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchRight * self.Shots, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchRight, 0 ) )
						end
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchUp / 2 * self.Shots, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchUp / 2, 0 ) )
						end
					end
					else
					if self.Primary.ViewPunchRoll != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchRoll * self.Shots ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchRoll ) )
						end
					end
					if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchUp * self.Shots / 2 ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchUp / 2 ) )
						end
					end
					if self.Primary.StrenghtRecoil != nil and self.RecoilType == 0 then
						self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, self.Primary.StrenghtRecoil / 2, 0 ) )
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchRight * self.Shots, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchRight, 0 ) )
						end
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchUp / 2 * self.Shots, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchUp / 2, 0 ) )
						end
					end
				end
				if self.Primary.StrenghtRecoil != nil and self.RecoilType == 0 then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.StrenghtRecoil, 0, 0 ) )
				end
				if self.Primary.ViewPunchUp != nil then
					if self.RecoilType == 2 then
						self.Owner:ViewPunch( Angle( -1 * self.Primary.ViewPunchUp * self.Shots, 0, 0 ) )
						else
						self.Owner:ViewPunch( Angle( -1 * self.Primary.ViewPunchUp, 0, 0 ) )
					end
				end
				else
				if self.WhenRoll == 1 then
					if self.Primary.ViewPunchRoll != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchRoll * self.Shots / 2 ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchRoll / 2 ) )
						end
					end
					if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchUp * self.Shots / 4 ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, -1 * self.Primary.ViewPunchUp / 4 ) )
						end
					end
					if self.Primary.StrenghtRecoil != nil and self.RecoilType == 0 then
						self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, -1 * self.Primary.StrenghtRecoil / 4, 0 ) )
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchRight * self.Shots / 2, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchRight / 2, 0 ) )
						end
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchUp / 3 * self.Shots, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, -1 * self.Primary.ViewPunchUp / 3, 0 ) )
						end
					end
					else
					if self.Primary.ViewPunchRoll != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchRoll * self.Shots / 2 ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchRoll / 2 ) )
						end
					end
					if self.Primary.ViewPunchRoll == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchUp * self.Shots / 3 ) )
							else
							self.Owner:ViewPunch( Angle( 0, 0, self.Primary.ViewPunchUp / 3 ) )
						end
					end
					if self.Primary.StrenghtRecoil != nil and self.RecoilType == 0 then
						self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0, self.Primary.StrenghtRecoil / 4, 0 ) )
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchRight * self.Shots / 2, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchRight / 2, 0 ) )
						end
					end
					if self.RecoilType != 2 and self.Primary.ViewPunchRight == nil and self.Primary.ViewPunchUp != nil then
						if self.RecoilType == 2 then
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchUp / 3 * self.Shots, 0 ) )
							else
							self.Owner:ViewPunch( Angle( 0, self.Primary.ViewPunchUp / 3, 0 ) )
						end
					end
				end
				if self.Primary.StrenghtRecoil != nil and self.RecoilType == 0 then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -0.5 * self.Primary.StrenghtRecoil, 0, 0 ) )
				end
				if self.Primary.ViewPunchUp != nil then
					if self.RecoilType == 2 then
						self.Owner:ViewPunch( Angle( -1 * self.Primary.ViewPunchUp * self.Shots / 2, 0, 0 ) )
						else
						self.Owner:ViewPunch( Angle( -1 * self.Primary.ViewPunchUp / 2, 0, 0 ) )
					end
				end
			end
		end
		if ( CLIENT || game.SinglePlayer() ) and self.RecoilType == 4 and self.Primary.ViewPunchRight != nil then
			if self.Iron == 0 then
				if self.Owner:KeyDown( IN_DUCK ) then
					self.Owner:ViewPunch( Angle( 0, math.Rand( 0.8 * self.Primary.ViewPunchRight, -0.8 * self.Primary.ViewPunchRight ), 0 ) )
					else
					self.Owner:ViewPunch( Angle( 0, math.Rand( self.Primary.ViewPunchRight, -1 * self.Primary.ViewPunchRight ), 0 ) )
				end
				else
				if self.Owner:KeyDown( IN_DUCK ) then
					self.Owner:ViewPunch( Angle( 0, math.Rand( 0.625 * self.Primary.ViewPunchRight, -0.625 * self.Primary.ViewPunchRight ), 0 ) )
					else
					self.Owner:ViewPunch( Angle( 0, math.Rand( 0.5 * self.Primary.ViewPunchRight, -0.5 * self.Primary.ViewPunchRight ), 0 ) )
				end
			end
		end
		if ( CLIENT || game.SinglePlayer() ) and self.RecoilType == 1 then
			self.RecoilStalkerTimer = CurTime() + self.CamRelaxSpeed
			if self.CamdDispersionInc != nil then
				self.RecoilStalker = self.RecoilStalker + self.CamdDispersion
				if self.RecoilStalker > 0 then
					self.RecoilStalker = self.RecoilStalker + self.CamdDispersionInc
				end
				else
				self.RecoilStalker = self.RecoilStalker + self.CamdDispersion
			end
			if self.CamStepAngleHorz != nil and self.RecoilStalker >= self.CamMaxAngle then
				if self.Iron == 0 then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( math.random( -1 * self.CamStepAngleHorz, self.CamStepAngleHorz ), math.random( -1 * self.CamStepAngleHorz, self.CamStepAngleHorz ), 0 ) )
					else
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( math.random( -1 * self.CamStepAngleHorz / 2, self.CamStepAngleHorz / 2 ), math.random( -1 * self.CamStepAngleHorz / 2, self.CamStepAngleHorz / 2 ), 0 ) )
				end
			end
			if self.RecoilStalker >= self.CamMaxAngle then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1.75, 0, 0 ) )
			end
			if self.RecoilStalker < self.CamMaxAngle then
				if self.Iron == 0 then
					if self.CamdDispersionF != nil and IsFirstTimePredicted() then
						self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.CamdDispersionF / 2, 0, 0 ) )
					end
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.RecoilStalker, 0, 0 ) )
					else
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.RecoilStalker / 2, 0, 0 ) )
					if self.CamdDispersionF != nil and IsFirstTimePredicted() then
						self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.CamdDispersionF / 2, 0, 0 ) )
					end
				end
			end
		end
		self.Reloading = 0
		self.ReloadingTimer = CurTime() + 0.15
		if ( CLIENT || game.SinglePlayer() ) and self.RecoilType == 2 then
			if self.Iron == 0 then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.StrenghtRecoil * self.Shots, 0, 0 ) )
				else
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.StrenghtRecoil * self.Shots / 2, 0, 0 ) )
			end
		end
		if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() and self.RecoilType == 3 then
			self.Recoil = 1
			self.RecoilTimer = CurTime() + 0.1
			self.RecoilDirection = math.Rand( -0.1, 0.1 )
		end
		if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() and self.RecoilType == 5 then
			if self.Recoil > self.Primary.StrenghtRecoil / 2 and self.Recoil < self.Primary.StrenghtRecoil then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( self.Recoil - self.Primary.StrenghtRecoil, 0, 0 ) )
				self.Recoil = self.Primary.StrenghtRecoil
			end
			if self.Recoil <= self.Primary.StrenghtRecoil / 2 then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( self.Primary.StrenghtRecoil / -2, 0, 0 ) )
				self.Recoil = self.Recoil + self.Primary.StrenghtRecoil / 2
			end
		end
		self:SpreadFuturePA()
	end
	if self.MuzzleAtt != nil and self.MuzzleEffect != nil then
		local FX = EffectData{}
		local fx = EffectData()
		fx:SetEntity( self.Weapon )
		fx:SetOrigin( self.Owner:GetShootPos() )
		fx:SetNormal( self.Owner:GetAimVector() )
		if ( !owner:IsNPC() ) then
			fx:SetAttachment( self:LookupAttachment( self.MuzzleAtt) )
			else
			fx:SetAttachment( self:LookupAttachment( "muzzle") )
		end
		if self.Iron == 1 and GetConVar( "tsb_hide_muzzleflash_while_aiming" ):GetInt() == 1 and self.ScopeTexture > 0 then
			util.Effect( "AR2Tracer", fx )
			else
			util.Effect( self.MuzzleEffect, fx )
		end
	end
	if self.Primary.FireMode != 1 then
		self:SetNextPrimaryFire( CurTime() + 60 / self.Primary.RPM )
		self:SetNextSecondaryFire( CurTime() + 60 / self.Primary.RPM )
		else
		if self.Burst == 0 then
			self:SetNextPrimaryFire( CurTime() + 60 / self.Primary.RPM * 8 )
			self:SetNextSecondaryFire( CurTime() + 60 / self.Primary.RPM * 8 )
			self.Burst = 1
			self.BurstTimer = CurTime() + 60 / self.Primary.RPM
		end
	end
end

function SWEP:SpreadFuturePA()
	if self.Iron == 0 then
		self.Primary.SpreadTimer = CurTime() + self.Primary.SpreadTimerNumber
		if self.Primary.RealSpread < self.Primary.Spread / 15 then
			if self.Owner:KeyDown( IN_DUCK ) then
				self.Primary.RealSpread = self.Primary.RealSpread + self.Primary.Spread / 330
				else
				self.Primary.RealSpread = self.Primary.RealSpread + self.Primary.Spread / 300
			end
		end
		else
		self.Primary.SpreadTimer = CurTime() + self.Primary.SpreadTimerNumber / 1.5
		if self.Primary.RealSpread < self.Primary.Spread / 25 then
			if self.Owner:KeyDown( IN_DUCK ) then
				self.Primary.RealSpread = self.Primary.RealSpread + self.Primary.Spread / 355
				else
				self.Primary.RealSpread = self.Primary.RealSpread + self.Primary.Spread / 340
			end
		end
	end
end

function SWEP:OverHeatPA()
	if self.HotActivity == 0 then
		self.Hot = self.Hot + 1
		self.HotTimer = CurTime() + 0.5
	end
	if self.Hot == math.Round( self.Primary.ClipSize * 1.5 ) and self.HotActivity == 0 then
		self.HotActivity = 1
		if SERVER then
			self:EmitOverheatSound()
		end
		self.Text = 1
		self.TextTimer = CurTime() + 2.5
		self.Weapon:SetNWInt( "text", "Your gun is overheated!" )
		if ( self.language:GetString() == "ru" ) then
			self.Weapon:SetNWInt( "text", "Пушка перегрелась!" )
		end
	end
end

function SWEP:JamPA()
	if self.Primary.Ammo == "pistol" then
		if self.Jam <= 0.725 and self.Weapon:Clip1() > 0 then
			if SERVER then
				self:EmitJamSound()
			end
			self.JamActive = 1
			self.Text = 1
			self.TextTimer = CurTime() + 2.5
			self.Weapon:SetNWInt( "text", "It's jammed! You need to reload your gun!" )
			if ( self.language:GetString() == "ru" ) then
				self.Weapon:SetNWInt( "text", "Заклинило! Нужна перезарядка!" )
			end
		end
	end
	if self.Primary.Ammo == "ar2" or self.Primary.Ammo == "smg1" then
		if self.Jam <= 0.795 and self.Weapon:Clip1() > 0 then
			if SERVER then
				self:EmitJamSound()
			end
			self.JamActive = 1
			self.Text = 1
			self.TextTimer = CurTime() + 2.5
			self.Weapon:SetNWInt( "text", "It's jammed! You need to reload your gun!" )
			if ( self.language:GetString() == "ru" ) then
				self.Weapon:SetNWInt( "text", "Заклинило! Нужна перезарядка!" )
			end
		end
	end
	if self.Primary.Ammo == "357" or self.Primary.Ammo == "SniperPenetratedRound" or self.Primary.Ammo == "XBowBolt" then
		if self.Jam <= 0.835 and self.Weapon:Clip1() > 0 then
			if SERVER then
				self:EmitJamSound()
			end
			self.JamActive = 1
			self.Text = 1
			self.TextTimer = CurTime() + 2.5
			self.Weapon:SetNWInt( "text", "It's jammed! You need to reload your gun!" )
			if ( self.language:GetString() == "ru" ) then
				self.Weapon:SetNWInt( "text", "Заклинило! Нужна перезарядка!" )
			end
		end
	end
	if self.Primary.Ammo == "buckshot" then
		if self.Jam <= 0.625 and self.Weapon:Clip1() > 0 then
			if SERVER then
				self:EmitJamSound()
			end
			self.JamActive = 1
			self.Text = 1
			self.TextTimer = CurTime() + 2.5
			self.Weapon:SetNWInt( "text", "It's jammed! You need to reload your gun!" )
			if ( self.language:GetString() == "ru" ) then
				self.Weapon:SetNWInt( "text", "Заклинило! Нужна перезарядка!" )
			end
		end
	end
	if self.Primary.Ammo != "pistol" and self.Primary.Ammo != "357" and self.Primary.Ammo != "SniperPenetratedRound" and self.Primary.Ammo != "XBowBolt" and self.Primary.Ammo != "buckshot" and self.Primary.Ammo != "ar2" and self.Primary.Ammo != "smg1" then
		if self.Jam <= 0.7125 and self.Weapon:Clip1() > 0 then
			if SERVER then
				self:EmitJamSound()
			end
			self.JamActive = 1
			self.Text = 1
			self.TextTimer = CurTime() + 2.5
			self.Weapon:SetNWInt( "text", "It's jammed! You need to reload your gun!" )
			if ( self.language:GetString() == "ru" ) then
				self.Weapon:SetNWInt( "text", "Заклинило! Нужна перезарядка!" )
			end
		end
	end
end

function SWEP:BulletTable( bullet )
end

function SWEP:CustomPrimaryA()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
end

function SWEP:EmitFireSound()
	if self.Primary.Sound != nil then
		self.Owner:EmitSound( self.Primary.Sound )
	end
end

function SWEP:EmitEmptySound()
	self.Owner:EmitSound( "TooSimpleBase.Empty" )
end

function SWEP:EmitOverheatSound()
	self.Owner:EmitSound( "TooSimpleBase.Hot" )
end

function SWEP:EmitJamSound()
	self.Owner:EmitSound( "TooSimpleBase.Jam" )
end

function SWEP:EmitLowAmmoSound()
	self.Owner:EmitSound( "TooSimpleBase.LowAmmo" )
end

function SWEP:EmitNoAmmoSound()
	self.Owner:EmitSound( "TooSimpleBase.LastAmmo" )
end

SWEP.MuzzleEffect = nil

function SWEP:CanPrimaryAttack()
	if SERVER and GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() <= 1 then 
		if self.Weapon:Clip1() <= 0 or self.Owner:WaterLevel() == 3 or self.ReloadingSeq > CurTime() then
			if SERVER then
				self:EmitEmptySound()
			end
			self:SetNextPrimaryFire( CurTime() + 1 )
			self:SetNextSecondaryFire( CurTime() + 1 )
			return false
		end
	end
	if self.Sprint == 1 then
		return false
	end
	if self.JamActive == 1 then
		self.Text = 1
		self.TextTimer = CurTime() + 2.5
		self.Weapon:SetNWInt( "text", "It's jammed! You need to reload your gun!" )
		if ( self.language:GetString() == "ru" ) then			
			self.Weapon:SetNWInt( "text", "Заклинило! Нужна перезарядка!" )
		end
		self.Owner:EmitSound( "TooSimpleBase.Alert" )
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:SetNextSecondaryFire( CurTime() + 1 )
		return false
	end
	if self.HotActivity == 1 then
		self.Text = 1
		self.TextTimer = CurTime() + 2.5
		self.Weapon:SetNWInt( "text", "Your gun is overheated!" )
		if ( self.language:GetString() == "ru" ) then
			self.Weapon:SetNWInt( "text", "Пушка перегрелась!" )
		end
		if SERVER then
			self:EmitOverheatSound()
		end
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:SetNextSecondaryFire( CurTime() + 1 )
		return false
	end
	if ( self.Owner:IsNPC() ) and self.Weapon:Clip1() <= 0 then
		if SERVER then
			self.Owner:SetSchedule( SCHED_RELOAD )
		end
		return false
	end
	if self.ReloadShot > 0 and self.ReloadShotTimer > CurTime() then
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
		self:ShotRelDisable()
		return false
	end
	return true
end

SWEP.m_WeaponDeploySpeed = 1
SWEP.Reloading = 0
SWEP.ReloadingTimer = CurTime()
SWEP.ReloadingSeq = CurTime()
SWEP.ReloadingTime = nil

function SWEP:Reload()
	if !self:CanReload() then return end
	self.Owner:SetAnimation( PLAYER_RELOAD )
	self.Primary.SpreadTimer = CurTime()
	if self.Sprint == 0 then
		self:IronDisabler()
	end
	self.Owner:SetFOV( 0, 0.1 )
	self.JamActive = 0
	self.RecoilStalker = 0
	self.RecoilStalkerTimer = CurTime()
	if self.HotActivity != 1 then
		self.Text = 0
		self.TextTimer = CurTime()
		self.Weapon:SetNWInt( "text", "" )
	end
	if self.ShotgunReload == false then
		self:CustomReload()
		if self.ReloadSound != nil then
			self:EmitSound( self.ReloadSound )
		end
		local owner = self:GetOwner()
		if (!owner:IsNPC()) then
			self.Idle = 0
			self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self.ReloadingSeq = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
			self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
			self.Reloading = 1
			if GetConVar( "tsb_force_disable_reload_timer" ):GetFloat() == 0 then
				if self.ReloadingTime == nil then
					if self.ReloadingSeq > CurTime() + 0.2 then
						self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration() - 0.2
						else
						self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
					end
					else
					self.ReloadingTimer = CurTime() + self.ReloadingTime
				end
				else
				if self.ReloadingSeq > CurTime() + 0.2 then
					self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration() - 0.2
					else
					self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
				end
			end
		end
		else
		self.Idle = 2
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
		self.Owner:SetAnimation( PLAYER_RELOAD )
		local owner = self:GetOwner()
		if (!owner:IsNPC()) then
			self.ReloadShot = 1
			self.ReloadShotTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
			self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
			self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		end
	end
end

function SWEP:CanReload()
	if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() <= 1 then
		if self.Weapon:Clip1() == self.Primary.ClipSize then
			return false
		end
		if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() == 0 and self.Weapon:Ammo1() <= 0 then
			return false
		end
	end
	if self.UseFireMode == 1 or self.Reloading == 1 or self.ReloadingTimer > CurTime() or self.ReloadShot == 1 or self.ReloadShotTimer > CurTime() or GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() == 2 then
		return false
	end
	return true
end

function SWEP:Finish()
	if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() == 0 then
		if self.Weapon:Ammo1() > ( self.Primary.ClipSize - self.Weapon:Clip1() ) then
			self.Owner:SetAmmo( self.Weapon:Ammo1() - self.Primary.ClipSize + self.Weapon:Clip1(), self.Primary.Ammo )
			self.Weapon:SetClip1( self.Primary.ClipSize )
		end
		if ( self.Weapon:Ammo1() - self.Primary.ClipSize + self.Weapon:Clip1() ) + self.Weapon:Clip1() < self.Primary.ClipSize then
			self.Weapon:SetClip1( self.Weapon:Clip1() + self.Weapon:Ammo1() )
			self.Owner:SetAmmo( 0, self.Primary.Ammo )
		end
		else
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end
	self.Reloading = 0
end

SWEP.ReloadShot = 0
SWEP.ReloadShotTimer = CurTime()
SWEP.ShotgunReload = false
local disableDynamCross = GetConVar( "tsb_c_dynam_disable" ):GetInt()

function SWEP:ShotRelDisable()
	self.ReloadShot = 0
	self.ReloadShotTimer = CurTime()
	self.Primary.SpreadTimer = CurTime()
	self.Idle = 0
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	end
end

function SWEP:ShotRel()
	if self.ReloadSound != nil then
		self:EmitSound( self.ReloadSound )
	end
	self:CustomReload()
	self.Idle = 2
	self.ReloadShot = 2
	self.ReloadShotTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self:SetNextPrimaryFire( CurTime() + 0.1 )
	self:SetNextSecondaryFire( CurTime() + 0.1 )
	self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
	if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() == 0 then
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
	end
end

function SWEP:CustomReload()
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
end

function SWEP:CustomThink()
end

function SWEP:Think()
	self:CustomThink()
	local owner = self:GetOwner()
	if ( owner:IsPlayer() ) then
		self:Bobbing()
		if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() and self.RecoilType == 5 then
			if self.Recoil < 0 then
				self.Recoil = 0
			end
			if self.Recoil > 0 then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0.25, 0, 0 ) )
				self.Recoil = self.Recoil - 0.25
			end
		end
		if self.BurstTimer <= CurTime() and self.Primary.FireMode == 1 then
			if self.Burst == 1 then
				if self.Weapon:Clip1() > 0 then
					self:PrimaryAttack()
				end
				self.Burst = 2
				self.BurstTimer = CurTime() + 60 / self.Primary.RPM
				else
				if self.Burst == 2 then
					if self.Weapon:Clip1() > 0 then
						self:PrimaryAttack()
					end
					self.Burst = 0
					self.BurstTimer = CurTime()
				end
			end
		end
		if ( CLIENT || game.SinglePlayer() ) and IsFirstTimePredicted() and self.RecoilType == 3 then
			if self.Recoil == 1 then
				if self.Iron == 0 then
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -1 * self.Primary.StrenghtRecoil, self.RecoilDirection, 0 ) )
					else
					self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( -0.5 * self.Primary.StrenghtRecoil, self.RecoilDirection, 0 ) )
				end
			end
			if self.Recoil == 1 and self.RecoilTimer <= CurTime() then
				self.Recoil = 0
			end
		end
		if ( CLIENT || game.SinglePlayer() ) and self.RecoilType == 1 then
			if self.RecoilStalker >= self.CamMaxAngle and IsFirstTimePredicted() then
				self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0.25, 0, 0 ) )
			end
			if self.RecoilStalkerTimer <= CurTime() then
				self.RecoilStalker = 0
			end
		end
		self:ReloadBase()
		self:SpreadFuture()
		if self.IdleTimer <= CurTime() then
			self:IdleAnim()
		end
		if SERVER and GetConVar( "tsb_force_disable_crosshair" ):GetFloat() == 0 then
			self:CrosshairThink()
		end
		self.BobScale = self.Weapon:GetNWString( "BobSway", 0.5 )
		self.SwayScale = self.Weapon:GetNWString( "BobSway", 0.5 )
		if self.Owner:KeyDown( IN_USE ) and self.Owner:KeyPressed( IN_RELOAD ) and self.SwitchTo != nil then
			self.UseFireMode = 1
			self:FireMode()
		end
		if GetConVar( "tsb_disable_text" ):GetInt() == 1 then
			if self.TextTimer <= CurTime() then
				self.Weapon:SetNWInt( "text", "" )
				else
				self.Weapon:SetNWInt( "text", "" )
			end
			else
			if self.TextTimer <= CurTime() and self.Text == 1 then
				self.Weapon:SetNWInt( "text", "" )
				self.Text = 0
			end
		end
		self:CrouchPos()
		self:OverHeatSimple()
	end
	if self.Primary.FireMode <= 1 then
		self.Primary.Automatic = self.Weapon:GetNWString( "Automatic", false )
		else
		self.Primary.Automatic = self.Weapon:GetNWString( "Automatic", true )
	end
	self:IronRelated()
	self:SprintRelated()
	self:DynamicHoldType()
	if self.ShotsTimer <= CurTime() and self.Shots > 0 then
		self.Shots = 0
		if self.Weapon:Clip1() == 0 and self.Weapon:Ammo1() > 0 and (!owner:IsNPC()) and self.ShotsTimer <= CurTime() and GetConVar( "tsb_enable_auto_reload" ):GetInt() == 1 and GetConVar( "tsb_force_disable_auto_reload" ):GetFloat() == 0 then
			self:Reload()
		end
	end
	if GetConVar( "tsb_force_disable_viewpunchroll" ):GetInt() == 1 then
		self.Primary.ViewPunchRoll = 0
	end
end

function SWEP:SpreadFuture()
	if self.Owner:IsOnGround() then
		if self.Iron == 0 then
			if self.Owner:GetVelocity():Length() <= 100 then
				if self.Primary.SpreadTimer <= CurTime() then
					if self.Owner:KeyDown( IN_DUCK ) then
						if self.Primary.Ammo != "buckshot" then
							self.Primary.RealSpread = self.Primary.Spread / 125
						end
						else
						self.Primary.RealSpread = self.Primary.Spread / 100
					end
				end
			end
			if self.Owner:GetVelocity():Length() > 100 and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) and self.Primary.SpreadTimer <= CurTime() then
				if self.Owner:KeyDown( IN_DUCK ) then
					self.Primary.RealSpread = self.Primary.Spread / 65
					else
					self.Primary.RealSpread = self.Primary.Spread / 50
				end
			end
			if !self.Owner:KeyDown( IN_DUCK ) and self.Owner:GetVelocity():Length() > 100 and self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) and self.Primary.SpreadTimer <= CurTime() then
				self.Primary.RealSpread = self.Primary.Spread / 25
			end
			if self.Owner:GetVelocity():Length() <= 100 and self.Primary.RealSpread >= self.Primary.Spread / 15 then
				self.Primary.RealSpread = self.Primary.Spread / 15
			end
			else
			if self.Owner:GetVelocity():Length() <= 100 then
				if self.Primary.SpreadTimer <= CurTime() then
					if self.Owner:KeyDown( IN_DUCK ) then
						self.Primary.RealSpread = self.Primary.Spread / 150
						else
						self.Primary.RealSpread = self.Primary.Spread / 125
					end
				end
			end
			if self.Owner:GetVelocity():Length() > 100 and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) and self.Primary.SpreadTimer <= CurTime() then
				if self.Owner:KeyDown( IN_DUCK ) then
					self.Primary.RealSpread = self.Primary.Spread / 75
					else
					self.Primary.RealSpread = self.Primary.Spread / 60
				end
			end
			if !self.Owner:KeyDown( IN_DUCK ) and self.Owner:GetVelocity():Length() > 100 and self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) and self.Primary.SpreadTimer <= CurTime() then
				self.Primary.RealSpread = self.Primary.Spread / 45
			end
			if self.Owner:GetVelocity():Length() <= 100 and self.Primary.RealSpread >= self.Primary.Spread / 25 then
				self.Primary.RealSpread = self.Primary.Spread / 25
			end
		end
		else
		if self.Primary.Ammo == "buckshot" then
			self.Primary.RealSpread = self.Primary.Spread / 25
			else
			self.Primary.RealSpread = self.Primary.Spread / 15
		end
		self.Primary.SpreadTimer = CurTime() + 0.1
	end
end

function SWEP:CrouchPos()
	if self.Sprint == 0 and self.Reloading == 0 and self.ReloadShot == 0 and self.Iron == 0 then
		if self.Owner:KeyDown( IN_DUCK ) then
			if self.ViewModelFlip == false then
				self.Pos = self.WalkPos
				self.Ang = self.WalkAng
				else
				self.Pos = self.WalkPosMirrored
				self.Ang = self.WalkAngMirrored
			end
			self:SetRun( true, self.Owner )
		end
		if self.Owner:KeyReleased( IN_DUCK ) then
			self:SetRun( false, self.Owner )
		end
	end
end

function SWEP:ReloadBase()
	if self.ReloadShot == 1 and self.ReloadShotTimer <= CurTime() then
		self:ShotRel()
	end
	if self.ReloadShot == 2 and self.ReloadShotTimer <= CurTime() and self.Weapon:Clip1() < self.Primary.ClipSize then
		if self.Weapon:Ammo1() > 0 then
			self:ShotRel()
			else
			if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() != 0 then
				self:ShotRel()
			end
		end
	end
	if self.ReloadShot > 0 and self.ReloadShotTimer <= CurTime() then
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
		if self.Weapon:Clip1() == self.Primary.ClipSize then
			self:ShotRelDisable()
		end
		if self.Weapon:Clip1() < self.Primary.ClipSize then
			if self.Weapon:Ammo1() <= 0 then
				self:ShotRelDisable()
				else
				if GetConVar( "tsb_enable_infinity_clipsize" ):GetFloat() != 0 then
					self:ShotRel()
				end
			end
		end
	end
	if self.Reloading == 1 and self.ReloadingTimer <= CurTime() then
		self:Finish()
	end
end

function SWEP:OverHeatSimple()
	if self.HotTimer <= CurTime() and self.Hot >= 1 and self.HotActivity == 0 then
		self.Hot = self.Hot - 1
		self.HotTimer = CurTime() + 0.5
	end
	if self.HotTimer <= CurTime() and self.Hot >= 1 and self.HotActivity == 1 then
		self.Hot = self.Hot - 1
		self.HotTimer = CurTime() + 0.25
	end
	if self.HotTimer <= CurTime() and self.Hot <= 0 then
		self.Hot = 0
		self.HotActivity = 0
		self.HotTimer = CurTime()
	end
end

function SWEP:IronRelated()
	if self.IronSightsPos != nil and self.IronSightsAng != nil and self.Sprint == 0 and self.Reloading == 0 and self.ReloadShot == 0 and GetConVar( "tsb_force_disable_iron_sights" ):GetFloat() == 0 then
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
			self.Weapon:SetNWString( "MouseSensitivity", 1 / ( self.IronFOVMult + 1.25 ) )
			self.Owner:SetFOV( self.Owner:GetFOV() / self.IronFOVMult, self.IronTime / 2 )
			self.Weapon:SetNWString( "BobSway", 0.1 )
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
			if self.ScopeTexture == 5 then
				self.Weapon:SetNWString( "aimpoint", 1 )
			end
		end
		if self.IronIn == 2 and self.IronTimer <= CurTime() then
			if self.ScopeTexture > 0 and self.Reloading == 0 and self.ReloadShot == 0 then
				self.Owner:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), self.IronTime / 2, self.IronTime / 2 )
			end
			self:IronDisabler()
		end
	end
end

function SWEP:SprintRelated()
	if self.RunPos != nil and self.RunAng != nil and GetConVar( "tsb_force_shoot_while_running" ):GetFloat() == 0 then
		if self.Sprint == 0 and self.Owner:IsOnGround() and self.Owner:GetVelocity():Length() >= 100 and self.Owner:KeyDown( IN_SPEED ) and ( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) then
			self.Sprint = 1
			self.Pos = self.RunPos
			self.Ang = self.RunAng
			self:SetRun( true, self.Owner )
			self.Weapon:SetNWString( "BobSway", 1.5 )
		end
		if self.Sprint == 1 and ( !self.Owner:IsOnGround() || self.Owner:GetVelocity():Length() < 100 || !self.Owner:KeyDown( IN_SPEED ) || !( self.Owner:KeyDown( IN_FORWARD ) || self.Owner:KeyDown( IN_BACK ) || self.Owner:KeyDown( IN_MOVELEFT ) || self.Owner:KeyDown( IN_MOVERIGHT ) ) ) then
			self.Sprint = 0
			self.Pos = self.RunPos
			self.Ang = self.RunAng
			self:SetRun( false, self.Owner )
			self:SetNextPrimaryFire( CurTime() + 0.35 )
			self:SetNextSecondaryFire( CurTime() + 0.35 )
			self.Weapon:SetNWString( "BobSway", 0.5 )
		end
		if self.Iron == 1 and self.Sprint == 1 then
			self.Iron = 0
			self:IronDisabler()
			self.Pos = self.RunPos
			self.Ang = self.RunAng
			self:SetRun( true, self.Owner )
			self.Owner:SetFOV( 0, 0.1 )
			self.Weapon:SetNWString( "BobSway", 1.5 )
		end
		if self.Sprint == 1 and self.Iron == 0 then
			local sprintHoldPistol = "normal"
			local sprintHoldRifle = "passive"
			if self.HoldType == "revolver" or self.HoldType == "pistol" then
				self:SetWeaponHoldType( sprintHoldPistol )
				else
				self:SetWeaponHoldType( sprintHoldRifle )
			end
		end
	end
end

function SWEP:DynamicHoldType()
	if self.Sprint == 0 and self.Iron == 0 then
		self:SetWeaponHoldType( self.HoldType )
	end
	if self.Iron == 1 and self.Sprint == 0 then
		local aimPistol = "revolver"
		local aimRifle = "rpg"
		if self.HoldType == "revolver" or self.HoldType == "pistol" then
			self:SetWeaponHoldType( aimPistol )
			else
			self:SetWeaponHoldType( aimRifle )
		end
	end
end

function SWEP:CrosshairThink()
	if disableDynamCross == 0 then
		self.Weapon:SetNWString( "Crosshair1", ( ( self.Primary.RealSpread + self.Primary.Spread / 25 ) / ( self.Primary.Spread / 25 ) * GetConVar( "tsb_c_gap" ):GetInt() * GetConVar( "tsb_spread_multi" ):GetFloat() ) )
		self.Weapon:SetNWString( "Crosshair2", ( ( self.Primary.RealSpread + self.Primary.Spread / 25 ) / ( self.Primary.Spread / 25 ) * GetConVar( "tsb_c_gap" ):GetInt() * GetConVar( "tsb_spread_multi" ):GetFloat() - GetConVar( "tsb_c_length" ):GetInt() ) )
		else
		self.Weapon:SetNWString( "Crosshair1", ( 1 * GetConVar( "tsb_c_gap" ):GetInt() * GetConVar( "tsb_spread_multi" ):GetFloat():GetFloat() ) )
		self.Weapon:SetNWString( "Crosshair2", ( 1 * GetConVar( "tsb_c_gap" ):GetInt() * GetConVar( "tsb_spread_multi" ):GetFloat():GetFloat() - GetConVar( "tsb_c_length" ):GetInt() ) )
	end
	if self.Reloading == 1 or self.ReloadShot >= 1 or self.Iron == 1 or self.Sprint == 1 or self.DrawCrosshair == true then
		self.Weapon:SetNWString( "Crosshair1", 0 )
		self.Weapon:SetNWString( "Crosshair2", 0 )
	end
end

function SWEP:Bobbing()
	if self.Owner:IsOnGround() then
		if self.BobX >= -90 and self.BobDirectionX == 0 then
			if self.Sprint == 0 then
				self.BobX = self.BobX - FrameTime() * ( self.Owner:GetVelocity():Length() / 200 ) * 4 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
			if self.Sprint == 1 then
				self.BobX = self.BobX - FrameTime() * ( self.Owner:GetVelocity():Length() / 400 ) * 5 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
		end
		if self.BobX < -90 then
			self.BobDirectionX = 1
		end
		if self.BobX <= 90 and self.BobDirectionX == 1 then
			if self.Sprint == 0 then
				self.BobX = self.BobX + FrameTime() * ( self.Owner:GetVelocity():Length() / 200 ) * 4 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
			if self.Sprint == 1 then
				self.BobX = self.BobX + FrameTime() * ( self.Owner:GetVelocity():Length() / 400 ) * 5 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
		end
		if self.BobX > 90 then
			self.BobDirectionX = 0
		end
		if self.BobY >= -45 and self.BobDirectionY == 0 then
			if self.Sprint == 0 then
				self.BobY = self.BobY - FrameTime() * ( self.Owner:GetVelocity():Length() / 200 ) * 8 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
			if self.Sprint == 1 then
				self.BobY = self.BobY - FrameTime() * ( self.Owner:GetVelocity():Length() / 400 ) * 10 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
		end
		if self.BobY < -45 then
			self.BobDirectionY = 1
		end
		if self.BobY <= 45 and self.BobDirectionY == 1 then
			if self.Sprint == 0 then
				self.BobY = self.BobY + FrameTime() * ( self.Owner:GetVelocity():Length() / 200 ) * 8 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
			if self.Sprint == 1 then
				self.BobY = self.BobY + FrameTime() * ( self.Owner:GetVelocity():Length() / 400 ) * 10 * GetConVar( "tsb_vm_bob" ):GetInt()
			end
		end
		if self.BobY > 45 then
			self.BobDirectionY = 0
		end
	end
end

function SWEP:IdleAnim()
	if self.Idle == 0 then
		self.Idle = 1
	end
	if SERVER and self.Idle == 1 then
		self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
	end
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

SWEP.SwitchTo = nil

function SWEP:FireMode()
	if self.SwitchTo == nil or self.Reloading == 1 then return end
	if SERVER then
		timer.Simple(0.25, function() self.UseFireMode = 0 end)
		self.Owner:EmitSound( "TooSimpleBase.FireMode" )
	end
	if GetConVar( "tsb_disable_text" ):GetInt() == 0 then
		self.Text = 1
		self.TextTimer = CurTime() + 1.5
	end
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
SWEP.Text = 0
SWEP.TextTimer = CurTime()
SWEP.UseFireMode = 0
SWEP.Sprint = 0
SWEP.RunPos = nil
SWEP.RunAng = nil
SWEP.ScopeTexture = 0
SWEP.Iron = 0
SWEP.IronTimer = CurTime()
SWEP.IronTime = 0.15
SWEP.IronFOVMult = 1.3

function SWEP:IronDisabler()
	self.IronIn = 0
	self.Iron = 0
	self.IronTimer = CurTime()
	self.Weapon:SetNWString( "BobSway", 0.5 )
	self.Weapon:SetNWString( "MouseSensitivity", 1 )
	self.Pos = self.IronSightsPos
	self.Ang = self.IronSightsAng
	self:SetRun( false, self.Owner )
	self.Weapon:SetNWString( "eotech_sight", 0 )
	self.Weapon:SetNWString( "typical_scope", 0 )
	self.Weapon:SetNWString( "scope_math", 0 )
	self.Weapon:SetNWString( "gdcw_acog", 0 )
	self.Weapon:SetNWString( "aimpoint", 0 )
end

function SWEP:DrawHUD()
	local owner = self:GetOwner()
	if CLIENT and (!owner:IsNPC()) then
		if GetConVar( "tsb_disable_text" ):GetInt() == 0 then
			draw.SimpleText( self.Weapon:GetNWInt( "text", "" ), "CloseCaption_Bold", ScrW() * 0.5, ScrH() * 0.35, Color( GetConVar( "tsb_c_red" ):GetInt(), GetConVar( "tsb_c_green" ):GetInt(), GetConVar( "tsb_c_blue" ):GetInt(), GetConVar( "tsb_c_alpha" ):GetInt() ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
			draw.SimpleText( self.Weapon:GetNWInt( "text", "" ), "CloseCaption_Bold", ScrW() * 0.5, ScrH() * 0.35, Color( GetConVar( "tsb_c_red" ):GetInt(), GetConVar( "tsb_c_green" ):GetInt(), GetConVar( "tsb_c_blue" ):GetInt(), 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("eotech_sight",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_dirty" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_eotech2" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("typical_scope",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_dirty2" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_default" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("scope_math",0))
		surface.SetTexture( surface.GetTextureID( "scope/scope_lens" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope_math" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
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
		surface.SetDrawColor(255,255,255,self.Weapon:GetNWString("aimpoint",0))
		surface.SetTexture( surface.GetTextureID( "scope/aimpoint_dirty" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() ) / 2, 0, ScrH(), ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/aimpoint" ) )
		surface.DrawTexturedRect( ScrW() / 2 - ScrH() / 64, ScrH() * 31 / 64, ScrH() / 32, ScrH() / 32 )
		surface.SetTexture( surface.GetTextureID( "scope/scope_arc" ) )
		surface.DrawTexturedRect( ( ScrW() - ScrH() * 1 ) / 2, 0, ScrH() * 1, ScrH() )
		surface.SetTexture( surface.GetTextureID( "scope/scope1" ) )
		surface.DrawTexturedRect( 0, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
		surface.DrawTexturedRect( ScrH() + ( ScrW() - ScrH() * 1 ) / 2, 0, ( ScrW() - ScrH() * 1 ) / 2, ScrH() )
        local x = ScrW() / 2
        local y = ScrH() / 2
		local punch = owner:GetViewPunchAngles() * GetConVar( "tsb_crosshair_and_recoil_scale" ):GetInt()
        x = x + punch.y * 10
        y = y + punch.p * 10
		surface.SetDrawColor( GetConVar( "tsb_c_red" ):GetInt(), GetConVar( "tsb_c_green" ):GetInt(), GetConVar( "tsb_c_blue" ):GetInt(), GetConVar( "tsb_c_alpha" ):GetInt() )
		surface.DrawLine( x - self.Weapon:GetNWString( "Crosshair1", 0 ), y, x - self.Weapon:GetNWString( "Crosshair2", 0 ), y )
		surface.DrawLine( x + self.Weapon:GetNWString( "Crosshair1", 0 ), y, x + self.Weapon:GetNWString( "Crosshair2", 0 ), y )
		surface.DrawLine( x, y - self.Weapon:GetNWString( "Crosshair1", 0 ), x, y - self.Weapon:GetNWString( "Crosshair2", 0 ) )
		surface.DrawLine( x, y + self.Weapon:GetNWString( "Crosshair1", 0 ), x, y + self.Weapon:GetNWString( "Crosshair2", 0 ) )
	end
end

function SWEP:AdjustMouseSensitivity()
	return self.Weapon:GetNWString( "MouseSensitivity", 1 )
end

function SWEP:Equip()
	self:SetRun( false, self.Owner )
	if self.Weapon:Clip1() > self.Primary.ClipSize then
		self.Weapon:SetClip1( self.Primary.ClipSize )
	end
end

function SWEP:Initialize()
	self.Reloading = 0
	self.ReloadingTimer = CurTime()
	self.UseFireMode = 0
	if CLIENT then
		self.WElements = table.FullCopy( self.WElements )
		self:CreateModels(self.WElements)
		self.VElements = table.FullCopy( self.VElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
		self:CreateModels(self.VElements)
	end
	local owner = self:GetOwner()
	if (!owner:IsNPC()) then
		self:SetWeaponHoldType( self.HoldType )
		if self.SwitchTo == nil or GetConVar( "tsb_disable_text" ):GetInt() == 1 then
			self.Weapon:SetNWInt( "text", "" )
			else
			self.Text = 1
			self.TextTimer = CurTime() + 2.5
			self.Weapon:SetNWInt( "text", "E+R - To change the fire mode" )
			if ( self.language:GetString() == "ru" ) then
				self.Weapon:SetNWInt( "text", "E+R - Чтобы переключть режим огня" )
			end
		end
		self.Idle = 0
		self.IdleTimer = CurTime() + 0.5
		self:IronDisabler()
		if CLIENT then
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
		else
		local ar2Hold = "ar2"
		if self.HoldType == "crossbow" or self.HoldType == "rpg" or ( self.HoldType == "shotgun" and self.Primary.Ammo != "buckshot" ) then
			self:SetWeaponHoldType( ar2Hold )
			else
			self:SetWeaponHoldType( self.HoldType )
		end
	end
end

function SWEP:Deploy()
	if ( self.Owner:IsPlayer() ) then
		self:IronDisabler()
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		self.Idle = 0
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.Owner:ViewPunchReset()
		self.Reloading = 0
		self.ReloadingTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self:SetWeaponHoldType( self.HoldType )
		else
		local ar2Hold = "ar2"
		if self.HoldType == "crossbow" or self.HoldType == "rpg" or ( self.HoldType == "shotgun" and self.Primary.Ammo != "buckshot" ) then
			self:SetWeaponHoldType( ar2Hold )
			else
			self:SetWeaponHoldType( self.HoldType )
		end
		self.Weapon:SetNWInt( "text", "" )
	end
	self:Draw()
	if self.DrawSound != nil then
		self.Owner:EmitSound( self.DrawSound )
	end
end

function SWEP:Draw()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
end

function SWEP:Holster( wep )
	self.Primary.SpreadTimer = CurTime()
	self.Idle = 0
	self.IdleTimer = CurTime()
	self.Reloading = 0
	self.ReloadingTimer = CurTime()
	self:ShotRelDisable()
	self.Sprint = 0
	self.RecoilStalker = 0
	self.RecoilStalkerTimer = CurTime()
	if  (self.Owner:IsPlayer() ) then
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
	self:CustomHolster()
	self.BobX = 0
	self.BobDirectionX = 0
	self.BobY = 0
	self.BobDirectionY = 0
	return true
end

function SWEP:CustomHolster()
end

function SWEP:OnRemove()
	if CLIENT and IsValid(self.Owner) and (self.Owner:IsPlayer()) then
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
	if self.BulletImpactName == nil or self.BulletImpactName == "" then return end
	if ( tr.HitSky ) then return end
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )
	util.Effect( self.BulletImpactName, effectdata )
end

SWEP.IronSightsPos = nil
SWEP.IronSightsAng = nil
SWEP.Pos = Vector( 0, 0, 0 )
SWEP.Ang = Vector( 0, 0, 0 )
SWEP.WalkPos = Vector(-0.75, -2, -1)
SWEP.WalkAng = Vector(0, 0, 0)
SWEP.WalkPosMirrored = Vector( 0.75, -2, -1 )
SWEP.WalkAngMirrored = Vector(0, 0, 0)
SWEP.CustomPos = Vector( 0, 0, 0 )

function SWEP:CalcView( ply, pos, ang, fov )
	if self.MuzzleAtt == nil then return end
	local owner = self:GetOwner()
	local attachment = self.Owner:GetViewModel():GetAttachment( self.Owner:GetViewModel():LookupAttachment( self.MuzzleAtt ) )
	if owner:IsPlayer() and CLIENT then
		ang = ang + Angle( owner:GetViewModel():WorldToLocalAngles( attachment.Ang ).x, owner:GetViewModel():WorldToLocalAngles( attachment.Ang ).y, owner:GetViewModel():WorldToLocalAngles( attachment.Ang ).z ) / 20 * GetConVar( "tsb_bobbing" ):GetInt()
		return pos, ang
	end
end

local RunSpeed = 0.25

function SWEP:GetViewModelPosition( pos, ang )
	local owner = self:GetOwner()
	if CLIENT and ( !owner:IsNPC() ) and IsValid( owner ) then
		if self.Owner:IsOnGround() and self.Iron == 0 then
			if !self.Owner:KeyDown( IN_ATTACK2 ) and self.Sprint == 0 then
				if self.Owner:GetVelocity():Length() < 250 then
					pos = pos + ( ang:Right() * math.sin( self.BobX ) * 0.125 + ang:Up() * math.sin( self.BobY ) * 0.125 ) * self.Owner:GetVelocity():Length() / 200
				end
				if self.Owner:GetVelocity():Length() >= 250 then
					pos = pos + ang:Right() * math.sin( self.BobX ) * 0.125 + ang:Up() * math.cos( self.BobY ) * 0.125
				end
			end
			if self.Owner:GetVelocity():Length() < 250 then
				pos = pos - ang:Up() * self.Owner:GetVelocity():Length() / 200 - ang:Right() * self.Owner:GetVelocity():Length() / 400
			end
			if self.Owner:GetVelocity():Length() >= 250 then
				pos = pos - ang:Up() - ang:Right()
			end
		end
		pos = pos + ang:Forward() * GetConVar( "tsb_vm_y" ):GetInt() + ang:Right() * GetConVar( "tsb_vm_x" ):GetInt() + ang:Up() * GetConVar( "tsb_vm_z" ):GetInt()
		local const = math.pi / 360
		local fov, vmfov = owner:GetFOV(), self.ViewModelFOV
		local ratio = math.tan( math.min( fov, vmfov ) * const) / math.tan( math.max( fov, vmfov ) * const )
		if self.Iron != 1 then
			pos = pos + self.Owner:EyeAngles():Up() * self.Owner:GetViewPunchAngles().x * GetConVar( "tsb_vm_recoil_pos" ):GetInt() * -1
			ang = ang + owner:GetViewPunchAngles() * ratio * GetConVar( "tsb_vm_recoil_ang" ):GetInt()
		end
		pos = pos + ang:Forward() * self.CustomPos.y + ang:Right() * self.CustomPos.x + ang:Up() * self.CustomPos.z
		if ( not self.Pos ) then return pos, ang end
		local Mul = 1.0
		local bSprint = self.Weapon:GetNWBool("Iron")
		local Offset = self.Pos
		if ( bSprint != self.bLastRun ) then
			self.bLastRun = bSprint
			self.fRunSpeed = CurTime()
		end
		local fRunSpeed = self.fRunSpeed or 0
		if ( not bSprint and fRunSpeed < CurTime() - RunSpeed ) then
			return pos, ang
		end
		local Mul = 1.0
		if ( fRunSpeed > CurTime() - RunSpeed ) then
			Mul = math.Clamp( ( CurTime() - fRunSpeed ) / RunSpeed, 0, 1 )
			if not bSprint then Mul = 1 - Mul end
		end
		if ( self.Ang ) then
			ang = ang * 1    
			ang:RotateAroundAxis( ang:Right(), 	self.Ang.x * Mul )
			ang:RotateAroundAxis( ang:Up(), 		self.Ang.y * Mul )
			ang:RotateAroundAxis( ang:Forward(),   self.Ang.z * Mul )
		end
		local Right 	= ang:Right()
		local Up 		= ang:Up()
		local Forward 	= ang:Forward()
		pos = pos + Offset.x * Right * Mul
		pos = pos + Offset.y * Forward * Mul
		pos = pos + Offset.z * Up * Mul
		return pos, ang
	end
end

function SWEP:SetRun( b )
	self.Weapon:SetNWBool( "Iron", b )
end
 
function SWEP:GetRun()
	return self.Weapon:GetNWBool( "Iron" )
end

SWEP.MuzzleAtt = nil

function SWEP:SecondaryAttack()
end

function SWEP:CanSecondary()
	return true
end

function SWEP:FireAnimationEvent( pos, ang, event, options )
	if self.MuzzleAtt != nil and self.MuzzleEffect != nil then
		if ( event == 21 ) then return true end
		if ( event == 5001 or event == 5011 or event == 5021 or event == 5031 ) then return true end
	end
end