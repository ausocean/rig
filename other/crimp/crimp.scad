/*
NAME
	crimp.scad

DESCRIPTION
	This file generates a connector crimper. For 2 pin JST Connectors
	02HR-6S-P-N 2.5mm pitch/Disconnectable Insulation displacement
	connectors.
	http://www.jst-mfg.com/product/detail_e.php?series=115
	http://www.jst-mfg.com/product/pdf/eng/eHR2.pdf


AUTHOR
	Dan Kortschak <dan@ausocean.org>

LICENSE
	crimp.scad is Copyright (C) 2018 the Australian Ocean Lab (AusOcean)

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

// Print with 100% infill and 0.05mm layer height.

$fn=100;

press();

module press() {
	translate([0, 0, -3]) cylinder(r=6, h=3);
	translate([-1.25, 0, 0]) press_pins();
	translate([1.25, 0, 0]) press_pins();
}

module press_pins() {
	w = 1.2;
	translate([-w/2, 0, 0]) { // Total of 3.5 long.
		cube([w, 1.0, 2.25]);
		translate([0, 1.5, 0,]) cube([w, 0.5, 2.25]);
		translate([0, 2.5, 0,]) cube([w, 0.5, 2.25]);
	}
	translate([-1.0, -2.0, 0])
		cube([2.0, 2.0, 2.25]);
	translate([-0.75, -1, 2.25])
		rotate(a=[0, 0, 90])
			prism(2.0, 0.5, 0.3);
	translate([0.75, -1, 2.25])
		rotate(a=[0, 0, -90])
			prism(2.0, 0.5, 0.3);
}

module prism(l, w, h){
	translate([-l/2, -w/2, 0])
		polyhedron(
			points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
			faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
		);
}


