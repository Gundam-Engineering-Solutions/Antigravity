Technical Specification: Hull Assembly 1.0
==========================================

Dielectric Isolation Strategy
-----------------------------

To maintain the 98 Coulomb charge differential required for lift, the dorsal (top) and ventral (bottom) plates must be electrically isolated.

-   **Material:** The central separator plate is composed of a high-breakdown dielectric (e.g., PTFE or glazed ceramic).

-   **Thickness:** 5mm minimum to prevent dielectric breakdown under high-voltage grid charging.

-   **Seal:** The edges where plates meet must be sealed with a silicone-based dielectric grease to prevent "leakage" (arcing) into the atmosphere.

Bolt & Fastener Pattern
-----------------------

Each of the 360 segments is an independent structural element. This modularity allows for:

1.  **Damage Control:** If a segment overloads or cracks, it can be ejected or replaced without compromising the whole ship.

2.  **Mounting:**

    -   **Outer Radius Bolt:** M10 Titanium bolt (non-magnetic) at `r = ship_radius - 20mm`.

    -   **Inner Radius Bolt:** M10 Titanium bolt at `r = hub_radius + 20mm`.

    -   **Washers:** Nylon insulating washers must be used to ensure the bolt does not create a short circuit between the top and bottom plates.

Snap Circuit Integration
------------------------

-   **Feed Points:** The "spider crab" power distribution is replaced by a Snap Circuit bus ring located in the **Hub (Center)**.

-   **Wiring:** High-gauge leads run from the central hub, through the dielectric layer, connecting to the *center* of each plate segment to ensure even charge distribution.