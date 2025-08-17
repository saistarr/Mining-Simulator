--[[
MS1 REMOTE UTILITY v1.2
v1.2: added loadstring settings thingy..
What MS1 Remote Utility is & isnt:
+ It prevents remote bans for MS1
+ Puts the remote in the global enviroment, variable name is Remote (can be changed)
+ Redirects fake remotes to the real one
+ some other developer oriented useful stuff ^^
- There is probably more ways of getting banned other than remotes lol if you know any, tell me! (@.sqi.stqr.)

by Sai<3
]]

--Making sure the game is Mining Simulator just incase this is in your autoexecute
if game.PlaceId ~= 1417427737 then
	return
end

--Some executors don't have script support (somehow) I think
local script = Instance.new("Script")

--Script settings lol
local ScriptSettings = {
	--Loaded prompt (i HIGHLY reccomend keeping this enabled.)
	loadedPrompt = true,
	
	--Global remote
	globalRemote = true,
	globalRemoteName = "Remote",
	
	--Debug/Reports
	reportRedirects = true
}

--SCRIPT BELOW! DON'T MESS WITH IT IF YOU DON'T KNOW WHAT YOU'RE DOING. ANY ISSUES THAT OCCUR FROM YOU MESSING WITH THIS CODE BELOW IS NOT MY FAULT.
return function(Settings)
	if Settings then
		for Setting,Value in Settings do
			if ScriptSettings[Setting] then
				ScriptSettings[Setting] = Value 
			end
		end
	end
	
	--Defining variables
	local hookmetamethod, Remote, Verified1, Verified2, VerifyHook, RemoteHook1, RemoteHook2, RemoteHook3 = hookmetamethod, game:GetService("ReplicatedStorage"):WaitForChild("Network"):InvokeServer()

	--Making sure the Remote is real (by running if x then it will check if it is nil or not in this case, some executors may fake UNC functions leading this to be nil.)
	if Remote then
		Verified1 = true
	end

	--Making sure the executor supports hookmetamethod
	VerifyHook = hookmetamethod(game, "__namecall", function(Self, ...)
	    if getnamecallmethod():lower() == "verify" then
 	   	Verified2 = true
 	   else
	  	  return VerifyHook(Self, ...)
	    end
	end)
	script:Verify()

	--Checking if verification passed, if not kicking the player so they don't ban themselves xd
	if Verify1 == false or Verify2 == false then
		game:GetService("Players").LocalPlayer:Kick("Sorry, your executor can't run this script.")
	end

	--Defining global Remote so you can simply type Remote
	if ScriptSettings.globalRemote == true then
		getgenv()[ScriptSettings.globalRemoteName] = Remote
	end

	--Making WaitForChild return the remote
	RemoteHook1 = hookmetamethod(game, "__namecall", function(Self, ...)
	    if getnamecallmethod():lower() == "waitforchild" and (...) == "ř̷͔̗̘̗̱̀ė̶͓̿̿̈́̎̌͛͊̅̄̕͘͝m̷̯̬̬̤̥̜̲͂͐̈̄̊̿̓̈́̍̌́ŏ̵̊̓̆̈́" then
 	   	return Remote
 	   end
 	   return RemoteHook1(Self, ...)
	end)

	--If you try to get remo via workspace[""]
	RemoteHook2 = hookmetamethod(game, "__index", function(Self, Method)
	    if Method:lower() == "ř̷͔̗̘̗̱̀ė̶͓̿̿̈́̎̌͛͊̅̄̕͘͝m̷̯̬̬̤̥̜̲͂͐̈̄̊̿̓̈́̍̌́ŏ̵̊̓̆̈́" then
	        return Remote
	    end  
	    return RemoteHook2(Self, Method)
	end)

	--Anti ban & remote redirection for stuff like remote spy :)
	RemoteHook3 = hookmetamethod(game, "__namecall", function(Self, ...)
		if getnamecallmethod():lower() == "fireserver" and Self ~= Remote then
			if ScriptSettings.reportRedirects == true then
				warn("Redirected "..Self.Name.." (fake remote) to the correct remote.")
			end
			return RemoteHook3(Remote, ...)
		end
		return RemoteHook3(Self, ...)
	end)

	if ScriptSettings.loadedPrompt == true then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Remote Utilities v1.1\nLoaded!",
			Text = "\nby Sai<3 (@.sqi.stqr. for help!)",
			Duration = math.huge,
			Button1 = "Got it!"
		})
	end
end
