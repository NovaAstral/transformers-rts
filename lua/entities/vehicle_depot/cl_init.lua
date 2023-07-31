include('shared.lua')

language.Add("Cleanup_vehicle_depot","Vehicle Depot")
language.Add("Cleaned_vehicle_depot","Cleaned up Vehicle Depot")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
