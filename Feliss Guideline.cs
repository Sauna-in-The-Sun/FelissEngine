// Engine/Source/Editor/VisualScripting/FelissGuideline.cs
public class VisualNodeSystem {
    public Node CreateShootingMechanic() {
        var node = new Node("Player Shooting");
        node.AddInput("Fire Button");
        node.AddOutput("Spawn Projectile");
        node.AddLogic(() => {
            if(Input.GetButton("Fire")) {
                Instantiate(bulletPrefab);
            }
        });
        return node;
    }
}