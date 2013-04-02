include <MCAD/units.scad>

// Platform parameters
platform_width = 2*inch;
platform_thickness = .25*inch;

// Threaded rod parameters
rod_diameter = M8 + 0.6;
rod_distance = 3*inch;
rod_margin = 3;

// Center screw hole
screw_size = M3;

generatePlatform();

module generatePlatform() {
	difference() {
		union() {
			// Bridge
			translate([0, 0, rod_diameter/2 - .175])
				cube([rod_distance, platform_width, platform_thickness], center = true);

			// Left rod carriage
			translate([-rod_distance/2, 0, 0])
				rotate([90,0,0])
					cylinder(h = platform_width, r = rod_diameter/2 + rod_margin, $fn = 20, center = true);
			
			// Right rod carriage
			translate([rod_distance/2, 0, 0])
				rotate([90,0,0])
					cylinder(h = platform_width, r = rod_diameter/2 + rod_margin, $fn = 20, center = true);	

		}
	
		// Left rod hole
		translate([-rod_distance/2, 0, 0])
			rotate([90,0,0])
				cylinder(h = platform_width + 5, r = rod_diameter/2, $fn = 20, center = true);
	
		// Right rod hole
		translate([rod_distance/2, 0, 0])
			rotate([90,0,0])
				cylinder(h = platform_width + 5, r = rod_diameter/2, $fn = 20, center = true);
	
		// Center screw hole
		translate([0,0, rod_diameter/2])
		cylinder(h = platform_thickness + 5, r = screw_size/2, $fn = 20, center = true);
	}
}