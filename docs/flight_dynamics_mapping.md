# Flight Control & EMA Pulse Mapping

## 1. Kinematic Translation
When the Antigravity EMA is deployed as a flight control surface actuator or direct thrust mechanism, its 100mm operational stroke must be mapped to the aerodynamic models within BAK.

The module `aviation_physics.py` calculates the required Newtons of force to execute a maneuver. This is mapped directly to the FPGA Pulse Forming Network (PFN):
* **High-Force Maneuvers:** Requires maximum plasma density. The FPGA is instructed to utilize the full 5A current across the 4-layer Bitter stack.
* **Feathered/Micro-Adjustments:** The BAK control loop requests a shortened pulse width, triggering the SiC MOSFETs to terminate the magnetic ejection prior to the standard $5\mu\text{s}$ threshold, resulting in a partial stroke.

## 2. Atmospheric Entry & Thermal Throttling
During extreme operational phases, the Fused Silica chamber is subjected to both internal plasma heat and external aerodynamic friction.
* **The Override:** The `atmospheric_entry_controller.py` module continually monitors external temperatures and velocities.
* **Thermal Mitigation:** If exterior heating exceeds safety margins, BAK will automatically throttle the Antigravity 48V power supply. It expands the pulse window and increases the duty cycle of the vane-axial cooling fans to preserve the pre-stressed integrity of the Fused Silica liner.

## 3. Environmental Synchronization
The solid-plasma transition relies on the photoionization of ambient air. BAK provides critical atmospheric data to adjust the UV flash parameters in real-time:
* **Air Density:** Data from `sfo_model.py` and `sea_model.py` informs the FPGA of the current barometric pressure. At high altitudes (lower density), BAK instructs the UV array to increase amplitude to achieve the required $\Gamma > 1$ (Strong Coupling Parameter) for plasma solidification.
* **Moisture/Icing:** The `aviation_icing.py` and `fog_thermodynamics.py` modules detect wet ambient air. To prevent UV-induced water droplet or ice particle formation inside the chamber, BAK will preemptively activate the desiccant manifold heaters.
