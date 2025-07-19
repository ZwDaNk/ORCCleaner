--[[
Name: ORC Cleaner
Creators: ZwDaNk
Description: Cleans your game and prevents skids.
]]

-- // Config
local decalspam = false -- Configures detecting decalspam

-- // Services and functions
local l = game:GetService("Lighting")
local run = game:GetService("RunService")
local ws = game.Workspace

-- // Anti-skybox modification
local ids = {
	SkyboxBk = "rbxasset://textures/sky/sky512_bk.tex",
	SkyboxDn = "rbxasset://textures/sky/sky512_dn.tex",
	SkyboxFt = "rbxasset://textures/sky/sky512_ft.tex",
	SkyboxLf = "rbxasset://textures/sky/sky512_lf.tex",
	SkyboxRt = "rbxasset://textures/sky/sky512_rt.tex",
	SkyboxUp = "rbxasset://textures/sky/sky512_up.tex"
}
local function g()
	local s = l:FindFirstChildOfClass("Sky")
	if not s then
		s = Instance.new("Sky")
		s.Parent = l
	end
	for k,v in pairs(ids) do
		pcall(function() s[k] = v end)
	end
end
coroutine.wrap(function()
  while true do
    g()
    wait(1)
  end
)()

-- // Anti-decalspam
if decalspam then
	while true do
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				local decals = {}
				for _, d in pairs(v:GetChildren()) do
					if d:IsA("Decal") then
						table.insert(decals, d)
					end
				end
				if #decals >= 4 then
					for _, d in pairs(decals) do
						pcall(function() d:Destroy() end)
					end
				end
			end
		end
		wait(1)
	end
end

-- // Anti Particlespam
while wait(1) do
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") then
			local emitters = {}
			for _, child in pairs(part:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					table.insert(emitters, child)
				end
			end
			if #emitters > 5 then
				for _, emitter in pairs(emitters) do
					pcall(function() emitter:Destroy() end)
				end
			end
		end
	end
end

-- // Anti-JKORA
while wait() do
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Part") or v:IsA("SpawnLocation") or v:IsA("TrussPart") then
			pcall(function()
				v.Anchored = false
				v.CanCollide = true
				v.BrickColor = BrickColor.new("Medium stone grey")
			end)
		elseif v:IsA("Sound") and v.Parent == workspace then
			pcall(function()
				v:Stop()
				v:Destroy()
			end)
		end
	end
end
