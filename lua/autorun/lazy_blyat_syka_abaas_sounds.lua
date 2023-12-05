
if SERVER then

	if GetConVar( "tsb_damage_multi" ) == nil then
		CreateConVar( "tsb_damage_multi", 1, { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Base damage * the damage mult", 1, 9999999999 )
	end

	if GetConVar( "tsb_force_disable_jamming" ) == nil then
		CreateConVar( "tsb_force_disable_jamming", 0, { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable the jamming system", 0, 1 )
	end

	if GetConVar( "tsb_force_shoot_while_running" ) == nil then
		CreateConVar( "tsb_force_shoot_while_running", 0, { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable the sprint function", 0, 1 )
	end

	if GetConVar( "tsb_force_disable_custom_effects" ) == nil then
		CreateConVar( "tsb_force_disable_custom_effects", 0, { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable the custom muzzle flashes", 0, 1 )
	end

	if GetConVar( "tsb_force_shoot_only_in_iron" ) == nil then
		CreateConVar( "tsb_force_shoot_only_in_iron", 0, { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Shooting allowed only in iron sights", 0, 1 )
	end

	if GetConVar( "tsb_force_disable_iron" ) == nil then
		CreateConVar( "tsb_force_disable_iron", 0, { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable the iron sights", 0, 1 )
	end

end

sound.Add(
{
name = "TooSimpleBase.Empty",
channel = CHAN_STATIC,
volume = 1.0,
soundlevel = SNDLVL_TALKING,
sound = "weapons/TSBase/Empty.ogg"
})
sound.Add(
{
name = "TooSimpleBase.Alert",
channel = CHAN_STATIC,
volume = 1.0,
soundlevel = SNDLVL_TALKING,
sound = "weapons/TSBase/medigun_no_target.wav"
})
sound.Add(
{
name = "TooSimpleBase.FireMode",
channel = CHAN_STATIC,
volume = 1.0,
soundlevel = SNDLVL_TALKING,
sound = "weapons/TSBase/FireMode.ogg"
})
sound.Add(
{
name = "TooSimpleBase.Jam",
channel = CHAN_STATIC,
volume = { 1.5, 3 },
soundlevel = SNDLVL_TALKING,
sound = { "weapons/TSBase/sentry_upgrading1.wav",
"weapons/TSBase/sentry_upgrading2.wav", 
"weapons/TSBase/sentry_upgrading3.wav",
"weapons/TSBase/sentry_upgrading4.wav",
"weapons/TSBase/sentry_upgrading5.wav",
"weapons/TSBase/sentry_upgrading6.wav",
"weapons/TSBase/sentry_upgrading7.wav" }
})
