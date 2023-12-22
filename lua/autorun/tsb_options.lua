
hook.Add( "PopulateToolMenu", "TSBMenu", function()
	spawnmenu.AddToolMenuOption( "Options", "Too Simple: Base", "tsb_menu", "Options", "", "", function( panel )
	
		panel:CheckBox("Disable: «Jamming»", "tsb_force_disable_jamming")
		panel:CheckBox("Disable: «Overheating»", "tsb_force_disable_overheating")
		panel:CheckBox("Disable: Custom muzzle flashs", "tsb_force_disable_custom_effects")
		panel:CheckBox("Disable: Text at spawn", "tsb_disable_text_at_spawn")
		panel:CheckBox("Force: Can shoot while running", "tsb_force_shoot_while_running")
		panel:CheckBox("Force: Shoots only in iron", "tsb_force_shoot_only_in_iron")
		
		panel:NumSlider("Damage Multiplier (Player)", "tsb_damage_multi", 0.1, 10, 1)
		panel:NumSlider("Damage Multiplier (NPC)", "tsb_damage_multi_npc", 0.1, 10, 1)
		
	end )
end )
