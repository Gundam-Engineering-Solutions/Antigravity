// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// Component: Central Power Hub & Snap Circuit Interface
// Specs: Supports CRIPS Double Latch Gate Buffer

// --- Global Parameters ---
hub_diameter = 200;       // Matches the hole in the hull plate
hub_height = 40;          // Height of the avionics bay
snap_grid_spacing = 15;   // Standard Snap Circuit peg spacing
crystal_chamber_r = 15;   // Radius for the Pressurized Crystal mount

module snap_peg() {
    // A single mounting peg for Snap Circuits
    cylinder(r=2.5, h=5, $fn=20);
}

module latch_gate_slot() {
    // Recess for the Double Latch Gate Buffer
    // Includes Percy Miller's Directional Arrow
    difference() {
        cube([60, 30, 5], center=true);
        // Directional Arrow (Negative Rectification Flow)
        translate([-10, 0, 1])
        linear_extrude(2)
        text("->", size=10, valign="center", halign="center");
    }
}

module central_hub_body() {
    difference() {
        // Main Housing
        cylinder(r=hub_diameter/2, h=hub_height, $fn=100);
        
        // Inner Cavity (Avionics Bay)
        translate([0,0,5])
        cylinder(r=(hub_diameter/2) - 10, h=hub_height, $fn=100);
        
        // High Voltage Cable Ports (to Hull Plates)
        for (i = [0 : 7]) { // 8 Main Bus Lines
            rotate([0, 0, i * 45])
            translate([hub_diameter/2 - 5, 0, 15])
            rotate([0, 90, 0])
            cylinder(r=8, h=20, $fn=20);
        }
    }
}

module snap_circuit_grid() {
    // The mounting surface for the User's circuits
    intersection() {
        cylinder(r=(hub_diameter/2) - 12, h=2, $fn=100);
        union() {
            for (x = [-100 : snap_grid_spacing : 100]) {
                for (y = [-100 : snap_grid_spacing : 100]) {
                    translate([x, y, 0]) snap_peg();
                }
            }
        }
    }
}

module crystal_timing_chamber() {
    // Housing for Jamoni's Pressurized Crystal
    difference() {
        cylinder(r=crystal_chamber_r + 5, h=30, $fn=50);
        translate([0,0,2])
        cylinder(r=crystal_chamber_r, h=30, $fn=50);
    }
}

// --- Assembly ---

// 1. The Main Hub Chassis
color("dimgray") 
central_hub_body();

// 2. The Snap Circuit Mounting Grid (Internal Floor)
translate([0, 0, 5]) 
color("gold") 
snap_circuit_grid();

// 3. The Double Latch Gate Mount (Placed on the Grid)
translate([0, 30, 8]) 
color("silver") 
latch_gate_slot();

// 4. Pressurized Crystal Chamber (Center)
translate([0, 0, 5]) 
color("cyan", 0.6) 
crystal_timing_chamber();
