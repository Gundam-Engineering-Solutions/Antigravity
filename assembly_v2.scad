// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// File: Master Assembly V2 (Solid State Variant)

// --- Import V2 Components ---
use <type_s_saiya_v2.scad>;      // The Hull (Expanded Hole)
use <central_hub_saiya_v2.scad>; // The Server Core (E-ATX Blade System)
use <crystal_sc_cut.scad>;       // The Jamoni Crystal

// --- Visualization Parameters ---
$fn = 100;
enable_cutaway = false; // Set 'true' to slice ship in half for inspection

module complete_type_s_v2() {
    
    // 1. THE EXPANDED HULL
    // High-Voltage Repulsion Ring
    union() {
        // Ventral (Bottom) - Negative Rail
        color("silver") full_ring_assembly();
        
        // Dielectric - Insulator
        translate([0,0, 20]) dielectric_separator();
        
        // Dorsal (Top) - Neutral/Positive
        translate([0,0, 25]) color("gray") full_ring_assembly();
    }

    // 2. THE SERVER CORE (AVIONICS)
    // Drops into the 610mm central void
    translate([0, 0, 0]) 
    union() {
        // Main Housing
        color("dimgray") central_hub_body_v2();
        
        // Snap Circuit Floor
        translate([0, 0, 5]) color("gold") snap_circuit_grid();
        
        // Crystal Chamber
        translate([0, 0, 5]) color("cyan", 0.6) crystal_timing_chamber();
        
        // AC Power Conduits (Red)
        for (i=[0:2]) {
            rotate([0,0, i*120]) translate([120, 0, 0]) color("red") ac_power_conduit();
        }
        
        // ATX Server Blades (Green)
        for (i=[0:2]) {
            rotate([0, 0, i*120 + 60]) translate([100, -10, 20])
            rotate([90, 0, 90]) color("green") atx_blade_mount();
        }

        // SSD Storage Walls (Blue)
        for (i=[0:5]) {
            rotate([0, 0, i*60]) translate([300 - 30, -50, 20]) // Adjusted for new radius
            rotate([0, 0, 180]) color("blue") storage_wall_segment();
        }
    }

    // 3. THE JAMONI CRYSTAL
    // Suspended in the core
    translate([0, 0, 30]) 
    rotate([0, 0, 45]) 
    union() {
        rotate([0, 0, 0]) quartz_disk();
        electrodes();
        stress_free_mount();
    }
}

// --- Render Logic ---

if (enable_cutaway) {
    difference() {
        complete_type_s_v2();
        // Cutaway cube to reveal the server blades inside
        translate([-1000, -600, -50]) cube([2000, 1200, 500]);
    }
} else {
    complete_type_s_v2();
}

// --- Identification ---
color("white")
translate([350, 0, 50]) // Moved text out to the new rim location
rotate([0,0,90])
linear_extrude(2)
text("GRS TYPE-S (SOLID STATE)", size=25, halign="center");
