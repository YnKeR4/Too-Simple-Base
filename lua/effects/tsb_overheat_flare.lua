function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	self.Up = self.Angle:Up()
	self.AddVel = self.WeaponEnt:GetOwner():GetVelocity()	|| Vector(0,0,0)
	local emitter = ParticleEmitter(self.Position)
	for i=0,0 do
		local particle = emitter:Add("effects/yellowflare", self.Position)
		particle:SetVelocity(self.Forward)
		particle:SetDieTime(0.025)
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(5)
		particle:SetEndSize(5)
		particle:SetColor(255,0,0)
		particle:SetAirResistance(255)
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end