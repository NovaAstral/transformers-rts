include('shared.lua')

language.Add("Cleanup_starport","Starport")
language.Add("Cleaned_starport","Cleaned up Starport")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
