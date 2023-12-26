
hook.Add( "PopulateToolMenu", "TSBMenu", function()
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu", "Server", "", "", function( panel )
	
		panel:ControlHelp("\nOnly for Server")
	
		panel:CheckBox("Disable: «Jamming»", "tsb_force_disable_jamming")
		panel:CheckBox("Disable: «Overheating»", "tsb_force_disable_overheating")
		panel:CheckBox("Force: Can shoot while running", "tsb_force_shoot_while_running")
		
		panel:NumSlider("Damage Multiplier (Player)", "tsb_damage_multi", 0.1, 10, 1)
		panel:NumSlider("Damage Multiplier (NPC)", "tsb_damage_multi_npc", 0.1, 10, 1)
		panel:NumSlider("Spread Multiplier (Both)", "tsb_spread_multi", 0, 10, 1)
		
	end )
end )
