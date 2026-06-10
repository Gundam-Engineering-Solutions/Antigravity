// Gundam Robotics Systems - Type-S (Saiya)
// Component: Lateral Airlock Module with COPV Gas Storage

$fn = 60;
airlock_radius = 45;

module airlock_hatch() {
    // Rotation-to-axial-motion pressure hatch
    color("DimGray")
    union() {
        cylinder(h=5, r=18); // Hatch door
        translate([0, 18, 0]) cylinder(h=15, r=3); // Pivot hinge mechanism
    }
}

module copv_tank() {
    // High-Pressure Gas Tank (6,000 psi) with Multi-Layer Insulation
    color("Gold")
    hull() {
        sphere(r=10);
        translate([0, 0, 30]) sphere(r=10);
    }
}

module saiya_lateral_airlock() {
    // 1. The Equipment Lock (Inner Staging Chamber)
    color("White")
    difference() {
        cylinder(h=60, r=airlock_radius, center=true);
        cylinder(h=58, r=airlock_radius - 2, center=true); // Hollow interior
        
        // Pass-through into the ship's main hull
        translate([0, -airlock_radius, 0]) rotate([90, 0, 0]) cylinder(h=20, r=16, center=true);
        // Pass-through to the Crew Lock
        translate([0, airlock_radius, 0]) rotate([90, 0, 0]) cylinder(h=20, r=16, center=true);
    }
    
    // 2. The Crew Lock (Outer Depressurization Chamber)
    color("LightGray")
    translate([0, airlock_radius * 1.6, 0])
    difference() {
        cylinder(h=50, r=airlock_radius - 10, center=true);
        cylinder(h=48, r=airlock_radius - 12, center=true);
        
        // Pass-through from Equipment Lock
        translate([0, -(airlock_radius - 10), 0]) rotate([90, 0, 0]) cylinder(h=20, r=16, center=true);
        // Outer Space Hatch
        translate([0, airlock_radius - 10, 0]) rotate([90, 0, 0]) cylinder(h=20, r=16, center=true);
    }

    // 3. Pressure Hatches
    translate([0, airlock_radius * 0.8, 0]) rotate([90, 0, 0]) airlock_hatch();
    translate([0, airlock_radius * 2.3, 0]) rotate([90, 0, 0]) airlock_hatch();

    // 4. External High-Pressure Gas Storage Tanks (COPVs)
    translate([-35, airlock_radius * 1.6, -15]) rotate([0, 90, 0]) copv_tank();
    translate([35, airlock_radius * 1.6, -15]) rotate([0, 90, 0]) copv_tank();
}

// Render the module
saiya_lateral_airlock();
