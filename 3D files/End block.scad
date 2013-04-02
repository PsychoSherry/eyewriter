include <lib/units.scad>
include <lib/boxes.scad>

block_width = .5*inch;
block_length = 4*inch;
block_height = 2*inch;

hole_size = M8 + 0.6;
hole_distance = 3*inch;

lip_depth = block_width/2;
lip = true;

module generateEndBlock() {
	union() {
		difference() {
			// Rounded block
			translate([0,0,block_width/2])
				roundedBox([block_height, block_length, block_width], 5, true);
	
			// Left hole
			translate([block_height/5, hole_distance/2, block_width/2])
				cylinder(h = block_width + 5, r = hole_size/2, center = true, $fn = 20);
	
			// Right hole
			translate([block_height/5, -hole_distance/2, block_width/2])
				cylinder(h = block_width + 5, r = hole_size/2, center = true, $fn = 20);

			if(lip)
				translate([-block_height/2 + 10, 0, block_width - lip_depth/2])
					cube([20, block_length, lip_depth + 1], center = true);
		}
	}
}

generateEndBlock();