#pragma once

#include <unordered_map>
#include <string>
#include <memory>
#include <vector>
#include "MeshComponent.h"
#include "RigidBodyComponent.h"

using EntityID = uint64_t;

struct Transform {
    float position[3] = {0, 0, 0};
    float rotation[3] = {0, 0, 0};
    float scale[3]    = {1, 1, 1};
};

struct Entity {
    EntityID id;
    std::string name;
    Transform transform;

    std::shared_ptr<FelissComponents::MeshComponent> mesh;
    std::shared_ptr<FelissComponents::RigidBodyComponent> rigidbody;
};

class Scene {
private:
    std::unordered_map<EntityID, Entity> entities;
    EntityID nextID = 1;

public:
    EntityID CreateEntity(const std::string& name) {
        Entity ent;
        ent.id = nextID++;
        ent.name = name;
        entities[ent.id] = ent;
        return ent.id;
    }

    Entity* GetEntity(EntityID id) {
        auto it = entities.find(id);
        if (it != entities.end()) return &it->second;
        return nullptr;
    }

    const auto& GetAllEntities() const { return entities; }

    void Clear() { entities.clear(); nextID = 1; }

    void DispatchToRenderAndPhysics(class FelissRenderer::Renderer* renderer,
                                    class PhysicsWorld* physics) {
        for (auto& [id, ent] : entities) {
            if (ent.mesh) {
                renderer->RegisterMesh(ent.id, ent.mesh->meshPath);
            }
            if (ent.rigidbody) {
                physics->AddBody(ent.id, ent.transform.position, ent.rigidbody->mass, ent.rigidbody->isStatic);
            }
        }
    }
};
