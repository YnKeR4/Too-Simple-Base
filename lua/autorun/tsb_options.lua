
hook.Add( "PopulateToolMenu", "TSBMenu", function()
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu", "Server", "", "", function( panel )
	
		panel:ControlHelp( "\nOnly for Server" )
	
		panel:CheckBox( "Disable: «Jamming»", "tsb_force_disable_jamming" )
		panel:CheckBox( "Disable: «Overheating»", "tsb_force_disable_overheating" )
		panel:CheckBox( "Force: Can shoot while running (restart/reload)", "tsb_force_shoot_while_running" )
		
		panel:NumSlider( "Damage Multiplier (Player)", "tsb_damage_multi", 0.1, 10, 1 )
		panel:NumSlider( "Damage Multiplier (NPC)", "tsb_damage_multi_npc", 0.1, 10, 1 )
		panel:NumSlider( "Spread Multiplier (Both)", "tsb_spread_multi", 0, 10, 1 )
		
	end )
	
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu_client", "Client", "", "", function( panel )
	
		panel:ControlHelp( "\nOnly for You" )
		panel:ControlHelp( "\nCrosshair" )
		
		panel:AddControl( "Color", {
		
			Label = "Crosshair Color",
			
			Red = "tsb_c_red",
			Green = "tsb_c_green",
			Blue = "tsb_c_blue",
			Alpha = "tsb_c_alpha"
			
		} )
		
		panel:AddControl( "Slider", {
		
			Label = "Crosshair: The Gap",
			
			Command = "tsb_c_gap",
			Type = "Float",
			Min = "1",
			Max = "200"
		
		} )
		
		panel:AddControl( "Slider", {
		
			Label = "Crosshair: The Lenght",
			
			Command = "tsb_c_length",
			Type = "Float",
			Min = "1",
			Max = "200"
		
		} )
		
		panel:CheckBox( "Static Crosshair (requires restart/reload)", "tsb_c_dynam_disable" )
	
	end )
	
end )
