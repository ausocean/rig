/*
DESCRIPTION
Models the assembly of the batteries and battery rack.

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
use <batteries.scad>
use <threadedRod.scad>
use <batteriesRack.scad>

batteryAssembly();

module batteryAssembly(){
    translate([0,-battDisplacement,0]) batteries();
    batteriesRack();
    rodDisplacement = 65;
    translate([rodDisplacement,0,0]) threadedRod();
    translate([-rodDisplacement,0,0]) threadedRod();
}
