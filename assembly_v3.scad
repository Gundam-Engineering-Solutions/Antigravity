// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// File: Master Assembly V3 (Production Ready)

// --- Import Components ---
use <type_s_saiya_v2.scad>;       // The Expanded Hull Ring
use <central_hub_saiya_v4.scad>;  // The Server Core (Holes for Standoffs)
use <crystal_sc_cut.scad>;        // The Jamoni Crystal

// --- Visualization Parameters ---
$fn = 100;
enable_cutaway = false; 

module complete_type_s_v3() {
    
    // 1. THE HULL (Class-4 Expanded)
    union() {
        color("silver") full_ring_assembly();
        translate([0,0, 20]) dielectric_separator();
        translate([0,0, 25]) color("gray") full_ring_assembly();
    }

    // 2. THE SERVER CORE (Avionics)
    translate([0, 0, 0]) 
    union() {
        color("dimgray") central_hub_body_v2();
        translate([0, 0, 5]) color("gold") snap_circuit_grid();
        translate([0, 0, 5]) color("cyan", 0.6) crystal_timing_chamber();
        
        for (i=[0:2]) {
            rotate([0,0, i*120]) translate([120, 0, 0]) color("red") ac_power_conduit();
        }
        
        for (i=[0:2]) {
            rotate([0, 0, i*120 + 60]) translate([100, -10, 20])
            rotate([90, 0, 90]) color("green") atx_blade_mount();
        }

        for (i=[0:5]) {
            rotate([0, 0, i*60]) translate([300 - 30, -50, 20]) 
            rotate([0, 0, 180]) color("blue") storage_wall_segment_v4();
        }
    }

    // 3. THE CRYSTAL
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
        complete_type_s_v3();
        translate([-1000, -600, -50]) cube([2000, 1200, 500]);
    }
} else {
    complete_type_s_v3();
}

// --- Identification ---
color("white")
translate([350, 0, 50]) 
rotate([0,0,90])
linear_extrude(2)
text("GRS TYPE-S (V3 RELEASE)", size=25, halign="center");
