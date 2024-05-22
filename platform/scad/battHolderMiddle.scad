/*
DESCRIPTION
  Model of the wooden cut outs that are used around the batteries
  to hold them.

AUTHORS
  Saxon A. Nelson-Milton <saxon@ausocean.org>

LICENSE
  Copyright (C) 2020 the Australian Ocean Lab (AusOcean)

  It is free software: you can redistribute it and/or modify them
  under the terms of the GNU General Public License as published by the
  Free Software Foundation, either version 3 of the License, or (at your
  option) any later version.

  It is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  for more details.

  You should have received a copy of the GNU General Public License
  in gpl.txt.  If not, see http://www.gnu.org/licenses.
*/

include <consts.scad>
use <battHolderEnd.scad>

battHolderMiddle();

module battHolderMiddle(){
    difference(){
        battHolderEnd();
        translate([0,-battDisplacement-25,0])
        cube([battWidth,battHeight,holderEndWidth+1],center=true);
    }
}
