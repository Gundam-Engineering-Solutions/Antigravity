# Antigravity
### GitHub Repository: Gundam Robotics Systems / Type-S-Anti-Gravity

Gundam Robotics Systems: Type-S (Saiya) Anti-Gravity Platform
=============================================================

1\. Project Overview
--------------------

**Gundam Robotics Systems** is developing a proprietary electrostatic displacement vessel. The "Type-S" (Saiya) configuration utilizes a 360-degree segmented disc architecture to achieve lift via high-magnitude electrostatic repulsion.

By mimicking the Earth's natural electric field (net negative), the Type-S platform generates lift without traditional combustion or aerodynamic control surfaces.

2\. Core Physics & Mechanism
----------------------------

The system operates on the principle of **Like-Charge Repulsion**:

-   **The Environment:** Earth maintains a global negative charge with a downward-pointing electric field.

-   **The Vessel:** The ship's hull is charged to an extreme negative potential, creating a repulsive force against the planet's surface.

-   **The Lift Equation:** To lift a metric ton, the system maintains a static charge of approximately **98 Coulombs** (variable based on altitude and hull surface area).

3\. The Type-S "Saiya" Design
-----------------------------

Unlike previous (way too advanced for this github archive) "Arrow" prototypes, the Type-S utilizes a balanced, circular geometry for simplified plate design and omnidirectional stability.

-   **Structure:** Two primary hull plates (Dorsal/Ventral) sealed and bolted with a central dielectric separator plate.

-   **Segmentation:** The disc is divided into **360 individual plate segments**.

-   **Steering:** flight control is achieved not by moving flaps, but by rotating the charge density around the 360-degree array using the ship's flight computer.

4\. Power & Charging Architecture
---------------------------------

**Gundam Robotics Systems** has deprecated the onboard "Spider Crab" nuclear reactor model in favor of a "Grid-to-Hull" charging protocol.

-   **Source:** High-Voltage AC tapped directly from power substations.

-   **Bus System:** Internal routing via modular **Snap Circuit** high-voltage buses.

-   **Rectification:** A custom rectifier array strips positive pulses, delivering only negative electron saturation to the ventral plates.

-   **Storage:** The hull plates function as high-capacity **Electrets**, capable of holding the mimicked charge after disconnection from the grid.

5\. Development Roadmap
-----------------------

-   **Phase 1:** Concept Validation & Physics (Complete)

-   **Phase 2:** OpenSCAD Modeling of the 360-plate Saiya Chassis (**Current Focus**)

-   **Phase 3:** Gemini-assisted Documentation Generation

-   **Phase 4:** Prototype "Snap Circuit" Bus Fabrication

6\. Mathematical Foundations & Physics
--------------------------------------

The Type-S Saiya platform utilizes high-magnitude electrostatic displacement combined with dynamic charge routing to achieve both lift and anomalous maneuverability. The flight control system calculates required plate saturation in real-time based on the following physical principles:

-   **Electrostatic Lift (Hover & Ascent)** 
To counteract Earth's gravitational pull, the ventral plates must generate a repulsive electrostatic force ($F_e$) equal to or greater than the vessel's gravitational downward force ($F_g$). 

$$F_g = m \cdot g$$
$$F_e = q \cdot E$$

Where:
* $m$ = Mass of the vessel (e.g., $1,000 \text{ kg}$)
* $g$ = Acceleration due to gravity ($9.8 \text{ m/s}^2$)
* $q$ = Total electrostatic charge on the ventral hull (Coulombs)
* $E$ = Earth's surface electric field (approx. $100 \text{ N/C}$)

To achieve a stable hover for a 1-metric-ton chassis, the required continuous static charge is calculated as:
$$q = \frac{m \cdot g}{E} = \frac{9,800 \text{ N}}{100 \text{ N/C}} = 98 \text{ Coulombs}$$

-   **Omnidirectional Maneuverability (The Zig-Zag)**
Traditional aircraft bank to turn, relying on aerodynamic lift. The Type-S array achieves horizontal translation and sharp trajectory changes by instantly altering the charge density across specific quadrants of the 360-degree plate ring, creating a localized asymmetric repulsion vector.

For extreme right-angle or hypersonic turns, the required centripetal acceleration ($a_c$) dictates the necessary charge bias applied to the leading plates:

$$a_c = \frac{v^2}{r}$$

Where $v$ is the horizontal velocity and $r$ is the turning radius. 

-   **Fluid Dynamic Mitigation (Trans-Medium Travel)**
By projecting the electrostatic field slightly ahead of the physical hull boundaries, the system mitigates boundary layer drag during atmospheric or aquatic translation, minimizing the standard drag force:

$$F_D = \frac{1}{2} \rho v^2 C_D A$$

By effectively reducing the fluid density ($\rho$) immediately surrounding the hull via ionization, the vessel bypasses typical aerodynamic thermal signatures.

7\. References
--------------

-   **Design Inspiration:** [Saiyan Medical Assistance Fleet Support Vessel](https://www.youtube.com/watch?v=sjL1deIIvMk)

* * * * *

### Next Steps: OpenSCAD & Docs

We are now ready to move to the **Gemini Integration Phase**.

-   **Documentation:** We will generate full technical specs for the plate bolt patterns and dielectric seals.

-   **SCAD Files:** We will write the OpenSCAD script to generate the 360-segment ring and the central separator plate.
