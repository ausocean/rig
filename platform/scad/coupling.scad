/*
DESCRIPTION
  Basic model of 150mm stormwater threaded access coupling.

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

coupling();

module coupling(){
    difference(){
        color("white")
        cylinder(
            h=couplingLength,
            d=couplingOuterDiameter,
            center=true
        );

        color("white")
        cylinder(
            h=couplingLength+1,
            r=couplingInnerDiameter/2,
            center=true
        );
    }
}
