include('shared.lua')

language.Add("Cleanup_npc_depot","NPC Depot")
language.Add("Cleaned_npc_depot","Cleaned up NPC Depot")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
