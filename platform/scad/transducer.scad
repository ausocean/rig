/*
DESCRIPTION
  Basic model of a surface transducer (aka vibration speaker).

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

transducer();

module transducer(){
    baseHeight = 25;
    boltHeight = 3;
    plateHeight = 2;

    translate([0,0,-((baseHeight/2)+boltHeight+plateHeight)]) {
        color([0.2,0.2,0.2])
        cylinder(h=baseHeight,d=40,center=true);

        color("silver")
        translate([0,0,(baseHeight/2)+(boltHeight/2)])
        cylinder(h=boltHeight,d=10,center=true);

        color("silver")
        translate([0,0,(baseHeight/2)+(boltHeight)+(plateHeight/2)])
        cylinder(h=plateHeight,d=35,center=true);
    }
}
