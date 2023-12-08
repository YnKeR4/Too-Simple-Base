AddCSLuaFile()

DEFINE_BASECLASS("too_simple_base")

SWEP.Base 						= "too_simple_base"	-- не совсем :D

SWEP.ViewModelBoneMods = {
	["ValveBiped.Gun"] = { scale = Vector(1.1, 1.1, 1.1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Pump"] = { scale = Vector(1, 0.904, 1.052), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["bruh"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0.699, -1.101, -16.105), angle = Angle(90, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.752, 2, -5.715), angle = Angle(-7, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.PrintName 					= "SPASAI-12"
SWEP.Category 					= "TSB Example"
SWEP.Slot 						= 3
SWEP.Spawnable 					= true	-- её могут спаунить обычные люди
SWEP.AdminSpawnable 			= true	-- её могут спаунить админы

SWEP.ShotgunReload 				= true	-- перезарядка как у дробовика? (ACT_SHOTGUN_RELOAD_START, ACT_SHOTGUN_RELOAD_FINISH)
-- you can delete this
SWEP.ViewModel 					= "models/weapons/c_shotgun.mdl"	-- модель от 1 лица
SWEP.ShowViewModel 				= true	-- отображать модель от 1 лица? ты можешь удалить это
SWEP.ViewModelFlip 				= false	-- отзеркалить модель от 1 лица? ты можешь удалить это
SWEP.ViewModelFOV 				= 54	-- по умолчанию тут 54, ты можешь удалить это
SWEP.UseHands 					= true	-- использовать c_arms
SWEP.WorldModel 				= "models/weapons/w_shotgun.mdl"	-- модель от 3 лица
SWEP.ShowWorldModel 			= true	--- отображать модель от 3 лица? ты можешь удалить это

SWEP.m_WeaponDeploySpeed 		= 0.75	-- скорость доставания (0.5 - это долго, 2 - это быстро), ты можешь удалить это (по умолчанию 1)
SWEP.AutoSwitchTo 				= true	-- ты можешь удалить это
SWEP.AutoSwitchFrom 			= true	-- ты можешь удалить это

SWEP.HoldType 					= "shotgun"	-- pistol, revolver, smg, ar2, shotgun, rpg
SWEP.HoldTypeIron 				= "rpg"	-- "revolver" для маленьких пушек или "rpg" для довольно больших пушек
SWEP.HoldTypeSprint 			= "passive"	-- "normal" для маленьких пушек или "passive" для больших, если оружие может стрелять пока бегаете, то можно удалить это
-- https://wiki.facepunch.com/gmod/Hold_Types
SWEP.DrawCrosshair 				= false	-- false - чтобы использовать динмаический прицел, true - чтобы
SWEP.DrawAmmo 					= true	-- ты можешь удалить это

SWEP.Primary.Sound 				= Sound( "Weapon_Shotgun.Single" )	-- звук огня, ты можешь удалить это (хотя зачем?)
SWEP.Primary.SoundExtra 		= nil	-- дополнительный звук огня (можно для эхо после выстрела, ещё проверь, что канал звука это CHAN_STATIC), ты можешь удалить это
SWEP.DrawSound 					= nil	-- звук доставания твоей пушки, ты можешь удалить это
SWEP.ReloadSound 				= Sound( "Weapon_Shotgun.Reload" )	-- звук перезарядки, ты можешь удалить это

SWEP.Primary.ClipSize 			= 8	-- вместимость обоймы
SWEP.Primary.DefaultClip 		= SWEP.Primary.ClipSize * 3	-- добавленное кол-во патронов при спауне твоей пушки
SWEP.Primary.FireMode 			= 2	-- 0 - это одиночный, 1 - это очередями и 2 - это автоматический
-- !!!ВНИМАНИЕ!!! из-за какой-то неизвестной причины, огонь очередями не работает
SWEP.Primary.Ammo 				= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, ты можешь удалить это (авто. выберется тип патронов, смотря на HoldType)
-- https://wiki.facepunch.com/gmod/Default_Ammo_Types
SWEP.Primary.Damage 			= 15	-- НПС наносят в 2 раза меньше урона
SWEP.Primary.TakeAmmo 			= 1	-- сколько пулей потеряются после выстрела? ты можешь удалить это
SWEP.Primary.StrenghtRecoil 	= 3.23	-- отдача вверх, ты можешь это удалить
SWEP.Primary.Spread 			= 8.42	-- разброс / 100 = настоящий разброс
SWEP.Primary.SpreadTimerNumber 	= 0.7568	-- таймер, чтобы вернуть разброс в исходное значение
SWEP.Primary.NumberofShots 		= 8	-- сколько пулей выстрельнутся после выстрела? ты можешь удалить это
SWEP.Primary.RPM 				= 240	-- 60 / Выстрелы В Минуту = задержка между выстрелами, ты можешь удалить это (оно будет использовать sequence duration)

SWEP.RecoilType 				= 0	-- 0 - обычный универсальный тип отдачи (оружие просто поднимается вверх), 1 - тип отдчачи как в S.T.A.L.K.E.R. (ещё не до конца идеал), 
-- ты можешь это удалить, значение по умолчанию это 0

--[[	-- если ты используешь 1 RecoilType
SWEP.CamdDispersion 			= 0	-- увеличения угла (в градусах) с каждым выстрелом
SWEP.CamdDispersionInc 			= nil	-- увеличениe CamdDispersion с каждым выстрелом, ты можешь это удалить
SWEP.CamMaxAngle 				= 0	-- максимальный угол отдачи
SWEP.CamStepAngleHorz 			= nil	-- отклонение оружия по горизонтали при стрельбе, ты можешь это удалить
SWEP.CamdDispersionFrac 		= nil	-- ствол будет подыматься на CamdDispersion * CamdDispersionFrac - CamdDispersion * ( 1 - CamdDispersionFrac ), ты можешь это удалить
]]

SWEP.MuzzleAtt 					= "muzzle"	-- "1" для пушек из КСС, "muzzle" для пушек из ХЛ2, ты можешь удалить это
SWEP.MuzzleEffect 				= "tsb_shotgun_muzzle"	-- ты можешь удалить это
-- "tsb_shotgun_muzzle", "tsb_muzzle_flash_X", "tsb_muzzle_flash_X_bright", "tsb_silenced_muzzle", "tsb_universal_muzzle_flash"
SWEP.SwitchTo 					= "Semi-Auto"	-- поменять режим огня на: "Semi-Auto", "Auto", "Burst", ты можешь удалить это
-- !!!ВНИМАНИЕ!!! из-за какой-то неизвестной причины, огонь очередями не работает
SWEP.ShootsOnlyInIron 			= false	-- стрелять ТОЛЬКО во время прицеливания, ты можешь удалить это (по умолчанию false)
SWEP.IronSightsPos 				= Vector(-8.961, 0, 4.119)	-- удали или напиши nil, чтобы не использовать прицеливание
SWEP.IronSightsAng 				= Vector(-0.301, 0, 0)	-- удали или напиши nil, чтобы не использовать прицеливание
SWEP.RunPos 					= Vector(-4.261, -5.428, -7.6)	-- удали или напиши nil, чтобы можно было стрелять пока бегаешь
SWEP.RunAng 					= Vector(20.402, 38.693, -12.664)	-- удали или напиши nil, чтобы можно было стрелять пока бегаешь
-- Потребуется SWEP Construction Kit (это аддон если что)
SWEP.ScopeTexture 				= 0	-- ты можешь удалить это (по умолчанию здесь стоит 0)
-- 0 - нет прицела, 1 - обычный прицел, 2 - прицел как в Колде, 3 - ACOG, 4 - Eotech
SWEP.IronTime 					= 0.45	-- время до прицеливания, ты можешь удалить это
SWEP.IronFOVMult 				= 1.45	-- по умолчанию здесь стоит 1.45, ты можешь удалить это

SWEP.Primary.ViewPunchUp 		= 2.643	-- вверх/вниз, ты можешь удалить это
SWEP.Primary.ViewPunchRight 	= 0.754	-- вправо/влево, ты можешь удалить это (будет авто. вычилсяться, если в ViewPunchUp есть цифры)
SWEP.Primary.ViewPunchRoll 		= 2.432	-- ну типо, сила покачивания от выстрела, ты можешь удалить это (будет авто. вычилсяться, если в ViewPunchUp есть цифры)
SWEP.ResetViewPunch 			= true	-- сбрасывать ViewPunch после выстрела, ты можешь удалить это (по умолчанию стоит false)

SWEP.ShowTracerInXChance 		= 1	-- шанс появления следы от пули, ты можешь удалить это
SWEP.TracerName 				= "Tracer"	-- по умолчанию тут стоит Tracer, ты можешь удалить это
SWEP.BulletImpactName 			= "RagdollImpact"	-- по умолчанию тут стоит Impact, ты можешь удалить это
-- https://wiki.facepunch.com/gmod/Effects

SWEP.NPCFires 					= 1	-- сколько могут НПС стрелять
list.Add( "NPCUsableWeapons", { class = "tsb_example_ru", title = "TSB - " .. SWEP.PrintName } )
