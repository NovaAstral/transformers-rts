--This is a lib of easy to use functions made by Nova Astral

function NEasyEffect(origin,pos,scale,effectname)
    local effectdata = EffectData()
	effectdata:SetOrigin(origin)
	effectdata:SetStart(pos)
	effectdata:SetScale(scale)
	util.Effect(effectname, effectdata)
end

function NRadiusPush(pos,radius,force)
	local targets = ents.FindInSphere(pos,radius)

	for _,i in pairs(targets) do
		if i:GetPhysicsObject() and i:GetPhysicsObject():IsValid() and !i:IsPlayer() then
			i:GetPhysicsObject():ApplyForceOffset(Vector(force*100000,force*100000,force*100000),pos)
		end
	end
end

function NScreenShake(name,amplitude,radius,duration,freq,pos)
	local ScrnShake = ents.Create("env_shake")

	ScrnShake:SetName(name)
	ScrnShake:SetKeyValue("amplitude",amplitude)
	ScrnShake:SetKeyValue("radius",radius)
	ScrnShake:SetKeyValue("duration",duration)
	ScrnShake:SetKeyValue("frequency",freq)
	ScrnShake:SetPos(pos)
	ScrnShake:Fire("StartShake","",0)
	ScrnShake:Spawn()
	ScrnShake:Activate()
	
	ScrnShake:Fire("kill","",duration+1)	
end