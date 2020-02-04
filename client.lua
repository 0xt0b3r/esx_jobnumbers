local JobCount = {}


Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	TriggerServerEvent('esx_jobnumbers:setjobs', job)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('esx_jobnumbers:setjobs', xPlayer.job)
end)


RegisterNetEvent('esx_jobnumbers:setjobs')
AddEventHandler('esx_jobnumbers:setjobs', function(jobslist)
   JobCount = jobslist
end)

  -- uncomment this if you want to make sure the script is updating   just use command /jobonline jobname

  RegisterCommand('jobonline', function(source, args, rawCommand)
    local jobname = args[1]
    if args[1] ~= 'all' then
        print('This is how many '.. tostring(args[1]) ..' are online: '..  tostring(exports["esx_jobnumbers"]:jobonline(jobname)))
    else
        print('Staring print List')
        for i,v in pairs(JobCount) do
            print('Name: '.. tostring(i).. ' - '.. tostring(v))
        end
        print('Ending print List')
    end
end)


function jobonline(joblist)
    for i,v in pairs(Config.MultiNameJobs) do
        for u,c in pairs(v) do
            if c == joblist then
                joblist = i
            end
        end
    end

    local amount = 0
    local job = joblist
    if JobCount[job] ~= nil then
        amount = JobCount[job]
    end

    return amount
end


