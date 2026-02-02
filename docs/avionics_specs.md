# Avionics Bay Specifications (Type-S Server Core)

## Overview
The Type-S Central Hub has been upgraded to a **Class-4 Data Center Module**. While flight control is handled remotely via Quantum Networking (Snap Circuit Interface), the onboard systems provide **Redundant Planetary Logging** in the event of total ground-side data destruction.

## Rack Configuration
* **Form Factor:** Universal ATX Blade System.
* **Compatibility:** Supports Standard ATX, Micro-ATX, and E-ATX ($305 \times 330$mm) server boards.
* **Orientation:** Vertical Radial Mounts (3 Blades standard, expandable to 6).
* **Cooling:** Passive convective venting through hull slots.

## Storage Array ("The Wall")
* **Purpose:** Black-box logging of ship telemetry and local environmental data.
* **Capacity:** * 6x High-Density M.2 Banks.
    * 18x 2.5" SSD Hot-Swap Bays.
* **Interface:** Hexadecimal Coded SSDs (via PCIe risers to the ATX blades).

## Power Distribution
* **AC Routing:** Three shielded vertical conduits carry high-voltage AC from the Rectifier to the Snap Circuit floor.
* **Isolation:** Data lines (ATX/SSD) are physically separated from AC conduits by the blade geometry to prevent interference.
