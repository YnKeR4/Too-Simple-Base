function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)
	self.Forward = data:GetNormal()
	self.Angle = self.Forward:Angle()
	self.Right = self.Angle:Right()
	self.AddVel = self.WeaponEnt:GetOwner():GetVelocity()	|| Vector(0,0,0)
	local emitter = ParticleEmitter(self.Position)
	for i=-1,1 do 
		local particle = emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Position)
		particle:SetVelocity(80*i*self.Right)
		particle:SetDieTime(math.Rand(0.1,0.2))
		particle:SetStartAlpha(math.Rand(50,75))
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.random(5,10))
		particle:SetEndSize(math.Rand(10,15))
		particle:SetRoll(math.Rand(180,480))
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(255,255,255)
		particle:SetAirResistance(255)
	end
	for i=0,5 do 
		local particle = emitter:Add("effects/muzzleflash"..math.random(1,4), self.Position+(self.Forward*i*2))
		particle:SetVelocity((self.Forward*i*5) + self.AddVel)
		particle:SetDieTime(0.05)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(7-i)
		particle:SetEndSize(14-i)
		particle:SetRoll(math.Rand(180,480))
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(255,255,255)	
	end
    local dlight = DynamicLight( LocalPlayer():EntIndex() )
	if dlight then
		dlight.pos = self.Position
		dlight.r = 255
		dlight.g = 125
		dlight.b = 0
		dlight.brightness = math.random( 1, 5 )
		dlight.Decay = 1000
		dlight.Size = math.random( 50, 100 )
		dlight.DieTime = CurTime() + 0.055
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end