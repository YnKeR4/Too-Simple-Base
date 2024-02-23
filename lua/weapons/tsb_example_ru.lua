AddCSLuaFile()

DEFINE_BASECLASS("too_simple_base")

SWEP.Base 						= "too_simple_base"	-- не совсем :D

-----------------------
-->> ПОДДЕРЖКА SCK <<--
-----------------------

SWEP.ViewModelBoneMods 			= {
	["ValveBiped.Gun"] = { scale = Vector(1.1, 1.1, 1.1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Pump"] = { scale = Vector(1, 0.904, 1.052), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements 					= {
	["bruh"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0.699, -1.101, -16.105), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements 					= {
	["element_name"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.752, 2, -5.715), angle = Angle(-7, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

----------------------
-->> ВАЖНАЯ ФИГНЯ <<--
----------------------

SWEP.PrintName 					= "SPASAI-12"
SWEP.Category 					= "TSB Example"
SWEP.Slot 						= 3
SWEP.Spawnable 					= true	-- её могут спаунить обычные люди (по умолчанию false)
SWEP.AdminSpawnable 			= true	-- её могут спаунить админы (по умолчанию false)

SWEP.AutoSwitchTo 				= true	-- ты можешь удалить это
SWEP.AutoSwitchFrom 			= true	-- ты можешь удалить это

SWEP.HoldType 					= "shotgun"	-- pistol, revolver, smg, ar2, shotgun, rpg
-- https://wiki.facepunch.com/gmod/Hold_Types

SWEP.DrawCrosshair 				= false	-- false - чтобы использовать динмаический прицел, true - чтобы использовать дефолтный прицел из хл2 (по умолчанию false)
SWEP.DrawAmmo 					= true	-- ты можешь удалить это (по умолчанию true)

SWEP.ShotgunReload 				= true	-- перезарядка как у дробовика? (ACT_SHOTGUN_RELOAD_START, ACT_SHOTGUN_RELOAD_FINISH)
-- ты можешь удалить это

------------------------------------
-->> МОДЕЛИ ОТ 1-ГО И 3-ГО ЛИЦА <<--
------------------------------------

SWEP.ViewModel 					= "models/weapons/c_shotgun.mdl"	-- модель от 1 лица
SWEP.ShowViewModel 				= true	-- отображать модель от 1 лица? ты можешь удалить это (по умолчанию true)
SWEP.ViewModelFlip 				= false	-- отзеркалить модель от 1 лица? ты можешь удалить это (по умолчанию false)
SWEP.ViewModelFOV 				= 54	-- по умолчанию тут 54, ты можешь удалить это
SWEP.UseHands 					= true	-- использовать c_arms (по умолчанию false)
SWEP.WorldModel 				= "models/weapons/w_shotgun.mdl"	-- модель от 3 лица
SWEP.ShowWorldModel 			= true	--- отображать модель от 3 лица? ты можешь удалить это (по умолчанию true)

---------------
-->> ЗВУКИ <<--
---------------

SWEP.Primary.Sound 				= Sound( "Weapon_Shotgun.Single" )	-- звук огня, ты можешь удалить это (хотя зачем?)
SWEP.DrawSound 					= nil	-- звук доставания твоей пушки, ты можешь удалить это
SWEP.ReloadSound 				= Sound( "Weapon_Shotgun.Reload" )	-- звук перезарядки, ты можешь удалить это

-------------------------
-->> ОСНОВНЫЕ ХАР-КИ <<--
-------------------------

SWEP.Primary.ClipSize 			= 8	-- вместимость обоймы
SWEP.Primary.DefaultClip 		= SWEP.Primary.ClipSize * 3	-- добавленное кол-во патронов при спауне твоей пушки
SWEP.Primary.FireMode 			= 0	-- 0 - это одиночный, 1 - это очередями и 2 - это автоматический
SWEP.Primary.Ammo 				= "buckshot"	-- pistol, 357, smg1, ar2, buckshot
-- https://wiki.facepunch.com/gmod/Default_Ammo_Types
SWEP.Primary.Damage 			= 15	-- НПС наносят в 2 раза меньше урона
SWEP.Primary.TakeAmmo 			= 1	-- сколько пулей потеряются после выстрела? ты можешь удалить это
SWEP.Primary.StrenghtRecoil 	= 3.23	-- отдача вверх, ты можешь это удалить
SWEP.Primary.Spread 			= 8.42	-- разброс / 100 = настоящий разброс
SWEP.Primary.SpreadTimerNumber 	= 0.7568	-- таймер, чтобы вернуть разброс в исходное значение
SWEP.Primary.NumberofShots 		= 8	-- сколько пулей выстрельнутся после выстрела? ты можешь удалить это
SWEP.Primary.RPM 				= 240	-- 60 / Выстрелы В Минуту = задержка между выстрелами, ты можешь удалить это (оно будет использовать sequence duration)

SWEP.RecoilType 				= 2	-- ты уможешь удалить это, по умолчанию стоит 0
-- 0 - обычный универсальный тип отдачи (оружие просто поднимается вверх), 1 - тип отдчачи как в S.T.A.L.K.E.R. (не до конца идеал)
-- 2 - динмаическая отдача (и ViewPunch), 3 - плавная отдача
-- 5 - возвращаемая отдача

------------------------
-->> УДАР ПО КАМЕРЕ <<--
------------------------

SWEP.Primary.ViewPunchUp 		= 0.6	-- вверх/вниз, ты можешь удалить это
SWEP.Primary.ViewPunchRight 	= nil	-- вправо/влево, ты можешь удалить это
SWEP.ResetViewPunch 			= false	-- сбрасывать ViewPunch после выстрела, ты можешь удалить это (по умолчанию стоит false)

-----------------
-->> ЭФФЕКТЫ <<--
-----------------

SWEP.MuzzleAtt 					= "muzzle"	-- "1" для пушек из КСС, "muzzle" для пушек из ХЛ2, ты можешь удалить это
SWEP.MuzzleEffect 				= "tsb_shotgun_muzzle"	-- ты можешь удалить это
-- "tsb_shotgun_muzzle", "tsb_muzzle_flash_X", "tsb_muzzle_flash_X_bright", "tsb_silenced_muzzle", "tsb_universal_muzzle_flash", "tsb_hl2style_muzzle_flash", "tsb_m9k_style_muzzle_flash"

SWEP.ShowTracerInXChance 		= 1	-- шанс появления следы от пули, можешь удалить это
SWEP.TracerName 				= "Tracer"	-- по умолчанию тут стоит Tracer, можешь удалить это
SWEP.BulletImpactName 			= "RagdollImpact"	-- по умолчанию тут стоит Impact, можешь удалить это
-- https://wiki.facepunch.com/gmod/Effects

----------------------
-->> ПРИЦЕЛИВАНИЕ <<--
----------------------

--[[SWEP.IronSightsPos 				= Vector(-8.961, 0, 4.119)	-- удали или напиши nil, чтобы не использовать прицеливание
SWEP.IronSightsAng 				= Vector(-0.301, 0, 0)	-- удали или напиши nil, чтобы не использовать прицеливание]]
-- Потребуется SWEP Construction Kit (это аддон если что)

SWEP.ScopeTexture 				= 0	-- ты можешь удалить это (по умолчанию здесь стоит 0)
-- 0 - нет прицела, 1 - обычный прицел, 2 - прицел как у ПСО, 3 - ACOG, 4 - Eotech, 5 - зелёная точка

SWEP.IronTime 					= 0.45	-- время до прицеливания, ты можешь удалить это
SWEP.IronFOVMult 				= 1.3	-- по умолчанию здесь стоит 1.3, ты можешь удалить это

----------------
-->> ПРОЧЕЕ <<--
----------------

SWEP.SwitchTo 					= nil	-- поменять режим огня на: "Semi-Auto", "Auto", "Burst", ты можешь удалить это
SWEP.ReloadingTime 				= nil	-- время перезарядки, не для дробовиков, ты это можешь удалить
SWEP.RunPos 					= Vector(-4.261, -5.428, -7.6)	-- удали или напиши nil, чтобы можно было стрелять пока бегаешь
SWEP.RunAng 					= Vector(20.402, 38.693, -12.664)	-- удали или напиши nil, чтобы можно было стрелять пока бегаешь
SWEP.m_WeaponDeploySpeed 		= 0.75	-- скорость доставания (0.5 - это долго, 2 - это быстро), ты можешь удалить это
SWEP.CustomPos 					= Vector( 0, 0, 0 )	-- можешь это убрать

--[[

-- если ты используешь 1 RecoilType
SWEP.CamdDispersion 			= 0	-- увеличения угла (в градусах) с каждым выстрелом
SWEP.CamdDispersionInc 			= nil	-- увеличениe CamdDispersion с каждым выстрелом, ты можешь это удалить
SWEP.CamMaxAngle 				= 0	-- максимальный угол отдачи
SWEP.CamStepAngleHorz 			= nil	-- отклонение оружия по горизонтали при стрельбе, ты можешь это удалить
SWEP.CamdDispersionFrac 		= nil	-- ствол будет подыматься на CamdDispersion * CamdDispersionFrac - CamdDispersion * ( 1 - CamdDispersionFrac ), ты можешь это удалить

]]

---------------------------------------------------
-->> ДОП. АТАКА + ФИКС НЕРАБОТ. ОГНЯ ОЧЕРЕДЯМИ <<--
---------------------------------------------------

SWEP.Secondary.Automatic 		= true	-- авто. втор. атака

function SWEP:SecondaryAttack()	-- ты можешь удалить это
	if (!self:CanPrimaryAttack()) then return end
	self:PrimaryAttack()
	self:PrimaryAttack()
end

function SWEP:CanSecondary()
	return true
end

--[[	-- то что ниже, исправляют неработающий огонь очередями

SWEP.Burst 						= 0
SWEP.BurstTimer 				= CurTime()
-- брух, я сам хз как это фиксит...

--]]

------------------------
-->> ДЛЯ NPC'ШНИКОВ <<--
------------------------

SWEP.NPCFires 					= 1	-- сколько могут НПС стрелять
list.Add( "NPCUsableWeapons", { class = "tsb_example_ru", title = "TSB - " .. SWEP.PrintName } )

-----------------------------------------------
-->> ЕСЛИ ТЫ ХОЧЕШЬ ЧТО-ТО ПОМЕНЯТЬ В БАЗЕ <<--
-----------------------------------------------

--[[

	В этой базе впринципе немало функций, и их можно изменить под себя
	
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
	
	6. Прочее:
	
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