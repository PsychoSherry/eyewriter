include <lib/units.scad>
include <lib/metric_fastners.scad>

// Rod and nut characteristics
rod_length =17*inch;
rod_spacing = 3*inch;
rod_size = 8;
nut_size = 0.8*rod_size;

// Rendering parameters
showRods = true;
showEndBlocks = true;
showGlintPlatforms = true;
showMainPlatform = true;
showNuts = true;

// Colors
rodColor = [1,0,1];
nutColor = [0,1,0];
endBlockColor = [0,1,1];
glintPlatformColor = [1,1,0];
mainPlatformColor = [1,.5,.3];

// Generate all of the nuts for one rod
module generateNuts() {
	translate([-nut_size,rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([0.25*inch+nut_size,rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([rod_length/5 - nut_size - 1*inch,rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([rod_length/5 + 1*inch - 2, rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([rod_length/2 - 1*inch - nut_size, rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([rod_length/2 + 1*inch - 2, rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([4*rod_length/5 - 1*inch - nut_size, rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([4*rod_length/5 + 1*inch - 2, rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([rod_length - 0.25*inch - nut_size*2 , rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);

	translate([rod_length - 2, rod_spacing/2, 10])
		rotate([0,90,0])
			flat_nut(8);
}

// Generates both of the threaded rods
module generateRods() {
	// Front rod
	translate([-nut_size,-1.5*inch,10])
		rotate([0,90,0])
			cylinder(r = 4, h = rod_length + nut_size*2 - 2);
		
	// Back rod
	translate([-nut_size,1.5*inch,10])
		rotate([0,90,0])
			cylinder(r = 4, h = rod_length + nut_size*2 - 2);
}


// Imports and renders the two end blocks
module generateEndBlocks() {
	// Left end block
	rotate([0,-90,180])
		import("STLs/End block.stl");
	
	// Right end block
	translate([rod_length,0,0])
		rotate([0,-90,0])
			import("STLs/End block.stl");
}

// Imports and renders the glint platforms
module generateGlintPlatforms() {
	// Left glint platform
	union() {
		// Platform
		translate([rod_length/5 + 1*inch,0,10])
			rotate([-90,0,90])
				import("STLs/Platform.stl");
	
		// Nub
		translate([rod_length/5,0,17])
			import("STLs/Modified nub.stl");
	}
	
	// Right glint platform
	union() {
		// Platform
		translate([4*rod_length/5 + 1*inch,0,10])
			rotate([-90,0,90])
				import("STLs/Platform.stl");
	
		// Nub
		translate([4*rod_length/5,0,17])
			import("STLs/Modified nub.stl");
	}
}

// Imports and renders the main platform
module generateMainPlatform() {
	// Main platform
	union() {
		// Platform
		translate([rod_length/2 + 1*inch,0,10])
			rotate([-90,0,90])
				import("STLs/Platform.stl");
	
		// Nub
		translate([rod_length/2,0,17])
			import("STLs/Modified nub.stl");
	}
}

translate([-rod_length/2, 0, 1*inch]) {
	if(showRods)	color(rodColor)	generateRods();
	if(showEndBlocks)	color(endBlockColor)		generateEndBlocks();
	if(showGlintPlatforms)	color(glintPlatformColor)		generateGlintPlatforms();
	if(showMainPlatform)	color(mainPlatformColor)	generateMainPlatform();
	if(showNuts) {
		color(nutColor) {
			generateNuts();
			translate([0,-rod_spacing,0])	generateNuts();
		}
	}
}