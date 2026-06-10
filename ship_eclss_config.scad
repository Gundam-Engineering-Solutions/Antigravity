import os

def generate_cad_eclss_profile(ship_name, crew_count, mission_hours):
    # --- 1. Metabolic & Hardware Constants ---
    VO2_HIGH_EXERTION = 2.5        # Liters of O2 consumed per minute under stress
    SAFETY_FACTOR = 1.3            # 30% emergency supply cushion
    TANK_PRESSURE_BAR = 207        # Standard OXYMOSS system baseline (~3,000 PSI)
    TANK_PHYSICAL_VOLUME_L = 6.8    # Standard high-pressure carbon composite cylinder size

    # --- 2. Calculate Total Tank Volume ---
    total_minutes = mission_hours * 60
    uncompressed_volume_needed = crew_count * VO2_HIGH_EXERTION * total_minutes * SAFETY_FACTOR
    gas_volume_per_tank = TANK_PHYSICAL_VOLUME_L * TANK_PRESSURE_BAR
    tanks_needed = int(-(-uncompressed_volume_needed // gas_volume_per_tank)) # Ceiling division

    # --- 3. Determine Optimum Geometric Layout Configuration ---
    # Formula for available inner Oxygen nodes inside our specific hull design:
    # Available O2 Nodes per tier = 3 * (rings^2) - 3 * rings (accounting for center hollow & outer water ring)
    
    grid_rings = 2  # Hard minimum size constraint
    while True:
        nodes_per_layer = 3 * (grid_rings ** 2) - (3 * grid_rings)
        if nodes_per_layer >= tanks_needed or grid_rings >= 5: 
            break
        grid_rings += 1

    # If the ship requires more cylinders than a single layer cap allows (rings=5), stack them vertically
    nodes_per_layer = 3 * (grid_rings ** 2) - (3 * grid_rings)
    z_layers = int(-(-tanks_needed // nodes_per_layer))

    # --- 4. Generate and Export the OpenSCAD Config Code Data Block ---
    scad_config_content = f"""// =================================================================
// AUTOMATICALLY GENERATED ENVIRONMENTAL CONTROL LIFE SUPPORT CONFIG
// TARGET TARGET HULL: {ship_name}
// =================================================================

// Calculated Tank Target Requirements: {tanks_needed} Cylinders
GRID_RINGS_COUNT = {grid_rings};  // Radius step scaling for the honeycomb grid
VERTICAL_STACKS  = {z_layers};   // Dynamic multiplier for multi-tier stacking
MODULE_DIAMETER  = 160;         // Structural cylinder housing diameter (mm)
CELL_HEIGHT      = 50;          // Single segment deck plate clearance thickness (mm)

// Verification Log Metrics:
// Crew Matrix Headcount: {crew_count} Active Personnel
// Sustained Lifespan Window: {mission_hours} Operation Hours
// Calculated System Load Mass: {(uncompressed_volume_needed * 1.429) / 1000.0:.2f} kg pure O2 Gas Vol.
"""

    # Save data array parameters out to the shared local OpenSCAD engine workspace directory
    filename = "ship_eclss_config.scad"
    with open(filename, "w") as file:
        file.write(scad_config_content)
        
    print(f" SUCCESS: Scaled config file generated for [{ship_name}].")
    print(f" -> Tanks Demanded: {tanks_needed} | Configured Grid Rings: {grid_rings} | Deck Stacks: {z_layers}\n")

# --- EXECUTE AUTO-GENERATION RUN FOR YOUR SHIPS ---
generate_cad_eclss_profile("RECON_ALPHA", crew_count=4, mission_hours=48)
generate_cad_eclss_profile("FRIGATE_BRAVO", crew_count=12, mission_hours=72)
generate_cad_eclss_profile("CAPITAL_OMEGA", crew_count=40, mission_hours=168)
