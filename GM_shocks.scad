// GM "Robonaut" Style Regenerative Shock Absorber 
// Space-Hardened Electrification Prototype

tube_outer_radius = 28;
tube_inner_radius = 20;
tube_length = 220;
coil_thickness = 4;
magnet_radius = 18;
magnet_length = 45;
rib_count = 12;

// Space-Hardened Outer Housing with Thermal Ribs
module gm_aerospace_housing() {
    color("White") // Robonaut 2 aesthetic
    difference() {
        cylinder(h = tube_length, r = tube_outer_radius, center = true, $fn = 100);
        cylinder(h = tube_length + 2, r = tube_inner_radius, center = true, $fn = 100);
    }
    
    // Thermal Regulation Ribs (Over-engineered for extreme conditions)
    color("Gold")
    for (i = [0 : 360 / rib_count : 360]) {
        rotate([0, 0, i])
        translate([tube_outer_radius - 2, 0, 0])
        cube([6, 2, tube_length - 10], center = true);
    }
}

// High-Fault-Tolerance Stator Coils
module reinforced_copper_coil() {
    color("Copper")
    difference() {
        cylinder(h = tube_length - 30, r = tube_inner_radius + coil_thickness, center = true, $fn = 100);
        cylinder(h = tube_length - 28, r = tube_inner_radius, center = true, $fn = 100);
    }
}

// Magnetic Piston Core
module internal_magnet(position_z = 0) {
    color("Silver")
    translate([0, 0, position_z])
    cylinder(h = magnet_length, r = magnet_radius, center = true, $fn = 100);
}

// Ruggedized Mounting Brackets (LRV Suspension Style)
module lunar_mounting_bracket(z_offset) {
    color("DarkSlateGray")
    translate([0, 0, z_offset])
    difference() {
        cylinder(h = 15, r = tube_outer_radius + 8, center = true, $fn = 6);
        cylinder(h = 17, r = tube_inner_radius, center = true, $fn = 60);
    }
}

// Final Assembly
gm_aerospace_housing();
reinforced_copper_coil();
internal_magnet(position_z = -50);
lunar_mounting_bracket(tube_length / 2);
lunar_mounting_bracket(-tube_length / 2);
