# Theoretical Framework: Physics, Chemistry, and Mathematics

## 1. Abstract
This document outlines the theoretical principles governing the Gundam Robotics Systems -12 Electromagnetic Actuator (EMA). It details the High-Energy-Density (HED) plasma chemistry used for air solidification, the electrodynamics of the Lorentz-force ejection, and the thermomechanical stress models applied to the synthetic fused silica core.

---

## 2. Electrodynamics & Maxwell-Force Ejection

The primary actuation mechanism replaces hydraulic fluid pressure with an electromagnetic volumetric force density applied to a strongly coupled plasma armature.

### 2.1 Magnetic Flux Density ($B$)
The 4-layer Bitter-style stack acts as a high-density solenoid. The magnetic flux density along the central axis of the 150mm coil is approximated by:

$$B = \mu_0 \mu_r \left( \frac{N}{L_c} \right) I$$

Where:
* $\mu_0$ = Vacuum permeability ($4\pi \times 10^{-7} \, \text{T}\cdot\text{m/A}$)
* $\mu_r$ = Relative permeability of the soft iron core boundary
* $N$ = Total turns (320)
* $L_c$ = Coil length (0.15 m)
* $I$ = Current (5 A at 48V)

### 2.2 Macroscopic Lorentz Force
The ejection of the plasma piston is governed by the macroscopic Lorentz force (Maxwell force density), $\mathbf{f}$:

$$\mathbf{f} = \mathbf{J} \times \mathbf{B}$$

Where $\mathbf{J}$ is the induced current density within the plasma volume. The total integrated force ($\mathbf{F}$) acting on the piston head of area $A$ dictates the mechanical equivalent of hydraulic pressure ($P_{eq}$):

$$P_{eq} = \frac{1}{A} \int_V (\mathbf{J} \times \mathbf{B}) \, dV$$

---

## 3. High-Energy-Density (HED) Plasma Chemistry

The actuator utilizes a high-amplitude UV flash to transition the dry air within the 3/4" bore into a "solid" strongly coupled plasma.

### 3.1 Photoionization Thresholds
To strip electrons from diatomic atmospheric gases, the UV photon energy ($E = h\nu$) must exceed the ionization energies ($E_i$):
* $N_2 \rightarrow N_2^+ + e^-$ ($E_i \approx 15.58 \text{ eV}$, requiring $\lambda < 79.6 \text{ nm}$)
* $O_2 \rightarrow O_2^+ + e^-$ ($E_i \approx 12.07 \text{ eV}$, requiring $\lambda < 102.7 \text{ nm}$)

*Note: The high-amplitude nature of the UV array induces multi-photon ionization, allowing longer deep-UV wavelengths to achieve instantaneous breakdown.*

### 3.2 The "Solid Plasma" State (Strong Coupling Parameter)
The plasma behaves as a solid, incompressible piston when the electrostatic potential energy between adjacent ions significantly exceeds their thermal kinetic energy. This is defined by the Coulomb coupling parameter ($\Gamma$):

$$\Gamma = \frac{Z^2 e^2}{4 \pi \epsilon_0 a k_B T}$$

Where:
* $Z$ = Ionization state
* $e$ = Elementary charge
* $a$ = Wigner-Seitz radius (inter-ion distance)
* $k_B T$ = Thermal energy

For the Gundam Robotics Systems actuator, the $5\mu\text{s}$ UV pulse must compress the volume such that **$\Gamma > 1$** (specifically approaching $\Gamma \approx 170$ for crystallization into a Wigner solid lattice).

### 3.3 Parasitic Ozone ($O_3$) Generation
A secondary chemical reaction during the UV flash is the photodissociation of oxygen, leading to ozone synthesis. This requires the use of Fused Silica and Carbon-filled PTFE seals to prevent oxidation degradation.

1. $O_2 + h\nu \rightarrow 2O \quad (\lambda < 242 \text{ nm})$
2. $O + O_2 + M \rightarrow O_3 + M \quad (\text{where } M \text{ is } N_2 \text{ or } O_2)$

---

## 4. Thermomechanical Stress Modeling

The 19.05 mm (3/4") Fused Silica liner must survive the impulsive shock of the Maxwell force ejection, mapping to ASME Section VIII burst tolerances.

### 4.1 Hoop Stress ($\sigma_h$)
The internal radial pressure from the strongly coupled plasma exerts a uniform hoop stress on the brittle fused silica tube:

$$\sigma_h = \frac{P_i r_i - P_o r_o}{r_o - r_i}$$

Because fused silica lacks a ductile yield point, the exoskeleton applies an external compressive pre-stress ($P_o \gg P_{atm}$) via a Carbon Fiber/Titanium overwrap. The system is safe from fracture as long as the net hoop stress remains negative (compressive) during the $5\mu\text{s}$ peak internal pressure ($P_i$).

### 4.2 Thermal Shock Resistance
The maximum allowable temperature gradient ($\Delta T_{max}$) before thermal fracture is dictated by the Biot number and the material properties:

$$\Delta T_{max} = \frac{\sigma_f (1 - \nu)}{E \alpha}$$

Where:
* $\sigma_f$ = Tensile strength of Fused Silica (~50 MPa)
* $\nu$ = Poisson's ratio (0.17)
* $E$ = Young's modulus (72 GPa)
* $\alpha$ = Coefficient of Thermal Expansion ($0.55 \times 10^{-6} \, \text{K}^{-1}$)

Due to the uniquely low $\alpha$ of Fused Silica, $\Delta T_{max}$ is exceptionally high, allowing the liner to survive the localized thermal spike of the plasma formation.

---

## 5. Pulse Power Circuit Mathematics

The synchronization of the $5\mu\text{s}$ pulse relies on the RLC response characteristics of the 48V/5A power network.

### 5.1 Inductive Current Rise Time
For the Bitter-stack to reach peak magnetic flux density within the required window, the current $I(t)$ must overcome the coil's inductance ($L$):

$$I(t) = \frac{V}{R} \left( 1 - e^{-\frac{R}{L}t} \right)$$

The FPGA logic must pre-trigger the high-side SiC MOSFET based on the time constant $\tau = L/R$, ensuring that maximum $I_{peak}$ aligns precisely with the UV solid-plasma transition at $t = +1\mu\text{s}$.
