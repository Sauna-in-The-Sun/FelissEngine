// Engine/Source/Runtime/Physics/Ballistics.cpp
class BallisticsSolver {
public:
    Vector3 calculateProjectilePath(
        Vector3 startPos, 
        Vector3 velocity,
        float mass,
        float dragCoefficient
    ) {
        // Calculate gravity and air drag
        Vector3 gravity = world->getGravity();
        Vector3 dragForce = -velocity.normalized() * 
                           (0.5f * airDensity * 
                           velocity.sqrMagnitude() * 
                           dragCoefficient);
                           
        // Verlet Integrate
        Vector3 newPos = startPos + velocity * dt;
        velocity += (gravity + dragForce / mass) * dt;
        
        return newPos;
    }
};