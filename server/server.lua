-- No need for a class if it's only 1 function

-- function checks for if someone says "/runways"
OnPlayerChat = function(args)
	if args.text == "/runways" then
		Network:Send(args.player, "toggleVFR")
	end
end

Events:Subscribe("PlayerChat", OnPlayerChat)
