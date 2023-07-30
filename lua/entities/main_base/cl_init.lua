include('shared.lua')

language.Add( "Cleanup_main_base", "Main Base")
language.Add( "Cleaned_main_base", "Cleaned up Main Base")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
