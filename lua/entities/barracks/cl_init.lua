include('shared.lua')

language.Add("Cleanup_barracks","Barracks")
language.Add("Cleaned_barracks","Cleaned up Barracks")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
