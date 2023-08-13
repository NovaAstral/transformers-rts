include('shared.lua')

language.Add("Cleanup_Bunker","Bunker")
language.Add("Cleaned_Bunker","Cleaned up Bunker")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
