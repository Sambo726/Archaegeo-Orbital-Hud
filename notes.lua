HeadlightGroundHeight = 150 --export: (Default: 150) Controls altitude to turn on/off Headlights. Turns off above value

local navBlinkSwitch = nil
local navLightSwitch = nil
local headLightSwitch = nil
local fuelDisplaySwitch = nil

function SetupChecks()
    if switch then 
        for _, v in pairs(switch) do
            local eID = v.getId()
            local name = core.getElementNameById(eID)
            if (name == "navBlinkSwitch") then
                navBlinkSwitch = v
            elseif (name == "navLightSwitch") then
                navLightSwitch = v
            elseif (name == "headLightSwitch") then
                headLightSwitch = v
            elseif (name == "fuelDisplaySwitch") then
                fuelDisplaySwitch = v
            else
                v.toggle()
            end
        end
    end    
    
end

function script.onStart()
    beginSetup = coroutine.create(function()
        navLightSwitch.activate()
        headLightSwitch.activate()
        fuelDisplaySwitch.activate()
    end)
end

function script.onStop()
    navLightSwitch.deactivate()
    fuelDisplaySwitch.deactivate()
end

function script.onTick(timerId)
    if timerId == "tenthSecond" then
        navBlinkSwitch.deactivate()
    elseif timerId == "oneSecond" then
        navBlinkSwitch.activate()
    elseif timerId == "apTick" then
        if (groundHeight < HeadlightGroundHeight) then
            headLightSwitch.activate()
        else
            headLightSwitch.deactivate()
        end
    end
end