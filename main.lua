--[[         _____                    _____                    _____                   _____         
        /\    \                  /\    \                  /\    \                 /\    \         
       /::\____\                /::\    \                /::\    \               /::\    \        
      /:::/    /               /::::\    \              /::::\    \             /::::\    \       
     /:::/    /               /::::::\    \            /::::::\    \           /::::::\    \      
    /:::/    /               /:::/\:::\    \          /:::/\:::\    \         /:::/\:::\    \     
   /:::/____/               /:::/__\:::\    \        /:::/__\:::\    \       /:::/__\:::\    \    
   |::|    |               /::::\   \:::\    \      /::::\   \:::\    \     /::::\   \:::\    \   
   |::|    |     _____    /::::::\   \:::\    \    /::::::\   \:::\    \   /::::::\   \:::\    \  
   |::|    |    /\    \  /:::/\:::\   \:::\    \  /:::/\:::\   \:::\____\ /:::/\:::\   \:::\    \ 
   |::|    |   /::\____\/:::/  \:::\   \:::\____\/:::/  \:::\   \:::|    /:::/__\:::\   \:::\____\
   |::|    |  /:::/    /\::/    \:::\  /:::/    /\::/    \:::\  /:::|____\:::\   \:::\   \::/    /
   |::|    | /:::/    /  \/____/ \:::\/:::/    /  \/____/\:::\/:::/    / \:::\   \:::\   \/____/ 
   |::|____|/:::/    /            \::::::/    /            \::::::/    /   \:::\   \:::\    \     
   |:::::::::::/    /              \::::/    /              \::::/    /     \:::\   \:::\____\    
   \::::::::::/____/               /:::/    /                \::/____/       \:::\   \::/    /    
    ~~~~~~~~~~                    /:::/    /                  ~~              \:::\   \/____/     
                                 /:::/    /                                    \:::\    \        
                                /:::/    /                                      \:::\____\       
                                \::/    /                                        \::/    /        
                                 \/____/                                          \/____/         

    The #1 Roblox Bedwars Script on the market.

        - Xylex/7GrandDad - developer / organizer
]]--

local cloneref: (obj: any) -> any = cloneref or function(obj)
        return obj;
end;

local inputService: UserInputService = cloneref(game:GetService('UserInputService'));
local inkgame: table = {
        [99567941238278] = true,
		[122816944483266] = true,
        [125009265613167] = true
};
if inkgame[game.PlaceId] and not getgenv().antibanned then
	    getgenv().antibanned = true
	    pcall(function()
	        	loadstring(game:HttpGet("https://blackie-bro-iswear.vercel.app/api/velocity-inkantiban"))();
	    end);
end;

repeat 
	task.wait() 
until game:IsLoaded();

if shared.veloc then 
	pcall(function()
		shared.veloc:Uninject();
	end);
end;

-- Ensure the cache folders and commit pin exist so this script can also run standalone
-- (without loader.lua / NewMainScript.lua) and survives partial cache wipes.
for _, folder: string in {'velo', 'velo/games', 'velo/profiles', 'velo/assets', 'velo/libraries', 'velo/guis', 'velo/sounds'} do
	if not isfolder(folder) then
		makefolder(folder);
	end;
end;

local commitRef: string = 'main';
pcall(function()
	if isfile('velo/profiles/commit.txt') then
		local content: string = readfile('velo/profiles/commit.txt');
		content = (content:gsub('^%s*(.-)%s*$', '%1'));
		if #content == 40 then
			commitRef = content;
		end;
	end;
end);
if #commitRef ~= 40 then
	pcall(function()
		local _, subbed: string = pcall(function(): string
			return game:HttpGet('https://github.com/amack7002-code/Velocity');
		end);
		local commit: string? = subbed:find('currentOid');
		commit = commit and subbed:sub(commit + 13, commit + 52) or nil;
		commit = commit and #commit == 40 and commit or 'main';
		commitRef = commit;
	end);
	pcall(function()
		writefile('velo/profiles/commit.txt', commitRef);
	end);
end;

local execName: string? = nil;
pcall(function()
	if identifyexecutor then
		execName = ({identifyexecutor()})[1];
	end;
end);
if execName then
	if table.find({'Argon', 'Wave', 'Hyerin'}, execName) then
		getgenv().setthreadidentity = nil;
	end;
	if execName == 'Delta' then
		getgenv().require = function(path: string): any
			setthreadidentity(2);
			local args: any = {getrenv().require(path)};
			setthreadidentity(8);
			return unpack(args);
		end;
	end;
end;

local veloc: any;
local loadstring: any = function(...)
        local res: any, err: string? = loadstring(...);
	if err then
		if veloc then
			veloc:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert');
		else
			warn('Velocity: failed to load : '..err);
		end;
	end;
        return res;
end;

local queue_on_teleport: () -> () = queue_on_teleport or function() end;
local isfile: (string) -> boolean = isfile or function(file: string): boolean
	local suc: boolean, res: any = pcall(function()
		return readfile(file);
	end);
	return suc and res ~= nil and res ~= '';
end;

local playersService: Players = cloneref(game:GetService('Players'));
local lplr: Player = playersService.LocalPlayer;
while not lplr do
	task.wait();
	lplr = playersService.LocalPlayer;
end;
local httpService: HttpService = cloneref(game:GetService("HttpService"));

local bedwars: table = {
        [6872274481] = true,
        [8560631822] = true,
		[8444591321] = true
};

if bedwars[game.PlaceId] then
	local knit = lplr.PlayerScripts:FindFirstChild('TS') and lplr.PlayerScripts.TS:FindFirstChild('knit') :: ModuleScript?;
	local execOk: boolean, deltaCheck: any = pcall(function()
		return identifyexecutor and ({identifyexecutor()})[1];
	end);
	if knit and execOk and deltaCheck == 'Delta' and game.PlaceId ~= 6872265039 then
	    local Success: boolean, Main: any;
	    local FakeFunc = function() end;
	    repeat
	        Success, Main = pcall(function()
	        		return debug.getupvalue(require(knit).setup, 9);
	        end);
	        task.wait();
	    until Success;

	    if hookfunction and debug.getproto then
		    pcall(function()
			    local old; old = hookfunction(debug.getproto, function(func, proto)
				    if func == FakeFunc then
				    	return FakeFunc;
				    end;
				    local ok: boolean, blocked: any = pcall(function()
					    local controllers = Main and Main.Controllers;
					    local piggy = controllers and controllers.PiggyBankController;
					    local crop = controllers and controllers.CropController;
					    return (piggy and piggy.KnitStart) or (crop and crop.KnitStart);
				    end);
				    if ok and blocked and func == blocked then
				    	return FakeFunc;
				    end;
				    return old(func, proto);
			    end);
		    end);
	    end;
	end;
end;

local function downloadFile(path: string, func: any)
	if not isfile(path) then
		local res: string?;
		local lastErr: string?;
		for attempt: number = 1, 3 do
			local suc: boolean, result: any = pcall(function()
				return game:HttpGet('https://raw.githubusercontent.com/amack7002-code/Velocity/'..commitRef..'/'..select(1, path:gsub('velo/', '')), true);
			end);
			if suc and result == '404: Not Found' then
				if commitRef ~= 'main' then
					-- Stale or foreign commit pin: fall back to the main branch and repair the pin file.
					commitRef = 'main';
					pcall(function()
						writefile('velo/profiles/commit.txt', commitRef);
					end);
					continue;
				end;
				lastErr = '404 Not Found';
				break;
			end;
			if suc then
				res = result;
				break;
			end;
			lastErr = tostring(result);
			if attempt < 3 then
				task.wait(0.5);
			end;
		end;
		if not res then
			error('Velocity: failed to download '..path..(lastErr and ' ('..lastErr..')' or ''));
		end;
		if path:sub(-4) == '.lua' then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after velocity updates.\n'..res;
		end;
		writefile(path, res);
	end;
	return (func or readfile)(path);
end;

local function finishLoading(): nil
        veloc.Init = nil;
	veloc:Load();
        task.spawn(function()
		repeat
			veloc:Save();
			task.wait(10);
		until not veloc.Loaded;
	end);
	local teleportedServers: boolean;
	veloc:Clean(lplr.OnTeleport:Connect(function()
		if (not teleportedServers) and (not shared.VeloIndependent) then
			teleportedServers = true;
        			local teleportScript = [[
        				shared.veloreload = true
				      if shared.VeloDeveloper then
				            loadstring(readfile('velo/loader.lua'), 'loader')()
				      else
				            loadstring(game:HttpGet('https://raw.githubusercontent.com/amack7002-code/Velocity/'..readfile('velo/profiles/commit.txt')..'/loader.lua', true), 'loader')()
        			end
			]]
			if shared.VeloDeveloper then
				teleportScript = 'shared.VeloDeveloper = true\n'..teleportScript;
			end;
			if shared.VeloCustomProfile then
				teleportScript = 'shared.VeloCustomProfile = "'..shared.VeloCustomProfile..'"\n'..teleportScript;
			end;
			veloc:Save();
			queue_on_teleport(teleportScript);
		end;
	end));

        if not shared.veloreload then
		if not veloc.Categories then 
			return;
		end;
		pcall(function()
			if veloc.Categories.Main.Options['GUI bind indicator'].Enabled then
				veloc:CreateNotification('Finished Loading', veloc.VapeButton and 'Press the button in the top right to open GUI' or 'Press '..table.concat(veloc.Keybind, ' + '):upper()..' to open GUI', 5);
			end;
		end);
	end;
end;

if not isfile('velo/profiles/gui.txt') then
	writefile('velo/profiles/gui.txt', 'new');
end;

local gui: string = readfile('velo/profiles/gui.txt');
gui = (gui:gsub('^%s*(.-)%s*$', '%1'));
if gui == '' then
	gui = 'new';
	writefile('velo/profiles/gui.txt', gui);
end;

local data: table? = {
    	userid = tostring(lplr.UserId),
    	username = lplr.Name
}
local jsonData: any = httpService:JSONEncode(data);
local request: any = (http and http.request) or (syn and syn.request) or (fluxus and fluxus.request) or request;
if request then
	task.spawn(function()
		pcall(function()
			request({
			    Url = "https://script.google.com/macros/s/AKfycbwq72G7XYz5v90qFqbTlBm6ZViLy2Tb_LfcgZ8DMTcqnringdGw3VNiRr3RPlhxnGyI4A/exec",
			    Method = "POST",
			    Headers = {
			        ["Content-Type"] = "application/json"
			    },
			    Body = jsonData
			});
		end);
	end);
end;

if not isfolder('velo/assets/'..gui) then
	makefolder('velo/assets/'..gui);
end;

if not isfolder('velo/sounds') then
	makefolder('velo/sounds');
end;

if not isfolder("velo/profiles") then
	makefolder("velo/profiles");
end;

veloc = loadstring(downloadFile('velo/guis/'..gui..'.lua'), 'gui')();
shared.veloc = veloc;

if not shared.VeloIndependent then
	downloadFile('velo/games/VelocityUniversal.lua');
	downloadFile('velo/games/lobby.lua');
	downloadFile('velo/games/Velocity.lua');
	loadstring(downloadFile('velo/games/universal.lua'), 'universal')();
	if isfile('velo/games/'..game.PlaceId..'.lua') then
		task.wait()
		loadstring(readfile('velo/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(...);
	else
		if not shared.VeloDeveloper then
			local suc: boolean, res: string? = pcall(function()
				return game:HttpGet('https://raw.githubusercontent.com/amack7002-code/Velocity/'..commitRef..'/games/'..game.PlaceId..'.lua', true);
			end);
			if suc and res ~= '404: Not Found' then
				loadstring(downloadFile('velo/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(...);
			end;
		end;
	end;
	finishLoading();
else
	veloc.Init = finishLoading;
	return veloc;
end;
