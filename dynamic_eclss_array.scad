// =================================================================
// DYNAMIC HONEYCOMB ECLSS ARRAY (WATER OUTSIDE, O2 INSIDE, FLOOR ABOVE)
// =================================================================
include <eclss_config.scad>; // Imports grid_rings and z_layers dynamically

$fn = 60;
hex_step_x = module_spacing * cos(30);
hex_step_y = module_spacing * sin(30);
module_height = 80; 

// --- Core Modules ---
module maintenance_room(rings) {
    color("dimGray")
    cylinder(r = (rings * module_spacing) - module_spacing/2, h = 5, $fn=6);
}

module water_reclamation_cell() {
    color("DodgerBlue") 
    difference() {
        cylinder(r = module_spacing/2 - wall_thickness/2, h = module_height, $fn=6);
        translate([0,0,5]) cylinder(r = (module_spacing/2 - wall_thickness/2)-10, h = module_height, $fn=6);
    }
}

module oxymoss_tank() {
    color("silver")
    cylinder(r = 30, h = module_height - 10);
    color("DarkSlateGray")
    translate([0,0,module_height-10]) cylinder(r=10, h=10);
}

module elevated_floor(rings, layers) {
    color("SlateGray", 0.8)
    translate([0, 0, layers * module_height])
    difference() {
        cylinder(r = (rings * module_spacing) + module_spacing/2, h = 15, $fn=6);
        // Hatch access to the maintenance room below
        translate([0,0,-1]) cylinder(r = module_spacing * 0.8, h = 20, $fn=6);
    }
}

// --- Dynamic Honeycomb Logic ---
module build_eclss_array(rings, layers) {
    // Stack vertically based on Python's calculated O2 volume needs
    for (z = [0 : layers - 1]) {
        translate([0, 0, z * module_height]) {
            
            // Axial Coordinate Hexagonal Loop
            for (q = [-rings : rings]) {
                for (r = [max(-rings, -q - rings) : min(rings, -q + rings)]) {
                    
                    // Calculate absolute distance from center (0,0)
                    dist = max(abs(q), abs(r), abs(-q-r));
                    
                    x_pos = (q * 2 * hex_step_x) + (r * hex_step_x);
                    y_pos = r * hex_step_y * 3;
                    
                    translate([x_pos, y_pos, 0]) {
                        if (dist == 0) {
                            // CENTER: Do nothing (Leave open for Maintenance Room)
                        } else if (dist == rings) {
                            // OUTERMOST RING: Hydro-shielding Water Modules
                            water_reclamation_cell();
                        } else {
                            // INNER RINGS: OXYMOSS Life Support Tanks
                            oxymoss_tank();
                        }
                    }
                }
            }
        }
    }
    
    // Build the Maintenance Floor at z=0
    maintenance_room(rings);
    
    // Build the Walkable Deck above the Oxygen Array
    elevated_floor(rings, layers);
}

// --- Execute Build ---
build_eclss_array(grid_rings, z_layers);
