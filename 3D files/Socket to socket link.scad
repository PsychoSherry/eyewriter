
union() {
	difference() {
		import("ball-and-socket.stl");
	
		translate([0,0,26])
			cube([20,20,20], center = true);
	}
	
	translate([0,0,32]) {
		rotate([180,0,0]) {
			difference() {
				import("ball-and-socket.stl");
			
				translate([0,0,26])
					cube([20,20,20], center = true);
			}
		}
	}
}