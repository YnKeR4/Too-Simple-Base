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
		local particle = emitter:Add("particle/smokesprites_0004", self.Position)
		particle:SetVelocity(self.WeaponEnt.Owner:GetVelocity()+VectorRand()*math.Rand(15,30))
		particle:SetDieTime(0.45)
		particle:SetStartAlpha(25)
		particle:SetEndAlpha(0)
		particle:SetStartSize(1)
		particle:SetEndSize(10)
		particle:SetRoll(360)
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(200,200,200)
		particle:SetGravity(Vector(0,0,math.Rand(600,900)))
		particle:SetAirResistance(255)
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end