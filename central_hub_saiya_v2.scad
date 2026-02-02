// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// Component: Central Data Core (Server Grade)
// Specs: E-ATX Support, High-Density Storage Walls, AC Routing

// --- Global Parameters ---
hub_diameter = 600;       // INCREASED: To fit E-ATX (330mm) boards
hub_height = 350;         // INCREASED: To fit vertical ATX boards
snap_grid_spacing = 15;   
crystal_chamber_r = 20;

// --- ATX Standards (in mm) ---
// Mounting hole offsets from top-left reference
atx_holes = [
    [0, 0], [0, 154], [0, 280],      // Column A
    [120, 0], [120, 154], [120, 280], // Column B (MicroATX share)
    [220, 0], [220, 154], [220, 280], // Column C (Standard ATX)
    [310, 0], [310, 154], [310, 280]  // Column D (E-ATX Width)
];

// --- Modules ---

module atx_blade_mount() {
    // A vertical mounting plate for ANY ATX board
    difference() {
        // The Plate
        cube([340, 310, 5]); // Fits E-ATX (330x305) with margin
        
        // The Mounting Holes (Universal Pattern)
        for (pos = atx_holes) {
            translate([pos[0] + 10, pos[1] + 10, -1])
            cylinder(r=2, h=10, $fn=20); // 4mm standoff holes
        }
        
        // Cable Pass-throughs
        translate([50, 50, -1]) cube([30, 100, 10]);
        translate([200, 50, -1]) cube([30, 100, 10]);
    }
}

module storage_wall_segment() {
    // High Density M.2 and SSD Mounts
    union() {
        // Wall Structure
        cube([100, 300, 5]); 
        
        // 2.5" SSD Caddies (Lower half)
        for (i = [0:2]) {
            translate([10, 10 + (i*80), 5])
            difference() {
                cube([80, 70, 10]); // SSD Size approx
                translate([2, 2, 2]) cube([76, 75, 12]); // Slot
            }
        }
        
        // M.2 Standoffs (Upper half)
        for (j = [0:1]) {
            for (k = [0:3]) {
                translate([20 + (j*40), 250 + (k*10), 5])
                cylinder(r=1.5, h=3, $fn=10);
            }
        }
    }
}

module ac_power_conduit() {
    // Vertical channel for High Voltage AC
    difference() {
        cylinder(r=15, h=hub_height, $fn=50);
        translate([0,0,-1]) cylinder(r=10, h=hub_height+2, $fn=50);
    }
}

module central_hub_body_v2() {
    difference() {
        // Main Housing Shell
        cylinder(r=hub_diameter/2, h=hub_height, $fn=100);
        
        // Hollow Interior
        translate([0,0,10])
        cylinder(r=(hub_diameter/2) - 20, h=hub_height, $fn=100);
        
        // Venting / Cooling Slots
        for (i=[0:12]) {
            rotate([0,0,i*30])
            translate([hub_diameter/2 - 30, 0, 50])
            cube([40, 20, hub_height-100], center=true);
        }
    }
}

module snap_circuit_grid() {
    // The mounting surface (Now on the Floor)
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
    // Re-integrated in the center
    difference() {
        cylinder(r=crystal_chamber_r + 5, h=60, $fn=50);
        translate([0,0,2])
        cylinder(r=crystal_chamber_r, h=60, $fn=50);
    }
}

// --- Assembly ---

// 1. The Main Chassis
color("dimgray") 
central_hub_body_v2();

// 2. The Snap Circuit Control Floor
translate([0, 0, 5]) 
color("gold") 
snap_circuit_grid();

// 3. The Central Crystal Core
translate([0, 0, 5]) 
color("cyan", 0.6) 
crystal_timing_chamber();

// 4. AC Power Conduits (3 Pillars)
for (i=[0:2]) {
    rotate([0,0, i*120])
    translate([120, 0, 0])
    color("red")
    ac_power_conduit();
}

// 5. ATX Motherboard Blades (Radial Configuration)
// "Module Slots" for redundant Hex-CPU / Server logging
for (i=[0:2]) {
    rotate([0, 0, i*120 + 60]) // Offset from power conduits
    translate([100, -10, 20])  // Positioned radially
    rotate([90, 0, 90])        // Vertical orientation
    color("green")
    atx_blade_mount();
}

// 6. Storage Walls (Lining the perimeter)
// Walls of M.2 and SSDs for planetary data backup
for (i=[0:5]) {
    rotate([0, 0, i*60])
    translate([hub_diameter/2 - 30, -50, 20])
    rotate([0, 0, 180]) // Facing inward
    color("blue")
    storage_wall_segment();
}
