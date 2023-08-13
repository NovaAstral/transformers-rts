include('shared.lua')

language.Add( "Cleanup_command_center", "Command Center")
language.Add( "Cleaned_mcommand_center", "Cleaned up Command Center")

function ENT:Draw()
   self:DrawEntityOutline( 0.0 )
   self.Entity:DrawModel()	
end

function ENT:DrawEntityOutline()
   return
end
