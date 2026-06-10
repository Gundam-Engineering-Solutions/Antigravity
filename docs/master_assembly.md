# Master Assembly Architecture

**Component:** `assembly.scad`
**System:** Gundam Robotics Systems - Type-S (Saiya) Anti-Gravity Platform
**Author:** Dr. Correo Hofstad

## 1. System Overview

The `assembly.scad` file serves as the top-level 3D visualization and integration environment for the Type-S (Saiya) Anti-Gravity Platform. It is not intended for direct 3D printing or CNC machining as a single piece; rather, it imports the individual, modular subsystem files and renders them in their final flight configurations.

This file acts as the primary visual reference for engineers to verify component clearances, wiring pathways, and structural alignment before physical fabrication.

## 2. Integrated Subsystems

The master assembly brings together three primary architectural modules using OpenSCAD's `use <...>` directive:

### 2.1 The Hull Assembly (`type_s_saiya.scad`)
The main electrostatic displacement ring responsible for lift and maneuvering.
* **Ventral (Bottom) Plates:** The primary negative-charge repulsive array.
* **Dielectric Separator:** A 5mm insulating layer to prevent arcing and charge equalization between the upper and lower hull surfaces.
* **Dorsal (Top) Plates:** Configurable for neutral or positive atmospheric attraction (Ion Wind assistance).

### 2.2 The Central Power Hub (`central_hub_saiya.scad`)
The avionics and power routing core located in the center void of the hull ring.
* **Main Chassis:** Houses the avionics bay and high-voltage cable ports linking to the 360-segment hull.
* **Snap Circuit Grid:** The internal floor formatted to accept standardized Snap Circuit components for modular power routing.
* **Latch Gate Slot:** The precision mount for the CRIPS Double Latch Gate Buffer, which regulates the negative electron pulses from the grid.

### 2.3 The Jamoni Master Crystal (`crystal_sc_cut.scad`)
The quantum entanglement and timing core of the vessel.
* Suspended within the **Pressurized Crystal Timing Chamber** at the exact center of the hub.
* Houses the quartz disk, electrodes, and a stress-free mount to maintain the integrity of the covalent bonds required for trans-distance quantum network signaling.

## 3. Developer Tools & Visualization

To assist with internal inspection and diagnostic rendering, `assembly.scad` features built-in visualization logic:

### The Cutaway View
By altering the boolean variable at the top of the script, developers can slice the entire rendered ship in half along the Y-axis.

```openscad
enable_cutaway = true; // Set to true to slice the ship in half for internal inspection
