/*
NAME
	head_mount.scad

DESCRIPTION
	This file generates a mount for a Netgear MR1100 that will fit into a
	110mm ID PVC mast cap.

AUTHOR
	Dan Kortschak <dan@ausocean.org>

LICENSE
	head_mount.scad is Copyright (C) 2017 the Australian Ocean Lab (AusOcean)

	It is free software: you can redistribute it and/or modify them
	under the terms of the GNU General Public License as published by the
	Free Software Foundation, either version 3 of the License, or (at your
	option) any later version.

	It is distributed in the hope that it will be useful, but WITHOUT
	ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
	FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
	for more details.

	You should have received a copy of the GNU General Public License
	along with head_mount.scad in gpl.txt. If not, see http://www.gnu.org/licenses.

*/

$fn=100;

use <../logo/logo.scad>;

// set assembled to true to generate a model of how the parts
// should be assempled to make the insert.
make(assembled=false, length=20);

// fast turns off some more costly minkowksi sum operations
// It should only be used for debugging as it alters dimensions
// of the parts.
fast=false;

smidgen = 0.5;

module make(assembled=false, id=110.5, length=20, sep=5) {
	if (assembled) {
		translate([0, 0, sep]) mr1100_mount(id=id, length=length);
		translate([0, 0, -sep]) rotate([0, 180, 0]) pi0_mount(id=id, length=length);

		for (rot = [0: 120: 360])
			rotate(a=[0, 0, rot]) {
				translate([0, id/2-5, -1]) cylinder(r=1.9, h=2);
				translate([0, id/2-5, -sep-2]) color("red") cylinder(r=0.1, h=2*(sep+2));
			}
	} else {
		translate([60, 0, 0]) mr1100_mount(id=id, length=length);
		translate([-60, 0, 0]) pi0_mount(id=id, length=length);

		// Press fit pins for assembling the parts.
		for (y = [20, 30, 40]) translate([0, y, 0]) cylinder(r=1.9, h=3);
	}
}

module mr1100_mount(id=110.5, length=20, thick=3, gusset=2, chamfer=1, tol=0.1) {
	tolid = id-tol;
	difference() {
		// Make the general shape.
		cylinder(h=length, d=tolid);
		
		// Hollow out cap.
		translate([0, 0, thick+gusset]) minkowski() {
				cylinder(h=length, d=tolid-2*thick-2*gusset);
				sphere(r=gusset);
		}

		// Chamfer top end.
		translate([0, 0, length-chamfer]) difference() {
			cylinder(d=tolid, h=chamfer);
			cylinder(d1=tolid, d2=tolid-2*chamfer, h=chamfer);
		}

		// Reduce plastic use for side walls.
		bites(id=id, length=length);

		translate([0, 0, -1]) cylinder(d=id-20, h=10);

		translate([-38.5, -29, 1.5]) minkowski() {
			mr1100_board();
			if (!fast) sphere(r=0.5);
		}

		torus_arc(id/2-2.5*thick, 2.1*thick, -135, 90);

		for (rot = [0: 120: 360])
			rotate(a=[0, 0, rot]) translate([0, id/2-5, 0]) cylinder(r=2, h=2);
	}
}

module mr1100_board() {
	translate([77, 0, 1]) scale([-1, 1, 1])
	difference() {
		cube([76, 74, 1.5]);
		translate([0, 74-6, 0]) cube([8, 6, 1.5]);
		translate([20.6, 74-10.5, 0]) cube([18, 10.5, 1.5]);
		translate([53.5, 74-10.5, 0]) cube([16.8, 10.5, 1.5]);
		translate([70, 74-4.5, 0]) cube([6, 4.5, 1.5]);
	}

	// Not a part of the board, but needed
	// for clear access to ports.
	translate([2.5, -8, -2.5]) cube([73, 15, 5]);
}

module pi0_mount(id=110.5, length=20, thick=3, gusset=2, chamfer=1, tol=0.1) {
	tolid = id-tol;

	difference() {
		union() {
			difference() {
				// Make the general shape.
				cylinder(h=length, d=tolid);
				
				// Hollow out cap.
				translate([0, 0, thick+gusset]) minkowski() {
						cylinder(h=length, d=tolid-2*thick-2*gusset);
						sphere(r=gusset);
				}

				// Chamfer top end.
				translate([0, 0, length-chamfer]) difference() {
					cylinder(d=tolid, h=chamfer);
					cylinder(d1=tolid, d2=tolid-2*chamfer, h=chamfer);
				}

				// Reduce plastic use for side walls.
				intersection() {
					bites(id=id, length=length);
					hollow_cylinder(od=id, id=id-2*thick-2*gusset, height=length+1);
				}

				translate([-0.5, -29.5, 2.5]) minkowski() {
					// Not a part of the board, but needed
					// for clear access to MR1100 ports.
					// The location matches the block in the
					// mr1100_board module.
					cube([73, 15, 5], center=true);
					sphere(r=0.5);
				}

				for (x=[-42, 42])
					translate([x, -10, -1]) cylinder(d=4+smidgen, h=6);		

				translate([0, 0, -1]) {
					segment(r=(id-20)/2, h=10, start=200, end=340);
					segment(r=id/2-0.4*thick, h=length+2, start=-135, end=-45);
				}

				for (rot = [0: 120: 360])
					rotate(a=[0, 0, rot]) translate([0, id/2-5, 0]) cylinder(r=2, h=2);

				translate([8, 38, thick-1]) logo(height=15, depth=2, text=false);
			}
			minkowski() {
				for (x=[-1, 1])
					for (y=[-1, 1])
						translate([x*57/2, 10+(y*25/2), thick+2]) cube([10, 7, 4], center=true);
				sphere(r=1);
			}
		}

		translate([0, 10, 8]) minkowski() {
			pi0_board();
			if (!fast) sphere(r=0.5);
		}
	}
}

module pi0_board() {
	cube([65, 30.5, 1], center=true);
	for (x=[-58/2, 58/2]) {
		// Hole diameters here are smaller than needed since
		// the board is expanded with a minkowski sum.
		for (y=[-23/2, 23/2])
			translate([x, y, -15]) cylinder(d=2, h=20);
		hull() for (y=[-23/2, 23/2])
			translate([x, y, -11]) cylinder(d=2, h=4);
	}
	translate([0, -5, -5]) cube([51, 45, 20], center=true);
}

// torus_arc renders a partial torus with the given major and minor radii.
// It does not depend on the rotate_extrude angle parameter and is brittle.
module torus_arc(rmaj, rmin, start=0, angle=90) {
	intersection() {
		translate([0, 0, -rmin]) segment(r=rmaj*2, h=rmin*2, start=start, end=start+angle);
		rotate_extrude() {
			translate([rmaj, 0, 0]) {
				circle(r=rmin);
			}
		}
	}
}

// segment exists to get around the absence of an angle parameter for
// rotate_extrude in this version of OpenSCAD.
module segment(r, h, start, end) {
	R = r * sqrt(2) + 1;
	a0 = (4 * start + 0 * end) / 4;
	a1 = (3 * start + 1 * end) / 4;
	a2 = (2 * start + 2 * end) / 4;
	a3 = (1 * start + 3 * end) / 4;
	a4 = (0 * start + 4 * end) / 4;
	if(end > start)
		linear_extrude(height=h)
			intersection() {
				circle(r);
				polygon([
					[0,0],
					[R * cos(a0), R * sin(a0)],
					[R * cos(a1), R * sin(a1)],
					[R * cos(a2), R * sin(a2)],
					[R * cos(a3), R * sin(a3)],
					[R * cos(a4), R * sin(a4)],
					[0,0]
				]);	
			}
}

module bites(id, length) {
	bite = id*0.3;
	translate([0, 0, length])
	for (rot = [0: 120: 240]) {
		scale([1, 1, length/50])
			hull() {
				translate([0, 0, -bite]) cylinder(h=bite*2, d=1);
				rotate(a=[90, 0, rot]) translate([0, 0, id/2]) cylinder(h=0.1, r1=0, r2=bite);
			}
	}
}

module hollow_cylinder(id, od, height) {
	difference() {
		cylinder(d=od, h=height);
		cylinder(d=id, h=height);
	}
}
