/*
NAME
  mast_insert.scad

DESCRIPTION
  This file generates a mast insert to allow mounting electronic components
  within an AusOcean rig mast.

AUTHOR
  Dan Kortschak <dan@ausocean.org>

LICENSE
  mast_insert.scad is Copyright (C) 2017 the Australian Ocean Lab (AusOcean)

  It is free software: you can redistribute it and/or modify them
  under the terms of the GNU General Public License as published by the
  Free Software Foundation, either version 3 of the License, or (at your
  option) any later version.

  It is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  for more details.

  You should have received a copy of the GNU General Public License
  along with revid in gpl.txt. If not, see http://www.gnu.org/licenses.

*/

$fn=100;

use <../logo/logo.scad>;

module slot(length=75, width=4, depth=5) {
	hull() {
		translate([-(length-width)/2, 0, 0]) cylinder(d=width, h=depth);
		translate([(length-width)/2, 0, 0]) cylinder(d=width, h=depth);
	}
}

// mast_insert constructs an AusOcean rig mast insert with the given dimensions.
// If which is "top" only the top of the insert is constructed and if "bottom" only the
// bottome. The dimenssion lenght is in number of slots.
module mast_insert(diameter=86, length=10, thick=5, slotdist=20, slotwidth=4, which) {
	difference() {
		// Overall shape of insert.
		intersection() {
			translate([-diameter/2, 0, 0]) cube([diameter, slotdist*length, (diameter+thick)/2]);
			translate([0, 0, thick/2]) rotate(a=[-90, 0, 0]) cylinder(d=diameter, h=slotdist*length);
		}

		// Remove tunnel volume.
		intersection() {
			translate([-diameter/2, -1, thick]) cube([diameter, slotdist*length+2, (diameter-thick)/2]);
			translate([0, -1, thick/2]) rotate(a=[-90, 0, 0]) cylinder(d=diameter-2*thick, h=slotdist*length+2);
		}

		// Make access to raft.
		hull() {
			translate([-diameter/2, 0, slotdist/2+thick]) {
				translate([0, 1.5*slotdist, 0]) {
					rotate(a=[0, 90, 0]) cylinder(d=slotdist, h=diameter);
					translate([0, -slotdist/2, 0]) cube([diameter, 1, diameter/2]);
				}

				translate([0, length*slotdist-1.5*slotdist, 0]) {
					rotate(a=[0, 90, 0]) cylinder(d=slotdist, h=diameter);
					translate([0, slotdist/2-1, 0]) cube([diameter, 1, diameter/2]);
				}
			}
		}

		// Remove circle cuts from ends.
		if (which == undef || which == "bottom") {
			translate([0, -31, 0]) cylinder(r=40, h=10);
		}
		if (which == undef || which == "top") {
			translate([0, slotdist*length+31, 0]) cylinder(r=40, h=10);
		}

		// Make slots.
		for(off = [1 : 1 : length-1]) {
			translate([0, slotdist*off, 0])
				slot(length=diameter-2*(thick+0.5), width=slotwidth, depth=thick);
		}

		// Add logo to bottom end.
		if (which == undef || which == "bottom") {
			translate([0, 30, 0])
				scale([-1, 1, 1])
					logo(height=slotdist-slotwidth-2);
		}

		// Remove ends if not needed.
		if (which == "bottom") {
			translate([-diameter/2, slotdist*length-slotdist/2, 0]) cube([diameter, slotdist/2, 5]);
			translate([-diameter/2, slotdist*length-1.5*slotdist, thick]) cube([diameter, 1.5*slotdist, diameter/2]);
		} else if (which == "top") {
			translate([-diameter/2, 0, 0]) cube([diameter, slotdist/2, 5]);
			translate([-diameter/2, 0, thick]) cube([diameter, 1.5*slotdist, diameter/2]);
		}
	}
}

// Make a default single model mast insert.
mast_insert();

// Make a top half model insert.
//mast_insert(length=5, which="top");

// and the bottom half model insert.
//mast_insert(length=6, which="bottom");
