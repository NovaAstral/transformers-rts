include('shared.lua')

language.Add("Cleanup_factory","Factory")
language.Add("Cleaned_factory","Cleaned up Factory")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
