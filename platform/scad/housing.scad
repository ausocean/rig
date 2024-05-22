/*
DESCRIPTION
  Models assembly of the "housing", which includes the pipe, access couplings
  and caps.

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
use <pipe.scad>
use <coupling.scad>
use <threadedCap.scad>
use <frontCap.scad>

housing();

module housing(){
    translate([0,0,pipeLength/2+couplingLength/2])
    frontCap();
    color("white",alpha){
        pipe();

        // Add couplings.
        translate([0,0,pipeLength/2]) coupling();
        translate([0,0,-pipeLength/2]) coupling();

        translate([0,0,-pipeLength/2-couplingLength/2])
        rotate([180,0,0])
        threadedCap();
    }
}
