// Gundam Robotics Systems
// Project: Type-S (Saiya) Anti-Gravity Platform
// Component: 360-Segment Electret Hull Assembly (v2)
// Update: Hub Radius expanded for Class-4 Server Core

// --- Global Parameters ---
ship_radius = 500;      // Total radius of the ship (1000mm diameter)
hub_radius = 305;       // UPDATED: 610mm Hole to fit the 600mm Server Core
plate_thickness = 20;   // Thickness of each hull plate
dielectric_thick = 5;   // Thickness of the separator insulator
num_segments = 360;     // The "Saiya" 360-degree array
bolt_hole_size = 5;     // Radius of mounting bolts

// --- Modules ---

module pie_slice(radius, angle, height) {
    // Creates a wedge shape for a single segment
    intersection() {
        cylinder(r=radius, h=height, $fn=100);
        cube([radius, radius, height]);
        rotate([0,0,angle]) translate([0, -radius, 0]) cube([radius, radius, height]);
    }
}

module segment_plate() {
    // Generates one isolated plate with bolt holes
    angle = 360 / num_segments;
    
    difference() {
        // The Plate Material
        pie_slice(ship_radius, angle, plate_thickness);
        
        // Remove the Center Hub area
        translate([0,0,-1]) cylinder(r=hub_radius, h=plate_thickness+2, $fn=100);
        
        // Bolt Hole: Outer Perimeter
        rotate([0,0,angle/2]) 
        translate([ship_radius - 20, 0, -1]) 
        cylinder(r=bolt_hole_size, h=plate_thickness+2, $fn=20);

        // Bolt Hole: Inner Perimeter
        rotate([0,0,angle/2]) 
        translate([hub_radius + 20, 0, -1]) 
        cylinder(r=bolt_hole_size, h=plate_thickness+2, $fn=20);
    }
}

module full_ring_assembly() {
    // Generates the 360-plate ring
    for (i = [0 : num_segments - 1]) {
        rotate([0, 0, i * (360 / num_segments)])
        translate([0,0,0]) // Adjust for gap if needed
        segment_plate();
    }
}

module dielectric_separator() {
    // The solid insulating disc between plates
    color("blue", 0.5)
    difference() {
        cylinder(r=ship_radius, h=dielectric_thick, $fn=200);
        translate([0,0,-1]) cylinder(r=hub_radius, h=dielectric_thick+2, $fn=200);
        
        // Optional: Cutouts for Snap Circuit feed-throughs
    }
}

// --- Assembly Render ---

// 1. Ventral (Bottom) Plates - Negative Charge (High Wattage Rail)
color("silver") 
full_ring_assembly();

// 2. Dielectric Insulator (Middle)
translate([0,0, plate_thickness]) 
dielectric_separator();

// 3. Dorsal (Top) Plates - Positive/Neutral
translate([0,0, plate_thickness + dielectric_thick]) 
color("gray") 
full_ring_assembly();
