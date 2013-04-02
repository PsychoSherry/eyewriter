include <lib/nuts_and_bolts.scad>

nut_size = 3;
bolt_size = 3;
fit = 0.1;

difference() {
	// Basic solid nub
	import("ball.stl");

	// Socket for nut
	nutHole(nut_size);

	// Bolt hole
	cylinder(r = bolt_size/2 + fit, h = 5, $fn = 15);
}


