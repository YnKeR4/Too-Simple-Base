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
local particle = emitter:Add("effects/not_mine/idkhowtoaddthis", self.Position)
particle:SetVelocity(80*i*self.Right)
particle:SetDieTime(math.Rand(0.1,0.2))
particle:SetStartAlpha(math.Rand(50,75))
particle:SetEndAlpha(0)
particle:SetStartSize(12-i)
particle:SetEndSize(24-i)
particle:SetRoll(math.Rand(180,480))
particle:SetRollDelta(math.Rand(-1,1))
particle:SetColor(255,255,255)
end
for i=0,0 do 
local particle = emitter:Add("effects/not_mine/muzzleflashx", self.Position+(self.Forward*i*2))
particle:SetVelocity((self.Forward*i*5) + self.AddVel)
particle:SetDieTime(0.05)
particle:SetStartAlpha(255)
particle:SetEndAlpha(0)
particle:SetStartSize(6-i)
particle:SetEndSize(18-i)
particle:SetRoll(0)
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