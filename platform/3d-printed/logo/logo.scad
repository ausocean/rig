/*
NAME
  logo.scad

DESCRIPTION
  This file generates an AusOcean logo solid.

AUTHOR
  Dan Kortschak <dan@ausocean.org>

LICENSE
  logo.scad is Copyright (C) 2017 the Australian Ocean Lab (AusOcean)

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

// logo renders an AusOcean cuttlefish logo width wide or height high, and
// depth deep. By default the logo is rendered 100mm wide and 1mm deep.
module logo(width, height, depth=1, text=true) {
	path = text ? "AusOcean_logo.dxf": "AusOcean_logo_notext.dxf";
	linear_extrude(height=depth)
	if (width != undef) {
		scale(width/212)
			translate([-212/2, -68/2, 0])
				import(path);
	} else if (height != undef) {
		scale(height/68)
			translate([-212/2, -68/2, 0])
				import(path);
	} else {
		scale(100/212)
			translate([-212/2, -68/2, 0])
				import(path);
	}
}
