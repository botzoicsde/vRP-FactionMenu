local htmlEntiteis = module("lib/htmlEntities")
local Tools = module("lib/Tools")

local function ch_invitagrad(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasGroup(user_id,"lider1") then
        vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
            id = parseInt(id)
            local target = vRP.getUserSource(id)
            vRP.addUserGroup(id,"factiune1")
            vRP.addUserGroup(id,"Grupa1")
                vRPclient.notify(player,{"~w~ L-ai adaugat in factiunea ~g~1 ~w~ pe ID:~g~ "..id})
                vRPclient.notify(target,{"~w~ Ai fost adaugat in factiunea ~g~1!"})
        end)
    end
end

local function ch_promveazagrad(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasGroup(user_id,"lider1") then
        vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
            id = parseInt(id)
            local target = vRP.getUserSource(id)
            if vRP.hasGroup(id,"Grupa1") then
                vRP.addUserGroup(id,"Grupa2")
					-- vRP.giveMoney(user_id,100)  /// IF YOU WANT TO GIVE THEM A LITTLE BONUS
					-- vRP.levelUp(user_id, group, aptitude) /// AVAILABLE FOR THE JOBS BASED ON EXPERIENCE
                    vRPclient.notify(player,{"~w~ L-ai promovat pe ID:~g~ "..id})
                    vRPclient.notify(target,{"~w~ Ai fost promovat!"})
            elseif vRP.hasGroup(id,"Grupa2") then
                vRP.addUserGroup(id,"Grupa3")
					-- vRP.giveMoney(user_id,100)  /// IF YOU WANT TO GIVE THEM A LITTLE BONUS
					-- vRP.levelUp(user_id, group, aptitude) /// AVAILABLE FOR THE JOBS BASED ON EXPERIENCE
                    vRPclient.notify(player,{"~w~ L-ai promovat pe ID:~g~ "..id})
                    vRPclient.notify(target,{"~w~ Ai fost promovat!"})
            else vRP.hasGroup(id,"Grupa3")
                vRPclient.notify(player,{"~w~ Este deja Co-Lider! ~w~ Nu ai cum sa il mai promovezi!"})
            end
        end)
    end
end

local function ch_retrogradeazagrad(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasGroup(user_id,"lider1") then
        vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
            id = parseInt(id)
            local target = vRP.getUserSource(id)
            if vRP.hasGroup(id,"Grupa3") then
                vRP.addUserGroup(id,"Grupa2")
                   vRPclient.notify(player,{"~w~ L-ai retrogradat pe ID:~g~ "..id})
                   vRPclient.notify(target,{"~w~ Ai fost retrogradat!"})
            elseif vRP.hasGroup(id,"Grupa2") then
                vRP.addUserGroup(id,"Grupa1")
                   vRPclient.notify(player,{"~w~ L-ai retrogradat pe ID:~g~ "..id})
                   vRPclient.notify(target,{"~w~ Ai fost retrogradat!"})
            else vRP.hasGroup(id,"Grupa1")
                vRP.addUserGroup(id,"Somer")
                vRP.removeUserGroup(id,"ems")
                   vRPclient.notify(player,{"~w~ L-ai dat afara din factiune pe ID:~g~ "..id})
                   vRPclient.notify(target,{"~w~ Ai fost demis! Fii mai activ data viitoare!"})
            end
        end)
    end
end


local function ch_excludegrad(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasGroup(user_id,"lider1") then
        vRP.prompt(player,"ID-ul jucatorului: ","",function(player,id)
            id = parseInt(id)
            local target = vRP.getUserSource(id)
			vRP.addUserGroup(id,"Somer")
                vRPclient.notify(player,{"~w~ L-ai dat afara din mafia ~g~1 ~w~ pe ID:~g~ "..id})
                vRPclient.notify(target,{"~r~ Ai fost dat afara din mafie!"})
        end)
    end
end


vRP.registerMenuBuilder("main", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
		if vRP.hasGroup(user_id,"lider") or vRP.hasGroup(user_id,"lider2")  then  -- ADD HOW MANY GROUPS DO YOU WANT
			local choices = {}

			choices["Meniu factiune"] = {function(player,choice)
				vRP.buildMenu("Lider", {player = player}, function(menu)
					menu.name = "Lider"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu(player) end

				if vRP.hasGroup(user_id,"lider1") then
					menu["Recruteaza"] = {ch_invitamedici}
				end
				if vRP.hasGroup(user_id,"lider1") then
					menu["Promoveaza"] = {ch_promveazamedici}
				end
				if vRP.hasGroup(user_id,"lider1") then
					menu["Retrogradeaza"] = {ch_retrogradeazamedici}
				end
				if vRP.hasGroup(user_id,"lider1") then
					menu["Exclude"] = {ch_excludecurcubeu}
		
				end
					vRP.openMenu(player,menu)
			end)
		end}
      add(choices)
	  end
    end
end)