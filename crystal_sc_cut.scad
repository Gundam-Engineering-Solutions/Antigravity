// Gundam Robotics Systems
// Component: Jamoni Master Timing Crystal
// Specs: SC-Cut Quartz (Stress Compensated), Double Rotated

// --- Parameters ---
crystal_radius = 12;      // Fits inside the 15mm chamber
crystal_thick = 2;        // Thickness-shear mode plate
mount_ring_thick = 4;     // The vibration isolation mount
rotation_phi = 22;        // SC-Cut Angle 1
rotation_theta = 34;      // SC-Cut Angle 2

$fn = 100;

module quartz_disk() {
    // The active resonator element
    // "Circular (disk) plates" [Source: 1, 12]
    color("cyan", 0.8) 
    cylinder(r=crystal_radius, h=crystal_thick, center=true);
    
    // Visualization of the SC-Cut Lattice Angles
    // We etch lines to show the double-rotation axis
    color("white", 0.5)
    rotate([rotation_theta, rotation_phi, 0])
    cube([crystal_radius*2.5, 0.2, 0.2], center=true);
}

module stress_free_mount() {
    // "Attached at its edges, allowing the center to vibrate freely" [Source: 14]
    color("gold") 
    difference() {
        // Outer Grip Ring
        cylinder(r=crystal_radius + 2, h=mount_ring_thick, center=true);
        
        // Inner Clearance (leaving only a small lip to hold the crystal)
        cylinder(r=crystal_radius - 0.5, h=mount_ring_thick + 2, center=true);
        
        // Side slots for electrode access
        rotate([90,0,0]) cylinder(r=1, h=30, center=true);
    }
}

module electrodes() {
    // Gold plating for signal pickup
    color("yellow")
    translate([0,0, (crystal_thick/2) + 0.1])
    cylinder(r=crystal_radius - 2, h=0.1, center=true);
    
    color("yellow")
    translate([0,0, -(crystal_thick/2) - 0.1])
    cylinder(r=crystal_radius - 2, h=0.1, center=true);
}

// --- Assembly ---

// 1. The SC-Cut Quartz Disk
// Rotated slightly to visualize the "Cut" relative to the holder
rotate([0, 0, 0]) 
quartz_disk();

// 2. The Electrodes
electrodes();

// 3. The Vibration Isolation Mount
stress_free_mount();

// 4. Verification Text
color("black")
translate([-5, -crystal_radius - 5, 0])
linear_extrude(1)
text("SC-CUT", size=3);
