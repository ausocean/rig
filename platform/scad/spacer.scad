/*
DESCRIPTION
  Model of the wooden "spacer" that separates the battery assembly from
  the front cap. NB: the electronics jiffy box is also included here.

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

spacer();

module spacer(){
    color(woodColor)
    translate([0,0,woodThickness/2])
    cylinder(h=woodThickness,d=pipeInternalDiameter,center=true);

    color(woodColor)
    translate([0,-50,(spacerLegHeight/2)+woodThickness])
    cube([spacerLegLength,woodThickness,spacerLegHeight],center=true);

    color(woodColor)
    translate([0,50,(spacerLegHeight/2)+woodThickness])
    cube([spacerLegLength,woodThickness,spacerLegHeight],center=true);

    // Electronics jiffy box.
    color("grey")
    translate([0,0,20+woodThickness])
    cube([80,80,40],center=true);
}
