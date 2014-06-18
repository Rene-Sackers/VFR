class "VFR"

function VFR:__init()
	--if LocalPlayer:GetSteamId().string ~= "STEAM_0:0:16870054" then return end
	
	self.runways = LoadRunways()
	self.inPlane = false
	self.beVisible = true	-- couldn't think of a better name but this is just whether or not the runways are visible
	
	self.planes = {
		[59] = true,
		[81] = true,
		[51] = true,
		[30] = true,
		[34] = true,
		[85] = true,
		[39] = true
	}
	
	self.drawColor = Color(0, 255, 0, 128)
	
	Events:Subscribe("LocalPlayerEnterVehicle", self, self.LocalPlayerEnterVehicle)
	Events:Subscribe("LocalPlayerExitVehicle", function() self.inPlane = false end)
	Events:Subscribe("Render", self, self.Render)
	Network:Subscribe("toggleVFR", self, self.ToggleVFR)
end

function VFR:LocalPlayerEnterVehicle(args)
	if not IsValid(args.vehicle) then
		self.inPlane = false
		return
	end
	
	if self.planes[args.vehicle:GetModelId()] then
		self.inPlane = true
	end
end

function VFR:Render()
	if not self.inPlane or Game:GetState() ~= GUIState.Game or not self.beVisible then return end
	
	-- Check all runways
	for index, data in pairs(self.runways) do
		local center = data.center
		local radius = data.radius
		
		-- Player is close enough
		if Vector3.Distance(LocalPlayer:GetPosition(), center) <= radius then
			local runwayLines = data.runwayLines
			
			-- Draw all lines
			for index, line in pairs(runwayLines) do
				Render:DrawLine(line.lineStart, line.lineEnd, self.drawColor)
			end
		end
	end
end

-- toggles if runways are visible or not
function VFR:ToggleVFR()
	self.beVisible = not self.beVisible
end

Events:Subscribe("ModuleLoad", function()
	VFR()
end)