include <lib/polyScrewThread_r1.scad>
include <MCAD/units.scad>

base_size = 13;					// Width and length of square base
base_height = 4;				// Height of square base
base_cavity_margin = 2.5;		// Wall thickness of cavity in square base

thread_diameter = 12;	// Diameter of thread (M12)
thread_margin = 2;		// Thickness of ring around thread
thread_pitch = 0.5;		// Pitch of thread
mount_height = 13;		// Overall height of thread

hole_distance = 18;		// Distance between the two mounting holes
hole_diameter = 2;		// Diameter of mounting holes
hole_style = 1;			// 0 = flange, 1 = straight bars

enable_thread = true;	// Turn on/off thread (takes a while to render)
enable_base = true;		// Turn on/off square base
enable_mount = true;	// Turn on/off circular mount

// Base
if(enable_base) {
	difference() {
		if(hole_style == 0) {
			hull() {
				// Square base
				translate([0,0,base_height/2])
					cube([base_size, base_size, base_height], center = true);
			
				// Right flange
				translate([hole_distance/2, 0, 0])
					cylinder(r = 2, h = base_height, $fn = 15);
			
				// Left flange
				translate(-[hole_distance/2, 0, 0])
					cylinder(r = 2, h = base_height, $fn = 15);
			}
		} else if(hole_style == 1) {
			union() {
				// Square base
				translate([0,0,base_height/2])
					cube([base_size, base_size, base_height], center = true);
			
				// Right flange
				translate([hole_distance/2, 0, 0])
					cylinder(r = 2, h = base_height, $fn = 15);
			
				// Left flange
				translate(-[hole_distance/2, 0, 0])
					cylinder(r = 2, h = base_height, $fn = 15);
	
				// Joining bar
				if(hole_style == 1)
					translate([0,0,base_height/2])
						cube([hole_distance, 4, base_height], center = true);
			}
		}

		// Hollow center
		translate([0,0,base_height/2])
			cube([base_size - base_cavity_margin*2, base_size - base_cavity_margin*2, base_height], center = true);
	
		// Right hole
		translate([hole_distance/2, 0, 0])
			cylinder(r = hole_diameter/2, h = base_height + 2, $fn = 15);
	
		// Left hole
		translate([-hole_distance/2, 0, 0])
			cylinder(r = hole_diameter/2, h = base_height + 2, $fn = 15);
	}
}

// M12 threaded mount
if(enable_mount) {
	difference() {
		cylinder(r = thread_diameter/2 + thread_margin/2, h = mount_height);
		
		// M12 thread 
		// (Outer diameter, pitch, thread angle, length, resolution, countersink style)
		if(enable_thread)
			screw_thread(thread_diameter, thread_pitch, 55, mount_height + 3, 3.14/2, 0);
		else
			cylinder(r = thread_diameter/2, h = mount_height);
	}
}
