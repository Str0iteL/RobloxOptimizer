# RobloxOptimizer

This script is designed to optimize the performance of Roblox games by reducing graphical and computational load. It is ideal for improving the performance of the game on low-end devices by disabling unnecessary features, such as textures, lighting effects, particles, sounds, animations, and physics.

## Features:
- **Texture Removal:** Replaces all textures with blank ones to reduce graphical load.
- **Lighting Optimization:** Removes unnecessary objects from the `Lighting` service, disables global shadows, reduces ambient lighting to the minimum, removes the skybox, and sets the lowest quality level for graphics.
- **Particle Disabling:** Disables all particle effects (`ParticleEmitter`) to improve performance.
- **Sound Disabling:** Sets the volume of all sounds to zero, effectively muting them.
- **Service Disabling:** Disables `StarterGui` and clears the `ReplicatedStorage` to minimize resource usage.
- **Object Hiding:** Hides all parts and mesh parts in the game and disables their collisions to reduce unnecessary calculations.
- **Animation Stopping:** Stops all running animations to free up resources.
- **Camera Removal:** Destroys all cameras in the game to reduce unnecessary processing.
- **Physics Disabling:** Disables physics on all objects not interacting with the player by setting them to `Anchored`.
- **Distance-Based Lighting Optimization:** Reduces lighting and material quality for objects far away from the player (over 1000 units), improving performance for distant objects.

## Usage:
1. Add the script to your game.
2. When the game runs, it will automatically apply the optimizations listed above.
3. The script continuously runs in the background with a short interval (0.1 seconds) to ensure the game remains optimized during gameplay.

## Requirements:
- The script works with Roblox Studio and requires the `LocalPlayer` and `Workspace` services to be accessible.
- It is best suited for games where performance optimization is needed, especially on lower-end devices.

## License:
This script is licensed for **non-commercial use only**. Redistribution is allowed, but the repository link **must** be included in any usage or distribution of the script.

Repository link:  
[https://github.com/Str0iteL/RobloxOptimizer/tree/main](https://github.com/Str0iteL/RobloxOptimizer/tree/main)

## Disclaimer:
This script is not responsible for any potential issues or crashes that may occur due to improper use. Use at your own risk. The author does not provide any support for modifying or extending the script.
