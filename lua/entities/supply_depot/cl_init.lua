include('shared.lua')

language.Add( "Cleanup_Supply_depot", "Supply Depot")
language.Add( "Cleaned_Supply_depot", "Cleaned up Supply Depot")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
