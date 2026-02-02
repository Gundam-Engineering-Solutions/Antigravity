// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// Component: Central Data Core (Server Grade) - v4
// Update: REMOVED printed standoffs. Added clearance holes for Brass Standoffs.

// --- Global Parameters ---
hub_diameter = 600;       
hub_height = 350;         
snap_grid_spacing = 15;   
crystal_chamber_r = 20;

// --- ATX Standards (in mm) ---
atx_holes = [
    [0, 0], [0, 154], [0, 280],       // Column A
    [120, 0], [120, 154], [120, 280], // Column B
    [220, 0], [220, 154], [220, 280], // Column C
    [310, 0], [310, 154], [310, 280]  // Column D
];

// --- Modules ---

module atx_blade_mount() {
    difference() {
        cube([340, 310, 5]); 
        for (pos = atx_holes) {
            translate([pos[0] + 10, pos[1] + 10, -1])
            cylinder(r=2, h=10, $fn=20); // 4mm holes for standoffs
        }
        // Cable routing
        translate([50, 50, -1]) cube([30, 100, 10]);
        translate([200, 50, -1]) cube([30, 100, 10]);
    }
}

module storage_wall_segment_v4() {
    // "The Wall" - Metal Standoff Edition
    difference() {
        // 1. The Base Plate
        cube([140, 320, 5]); 
        
        // 2. 2.5" SSD Mounting Holes (Bottom Mount Pattern)
        // Holes are drilled THROUGH the plate.
        for (i = [0:1]) { // 2 Drives wide
            for (j = [0:1]) { // 2 Drives tall (Lower section)
                translate([20 + (i*80), 20 + (j*110), -1]) {
                    // Hole A
                    cylinder(r=1.6, h=10, $fn=20); // M3 Clearance (3.2mm diam)
                    // Hole B
                    translate([61.7, 0, 0]) cylinder(r=1.6, h=10, $fn=20);
                    // Hole C
                    translate([0, 76.6, 0]) cylinder(r=1.6, h=10, $fn=20);
                    // Hole D
                    translate([61.7, 76.6, 0]) cylinder(r=1.6, h=10, $fn=20);
                    
                    // Cable Pass-through (U.2 / SATA Header area)
                    translate([10, -15, 0]) cube([40, 15, 10]);
                }
            }
        }

        // 3. M.2 NVMe Standoff Holes (Upper Section)
        // We drill holes for M2 Brass Standoffs.
        // 2280 Standard: The hole is exactly 80mm from the connector line.
        for (c = [0:2]) { // 3 Columns of M.2
            for (r = [0:0]) { // 1 Row (Top)
                // Position of the SCREW HOLE (Tail of the drive)
                translate([25 + (c*40), 260 + (r*10) + 80, -1]) {
                     // 2.5mm hole for M2 Standoff insertion
                     cylinder(r=1.25, h=10, $fn=20); 
                }
                
                // Optional: Cable slot near the connector head (Top of drive)
                // Position of the CONNECTOR
                translate([15 + (c*40), 260 + (r*10) - 5, -1])
                    cube([20, 5, 10]); // Slot for cables to pass behind
            }
        }
    }
}

module ac_power_conduit() {
    difference() {
        cylinder(r=15, h=hub_height, $fn=50);
        translate([0,0,-1]) cylinder(r=10, h=hub_height+2, $fn=50);
    }
}

module central_hub_body_v2() {
    difference() {
        cylinder(r=hub_diameter/2, h=hub_height, $fn=100);
        translate([0,0,10]) cylinder(r=(hub_diameter/2) - 20, h=hub_height, $fn=100);
        
        // Venting
        for (i=[0:12]) {
            rotate([0,0,i*30])
            translate([hub_diameter/2 - 30, 0, 50])
            cube([40, 20, hub_height-100], center=true);
        }
    }
}

module snap_circuit_grid() {
    intersection() {
        cylinder(r=(hub_diameter/2) - 25, h=2, $fn=100);
        union() {
            for (x = [-200 : snap_grid_spacing : 200]) {
                for (y = [-200 : snap_grid_spacing : 200]) {
                    translate([x, y, 0]) cylinder(r=2.5, h=5, $fn=20);
                }
            }
        }
    }
}

module crystal_timing_chamber() {
    difference() {
        cylinder(r=crystal_chamber_r + 5, h=60, $fn=50);
        translate([0,0,2]) cylinder(r=crystal_chamber_r, h=60, $fn=50);
    }
}

// --- Assembly ---

color("dimgray") central_hub_body_v2();
translate([0, 0, 5]) color("gold") snap_circuit_grid();
translate([0, 0, 5]) color("cyan", 0.6) crystal_timing_chamber();

// Power Conduits
for (i=[0:2]) {
    rotate([0,0, i*120]) translate([120, 0, 0]) color("red") ac_power_conduit();
}

// ATX Blades
for (i=[0:2]) {
    rotate([0, 0, i*120 + 60]) translate([100, -10, 20])
    rotate([90, 0, 90]) color("green") atx_blade_mount();
}

// Storage Walls (v4)
for (i=[0:4]) {
    rotate([0, 0, i*72]) // 5 Walls spaced evenly
    translate([hub_diameter/2 - 40, -70, 20]) 
    rotate([0, 0, 180]) 
    color("blue") 
    storage_wall_segment_v4();
}
