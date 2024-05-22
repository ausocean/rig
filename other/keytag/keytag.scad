/*
NAME
  keytag.scad

DESCRIPTION
  This file generates an AusOcean keychain tag.

AUTHOR
  Dan Kortschak <dan@ausocean.org>

LICENSE
  keytag.scad is Copyright (C) 2018 the Australian Ocean Lab (AusOcean)

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

$fn=30;

use <../logo/logo.scad>;

// Make a default size keytag ~70mm long.
keytag();

// keytag is an AusOcean logo keychain tag scaled by size.
// Because of the use of minkowski, this takes a long time to render.
module keytag(size=1) {
	scale([size, size, size])
		difference() {
			minkowski() {
				logo(text=false);
				sphere(r=2);
			}
			translate([0, 0, 1.5]) logo(text=false);
			translate([0, 0, -1.5]) logo(text=false);
			translate([0, 0, 3.5]) cube([200, 200, 2], center=true);
			translate([0, 0, -2.5]) cube([200, 200, 2], center=true);
			translate([12.5, 9.7, -5]) cylinder(h=10, r=1.5);
		}
}
