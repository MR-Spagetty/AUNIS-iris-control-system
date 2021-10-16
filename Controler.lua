local event = require("event")
local c = require("component")
local modem = c.modem
local sg = c.stargate

local idcs = {'test idc'}

local function CloseIris(...)
    if sg.getIrisState() ~= 'CLOSED' then
        sg.toggleIris()
    end
end

local function OpenIris(...)
    if sg.getIrisState() ~= 'OPENED' then
        sg.toggleIris()
    end
end

local function CheckIDC(incomingIDC)
    for idc in idcs do
        if incomingIDC == idc then
            OpenIris()
        end
    end
end

local function IDCIn(_, _, _, _, _, idc, ...)
    CheckIDC(idc)
end

event.listen('stargate_open', CloseIris)
event.listen('stargate_close', OpenIris)
event.listen('modem_message', IDCIn)