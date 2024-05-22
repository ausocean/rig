/*
DESCRIPTION
  Models the wooden cut out that is at the ends of the batteries and holds them
  together.

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

battHolderEnd();

module battHolderEnd(){
    difference(){
        color(woodColor) cylinder(h=holderEndWidth,d=holderEndDiameter,center=true);
        translate([65,0,0]) cylinder(h=woodThickness+1,d=8,center=true);
        translate([-65,0,0]) cylinder(h=woodThickness+1,d=8,center=true);
    }
}
