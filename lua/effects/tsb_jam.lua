
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
    for i = 1,10 do
        local spark = emitter:Add("tsb_flex/"..math.random(1,4), self.Position)
        spark:SetStartAlpha(255)
        spark:SetEndAlpha(0)
        spark:SetCollide(true)
        spark:SetBounce(0.25)
        spark:SetColor(255,255,225)
        spark:SetGravity(Vector(0,0,-600))
        spark:SetEndSize(1)
        spark:SetStartSize(1)
        spark:SetDieTime(1.5)
        spark:SetVelocity((self.Forward*math.Rand(150, 300)+VectorRand()*150)*0.5)
    end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end