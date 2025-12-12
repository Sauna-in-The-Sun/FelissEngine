local json = require("dkjson") 

local SceneSerializer = {}

function SceneSerializer.SaveScene(scene, filepath)
    local jscene = {
        entities = {}
    }
    
    for id, entity in pairs(scene:GetAllEntities()) do
        local jent = {
            id = entity.id,
            name = entity.name,
            position = {
                entity.transform.position[1],
                entity.transform.position[2],
                entity.transform.position[3]
            },
            rotation = {
                entity.transform.rotation[1],
                entity.transform.rotation[2],
                entity.transform.rotation[3]
            },
            scale = {
                entity.transform.scale[1],
                entity.transform.scale[2],
                entity.transform.scale[3]
            }
        }
        
        -- Check for MeshComponent
        local mesh = entity:GetComponent("MeshComponent")
        if mesh then
            jent.mesh = mesh.meshPath
        end
        
        -- Check for RigidBodyComponent
        local rb = entity:GetComponent("RigidBodyComponent")
        if rb then
            jent.rigidbody = {
                mass = rb.mass,
                isStatic = rb.isStatic
            }
        end
        
        table.insert(jscene.entities, jent)
    end
    
    -- Write to file
    local file = io.open(filepath, "w")
    if file then
        local encoded = json.encode(jscene, { indent = true })
        file:write(encoded)
        file:close()
    end
end

function SceneSerializer.LoadScene(scene, filepath)
    local file = io.open(filepath, "r")
    if not file then
        return
    end
    
    local content = file:read("*all")
    file:close()
    
    local jscene = json.decode(content)
    if not jscene then
        return
    end
    
    scene:Clear()
    
    for _, jent in ipairs(jscene.entities) do
        local id = scene:CreateEntity(jent.name)
        local e = scene:GetEntity(id)
        
        -- Set transform
        for i = 1, 3 do
            e.transform.position[i] = jent.position[i]
            e.transform.rotation[i] = jent.rotation[i]
            e.transform.scale[i] = jent.scale[i]
        end
        
        -- Add MeshComponent if exists
        if jent.mesh then
            local mesh = {
                meshPath = jent.mesh
            }
            e:AddComponent("MeshComponent", mesh)
        end
        
        -- Add RigidBodyComponent if exists
        if jent.rigidbody then
            local rb = {
                mass = jent.rigidbody.mass,
                isStatic = jent.rigidbody.isStatic
            }
            e:AddComponent("RigidBodyComponent", rb)
        end
    end
end

return SceneSerializer