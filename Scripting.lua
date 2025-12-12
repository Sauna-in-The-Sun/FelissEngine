-- FelissScript/LuaScripting.lua

local LuaScriptingEngine = {}
LuaScriptingEngine.__index = LuaScriptingEngine

function LuaScriptingEngine.new()
    local self = setmetatable({}, LuaScriptingEngine)
    self.loadedScripts = {}
    self.globals = {}
    return self
end

function LuaScriptingEngine:LoadScript(path)
    local chunk, err = loadfile(path)
    if not chunk then
        self:ReportErrors("Load error: " .. tostring(err))
        return false
    end
    
    local success, result = pcall(chunk)
    if not success then
        self:ReportErrors("Execution error: " .. tostring(result))
        return false
    end
    
    self.loadedScripts[path] = result or _G
    return true
end

function LuaScriptingEngine:CallFunction(funcName)
    local func = _G[funcName]
    if type(func) == "function" then
        local success, err = pcall(func)
        if not success then
            self:ReportErrors("Function call error: " .. tostring(err))
        end
    end
end

function LuaScriptingEngine:SetGlobal(name, value)
    _G[name] = value
    self.globals[name] = value
end

function LuaScriptingEngine:ReportErrors(msg)
    io.stderr:write("[Lua Error] " .. msg .. "\n")
end

-- ScriptComponent
local ScriptComponent = {}
ScriptComponent.__index = ScriptComponent

function ScriptComponent.new(path)
    local self = setmetatable({}, ScriptComponent)
    self.scriptPath = path
    self.engine = LuaScriptingEngine.new()
    return self
end

function ScriptComponent:OnCreate()
    self.engine:LoadScript(self.scriptPath)
    self.engine:CallFunction("OnCreate")
end

function ScriptComponent:OnUpdate(dt)
    self.engine:SetGlobal("deltaTime", dt)
    self.engine:CallFunction("OnUpdate")
end

return {
    LuaScriptingEngine = LuaScriptingEngine,
    ScriptComponent = ScriptComponent
}