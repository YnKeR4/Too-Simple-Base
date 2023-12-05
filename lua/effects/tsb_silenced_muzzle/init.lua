function EFFECT:Init(data)
self.WeaponEnt = data:GetEntity()
self.Attachment = data:GetAttachment()
self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
self.Forward = data:GetNormal()
self.Angle = self.Forward:Angle()
self.Right = self.Angle:Right()
self.AddVel = self.WeaponEnt:GetOwner():GetVelocity()	|| Vector(0,0,0)
local emitter = ParticleEmitter(self.Position)
for i=0,0 do 
local particle = emitter:Add("effects/doge_s_smoke"..math.random(1,2), self.Position)
particle:SetVelocity(80*i*self.Right)
particle:SetDieTime(math.Rand(0.15,0.3))
particle:SetStartAlpha(math.Rand(50,75))
particle:SetEndAlpha(0)
particle:SetStartSize(12-i)
particle:SetEndSize(24-i)
particle:SetRoll(math.Rand(180,480))
particle:SetRollDelta(math.Rand(-1,1))
particle:SetColor(255,255,255)
end
emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end