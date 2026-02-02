// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// File: Master Assembly (assembly.scad)

// --- Import Components ---
// 'use' imports the modules but ignores the example geometry drawn in the source files.
use <type_s_saiya.scad>;
use <central_hub_saiya.scad>;
use <crystal_sc_cut.scad>;

// --- Visualization Parameters ---
$fn = 100;
enable_cutaway = false; // Set to true to slice the ship in half for internal inspection

module complete_ship() {
    
    // 1. THE HULL ASSEMBLY
    // The main 360-plate repulsion ring
    union() {
        // Ventral (Bottom) Plates - Negative Charge
        color("silver") 
        full_ring_assembly();

        // Dielectric Insulator (Middle)
        translate([0,0, 20]) // 20 is plate_thickness from type_s_saiya
        dielectric_separator();

        // Dorsal (Top) Plates - Positive/Neutral
        translate([0,0, 25]) // 20 + 5 dielectric thickness
        color("gray") 
        full_ring_assembly();
    }

    // 2. THE CENTRAL HUB
    // Placed in the center void of the hull
    translate([0, 0, 0]) 
    union() {
        color("dimgray") central_hub_body();
        
        translate([0, 0, 5]) 
        color("gold") snap_circuit_grid();
        
        translate([0, 30, 8]) 
        color("silver") latch_gate_slot();
        
        translate([0, 0, 5]) 
        color("cyan", 0.6) crystal_timing_chamber();
    }

    // 3. THE JAMONI MASTER CRYSTAL
    // Suspended inside the Timing Chamber
    translate([0, 0, 20]) // Elevate to center inside the chamber
    rotate([0, 0, 45])    // Aesthetic rotation
    union() {
        rotate([0, 0, 0]) quartz_disk();
        electrodes();
        stress_free_mount();
    }
}

// --- Render Logic ---

if (enable_cutaway) {
    // Cut the ship in half to see the crystal and snap circuits
    difference() {
        complete_ship();
        translate([-1000, -500, -50]) cube([2000, 1000, 200]);
    }
} else {
    complete_ship();
}

// --- Text Label ---
color("white")
translate([120, 0, 50])
rotate([0,0,90])
linear_extrude(2)
text("GRS TYPE-S PROTO", size=20, halign="center");
