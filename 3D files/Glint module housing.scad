include <lib/units.scad>
include <lib/boxes.scad>

boardWidth = 2*inch;
boardHeight = 1*inch;
boardDepth = 1.4;

housingDepth = .25*inch;
housingMargin = 4;

insetAmount = 1;

showPCB = false;

// Housing
difference() {
	// Main positive housing
	translate([boardWidth/2, boardHeight/2, housingDepth/2])
		roundedBox([boardWidth + housingMargin, boardHeight + housingMargin, housingDepth], 3, false, $fn = 20);
	
	// Hollow cavity
	translate([boardWidth/2, boardHeight/2, housingDepth/2 + housingMargin/2])
		roundedBox([boardWidth + .03*inch, boardHeight + .03*inch, housingDepth], 3, true);

	// Inset text
	translate([2*inch,0,0])
		mirror([1,0,0])
			linear_extrude(height = 1)
				import("Board outlines/Glint module text.dxf");

	// Center hole
	translate([boardWidth/2, boardHeight/2, 0])
		cylinder(r = 1.6, h = 10, $fn = 20);
}

module standoff(x, y) {
	difference() {
		translate([x, y, housingMargin/2 - boardDepth - .2])
			cylinder(r1 = .15*inch, r2 = .1*inch, h = housingDepth - housingMargin/2, $fn = 20);
		
		// Hole
		translate([x, y, housingDepth/2])
			cylinder(r = .065*inch, h = housingDepth, center = true, $fn = 15);
	}
}

standoff(.15*inch, .15*inch);		// Bottom left
standoff(1.85*inch, .15*inch);	// Bottom right
standoff(1.85*inch, .85*inch);	// Top right
standoff(.15*inch, .85*inch);		// Top left

// PCB
if(showPCB)
	translate([0, 0, housingDepth - boardDepth - insetAmount])
		color([0,1,1])
			linear_extrude(height = 1.4)
				import("Board outlines/Glint-Module.dxf");





