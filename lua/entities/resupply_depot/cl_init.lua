include('shared.lua')

language.Add( "Cleanup_resupply_depot", "Resupply Depot")
language.Add( "Cleaned_resupply_depot", "Cleaned up Resupply Depot")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
