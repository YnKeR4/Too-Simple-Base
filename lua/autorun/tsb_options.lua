
if SERVER then

	CreateConVar( "tsb_spread_multi", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Base spread * the spread mult", 0, 9999999999 )
	CreateConVar( "tsb_damage_multi", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Base damage * the damage mult", 0, 9999999999 )
	CreateConVar( "tsb_damage_multi_npc", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Same as tsb_damage_multi but for NPCs.", 0, 9999999999 )
	CreateConVar( "tsb_force_disable_jamming", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the jamming system", 0, 1 )
	CreateConVar( "tsb_force_shoot_while_running", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the sprint function", 0, 1 )
	CreateConVar( "tsb_force_disable_overheating", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the overheat.", 0, 1 )
	CreateConVar( "tsb_force_disable_reload_timer", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the reload timer.", 0, 1 )
	CreateConVar( "tsb_force_disable_auto_reload", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the reload timer.", 0, 1 )
	CreateConVar( "tsb_force_disable_iron_sights", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the overheat.", 0, 1 )
	CreateConVar( "tsb_enable_infinity_clipsize", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the overheat.", 0, 2 )
	CreateConVar( "tsb_force_disable_crosshair", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the overheat.", 0, 1 )
	CreateConVar( "tsb_force_disable_overheat_smoke", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Disable the overheat.", 0, 1 )

end

CreateClientConVar( "tsb_c_red", 124, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "tsb_c_green", 252, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "tsb_c_blue", 0, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "tsb_c_alpha", 75, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "tsb_c_gap", 20, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "tsb_c_length", 7.5, { FCVAR_ARCHIVE, FCVAR_REPLICATED } )
CreateClientConVar( "tsb_c_dynam_disable", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_disable_text", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_enable_auto_reload", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_hide_muzzleflash_while_aiming", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_crosshair_and_recoil_scale", 2, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_bobbing", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_vm_y", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_vm_x", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_vm_z", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_vm_recoil_pos", 1.5, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_vm_recoil_ang", -0.125, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_vm_bob", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )
CreateClientConVar( "tsb_disable_overheat_smoke", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

hook.Add( "PopulateToolMenu", "TSBMenu", function()

	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu", "Server", "", "", function( panel )
	
		panel:ControlHelp( "\nOnly for Server" )
	
		panel:CheckBox( "Disable: «Jamming»", "tsb_force_disable_jamming" )
		panel:CheckBox( "Disable: «Overheating»", "tsb_force_disable_overheating" )
		panel:CheckBox( "Disable: Reload Timer", "tsb_force_disable_reload_timer" )
		panel:CheckBox( "Disable: Aiming", "tsb_force_disable_iron_sights" )
		panel:CheckBox( "By Force: Disable Auto Reload", "tsb_force_disable_auto_reload" )
		panel:CheckBox( "By Force: Can shoot while running", "tsb_force_shoot_while_running" )
		panel:CheckBox( "By Force: Disable Crosshair (requires restart/reload)", "tsb_force_disable_crosshair" )
		panel:CheckBox( "By Force: Disable Overheat Smoke", "tsb_force_disable_overheat_smoke" )
		
		local infinityClipSize, label = panel:ComboBox( "Infinity Clip Size", "tsb_enable_infinity_clipsize" )
		infinityClipSize:AddChoice( "Disable", 0, false )
		infinityClipSize:AddChoice( "Enable (Can Reload)", 1, false )
		infinityClipSize:AddChoice( "Enable (Can't Reload)", 2, false )
		
		panel:NumSlider( "Damage Multiplier (Player)", "tsb_damage_multi", 0, 10, 1 )
		panel:NumSlider( "Damage Multiplier (NPC)", "tsb_damage_multi_npc", 0, 10, 1 )
		panel:NumSlider( "Spread Multiplier (Both)", "tsb_spread_multi", 0, 10, 1 )
		
	end )
	
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu_client_other", "Other", "", "", function( panel )
		
		panel:CheckBox( "Disable: Overheat Smoke", "tsb_disable_overheat_smoke" )
		panel:CheckBox( "Disable: Text", "tsb_disable_text" )
		panel:CheckBox( "Enable: Auto Reload", "tsb_enable_auto_reload" )
		panel:CheckBox( "Enable: Muzzle Flash in Scope", "tsb_hide_muzzleflash_while_aiming" )
		panel:NumSlider( "Camera Bobbing Multiplier", "tsb_bobbing", 0, 5, 0 )
		
		panel:ControlHelp( "\nThe Camera Bobbing feature is not fully finalized!" )
		panel:ControlHelp( "\nRecommended to set it to 0" )
	
	end )
	
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu_client_crosshair", "Crosshair", "", "", function( panel )
		
		panel:AddControl( "Color", {
		
			Label = "Crosshair Color",
			
			Red = "tsb_c_red",
			Green = "tsb_c_green",
			Blue = "tsb_c_blue",
			Alpha = "tsb_c_alpha"
			
		} )
		
		panel:NumSlider( "The Gap", "tsb_c_gap", 1, 200, 0 )
		panel:NumSlider( "The Lenght", "tsb_c_length", 1, 200, 0 )
		panel:NumSlider( "The Following Multiplier", "tsb_crosshair_and_recoil_scale", 0, 10, 0 )
		panel:CheckBox( "Static Crosshair (requires restart/reload)", "tsb_c_dynam_disable" )
	
	end )
	
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu_client_viewmodel", "ViewModel", "", "", function( panel )
		
		panel:NumSlider( "X", "tsb_vm_x", -10, 10, 0 )
		panel:NumSlider( "Y", "tsb_vm_y", -10, 10, 0 )
		panel:NumSlider( "Z", "tsb_vm_z", -10, 10, 0 )
		
		panel:NumSlider( "Bob Multiplier", "tsb_vm_bob", -5, 5, 0 )
		
		panel:NumSlider( "Recoil Tracking Pos", "tsb_vm_recoil_pos", -5, 5, 1 )
		panel:NumSlider( "Recoil Tracking Ang", "tsb_vm_recoil_ang", -5, 5, 1 )
	
	end )
	
end )
