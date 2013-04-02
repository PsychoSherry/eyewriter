include <lib/units.scad>
include <lib/boxes.scad>

housingDepth = 12;

boardWidth = 3*inch;
boardHeight = 3.2*inch;
boardThickness = 1.4;

// Spacer parameters
spacerHeight = .25*inch;
spacerOD = 2;
spacerID = 1;

showMainPCB = false;
showSpacers = true;
showPS3Eye = true;

difference() {
	translate([boardWidth/2, boardHeight/2, housingDepth/2])
		roundedBox([boardWidth + 3, boardHeight + 3, housingDepth], 5, false);
	
	translate([-3,-3,7])
		cube([boardWidth + 5, boardHeight + 5, 5]);

	translate([2.8*inch, 2.5*inch, 0])
		rotate([0,0,180])
			linear_extrude(height = 10)
				import("Board outlines/PS3Eye.dxf");
}

translate([boardWidth/2, boardHeight*2/3 - 3.5, boardThickness])
	color([1,1,1])
		cylinder(r = 12.5, h = 10);


// PS3Eye PCB
module ps3eye() {
	translate([2.8*inch, 2.5*inch, 0])
		rotate([0,0,180])
			linear_extrude(height = boardThickness)
				import("Board outlines/PS3Eye.dxf");
}

// Main PCB
module mainPCB() {
	translate([0,0, spacerHeight + boardThickness]) {
		color([0,1,1]) {
			difference() {
				linear_extrude(height = boardThickness)
					import("Board outlines/Main-Board.dxf");
				
				// Camera lens hole
				translate([1.5*inch, 2*inch, -.1])
					cylinder(r = .6*inch, h = 1.6);
		
				// Left PS3Eye standoff
				translate([.32*inch, 1.42*inch, 0])
					cylinder(r = .0394*inch, h = 1.6, $fn = 15);
		
				// Right PS3Eye standoff
				translate([2.69*inch, 1.42*inch, 0])
					cylinder(r = .0394*inch, h = 1.6, $fn = 15);
			}
		}
	}
}

// Spacers between main board and PS3Eye
module spacers() {
	color([1,0,1]) {
		// Left PCB spacer
		translate([.32*inch, 1.42*inch, boardThickness]) {
			difference() {
				cylinder(r = spacerOD, h = spacerHeight, $fn = 15);
				cylinder(r = spacerID, h = spacerHeight, $fn = 15);
			}
		}
		
		// Right PCB spacer
		translate([2.69*inch, 1.42*inch, boardThickness]) {
			difference() {
				cylinder(r = spacerOD, h = spacerHeight, $fn = 15);
				cylinder(r = spacerID, h = spacerHeight, $fn = 15);
			}
		}
	}
}

if(showMainPCB)		mainPCB();
if(showSpacers)		spacers();
if(showPS3Eye)		ps3eye();