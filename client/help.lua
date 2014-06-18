-- Basic helper script for that helper script

class 'Helper'

function Helper:__init()
	Events:Subscribe( "ModuleLoad", self, self.ModulesLoad )
	Events:Subscribe( "ModulesLoad", self, self.ModulesLoad )
	Events:Subscribe( "ModuleUnload", self, self.ModuleUnload )
end


function Helper:ModulesLoad()
	Events:Fire( "HelpAddItem",
		{
			name = "Runways",
			text =
				"This script allows you to view the runways while in a plane.\n" ..
				"Use \"/runways\" to toggle viewing the runways." ..
				"\n\n" ..
				"Script made by Eraknelo on the forums"
		})
end

function Helper:ModuleUnload()
	Events:Fire( "HelpRemoveItem",
		{
			name = "Runways"
		})
end

tester = Helper()
