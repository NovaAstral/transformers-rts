AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.WireDebugName = "Supply Depot"

function ENT:SpawnFunction(ply, tr)
	local ent = ents.Create("Supply_depot")
	ent:SetPos(tr.HitPos + Vector(0, 0, 0))
	ent:Spawn()
	return ent 
end 

function ENT:Initialize()
	util.PrecacheModel("models/starcraft/terran/building/supplydepot.mdl")
	
	self.Entity:SetModel("models/starcraft/terran/building/supplydepot.mdl")
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	self.Entity:DrawShadow(false)

	self.Entity:SetUseType(SIMPLE_USE)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if(phys:IsValid()) then
		phys:SetMass(100)
		phys:EnableGravity(true)
		phys:Wake()
		phys:EnableMotion(false)
	end

	self.MaxHP = 500
	self.CriticalHP = 50 --What HP to start the smoke at

	self.Entity:SetMaxHealth(self.MaxHP)
	self.Entity:SetHealth(self.MaxHP)
end

function ENT:Use(ply)
	if(IsValid(ply) and !self.Exploded) then
		--local Wep = ply:GetActiveWeapon()
		--local Ammo = Wep:GetPrimaryAmmoType()
		--ply:GiveAmmo(10,Ammo,false)

		local spawnent = ents.Create("item_ammo_ar2")
		spawnent:SetPos(self.Entity:LocalToWorld(Vector(0,0,45)))
		spawnent:Activate()
		spawnent:Spawn()
		local vec = Vector(10000,0,0)
		vec:Rotate(self.Entity:GetAngles())
		spawnent:GetPhysicsObject():ApplyForceCenter(vec)
	end
end

function ENT:OnTakeDamage(damage)
	local dmg = damage:GetDamage()
	
	if (!self.Exploded) then
		self.Entity:SetHealth(math.Clamp(self.Entity:Health() - dmg,0,self.Entity:GetMaxHealth()))
		
		if(self.Entity:Health() <= 0) then
			self:Splode()
		end

		if(self.Entity:Health() <= self.CriticalHP and !self.smoke and !IsValid(self.smoke)) then
			self:StartSmoke()

			hook.Add("Think","SupplyDepot_Smoke_RemoveOnHeal",function()
				if(self.Entity:Health() > self.CriticalHP) then
					self:StopSmoke()
					hook.Remove("Think","SupplyDepot_Smoke_RemoveOnHeal")
				end
			end)
		end
	end
end

function ENT:StartSmoke()
	local smoke = ents.Create("env_smokestack")
	smoke:SetPos(self.Entity:LocalToWorld(Vector(0,0,50)))
	smoke:SetAngles(Angle(0,0,0))
	smoke:SetKeyValue("InitialState","1")
	smoke:SetKeyValue("WindAngle","0 0 0")
	smoke:SetKeyValue("WindSpeed","0")
	smoke:SetKeyValue("rendercolor","50 50 50")
	smoke:SetKeyValue("renderamt","170")
	smoke:SetKeyValue("SmokeMaterial","particle/smokesprites_0001.vmt")
	smoke:SetKeyValue("BaseSpread","5")
	smoke:SetKeyValue("SpreadSpeed","10")
	smoke:SetKeyValue("Speed","50")
	smoke:SetKeyValue("StartSize","80")
	smoke:SetKeyValue("EndSize","180")
	smoke:SetKeyValue("roll","20")
	smoke:SetKeyValue("Rate","10")
	smoke:SetKeyValue("JetLength","500")
	smoke:SetKeyValue("twist","5")
	smoke:Spawn()
	smoke:SetParent(self)
	smoke:Activate()

	self.smoke = smoke
	self.smoke.speed = 50
	self.smoke.length = 100
end

function ENT:StopSmoke()
	if(self.smoke and IsValid(self.smoke)) then
		self.smoke:SetParent(nil)
		self.smoke:Fire("TurnOff")
		self.smoke.killdelay = CurTime()+(self.smoke.speed/self.smoke.length)*5
	end
end

function ENT:Splode() --Explode the entity
	if(!self.Exploded) then
		self.Exploded = true

		timer.Create("SupplyDepot_Explode1"..self:EntIndex(),1,3,function() --3 Small Explosions
			self.Entity:EmitSound("phx/explode06.wav",80,100,1)

			util.BlastDamage(self.Entity,self.Entity,self.Entity:GetPos(),250,25)
		
			--This is a function from my (Nova Astral) lib
			NEasyEffect(self.Entity:GetPos(),self.Entity:GetPos(),20,"HelicopterMegaBomb")
		end)

		timer.Create("SupplyDepot_Explode2"..self:EntIndex(),5,1,function() --main explosion
			self.Entity:EmitSound("phx/explode06.wav",100,100,1)

			NEasyEffect(self.Entity:GetPos(),self.Entity:GetPos(),10,"Explosion")

			util.BlastDamage(self.Entity,self.Entity,self.Entity:GetPos(),750,750)

			NRadiusPush(self.Entity:GetPos(),2000,30)

			NScreenShake("SupplyDepot_shake",200,750,5,255,self.Entity:GetPos())

			self:StopSmoke()

			self.Entity:Remove()
		end)
	end
end

function ENT:OnRemove()
	hook.Remove("Think","SupplyDepot_Smoke_RemoveOnHeal")
	timer.Stop("SupplyDepot_Explode1"..self:EntIndex())
	timer.Stop("SupplyDepot_Explode2"..self:EntIndex())
end