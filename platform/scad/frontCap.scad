/*
DESCRIPTION
  models the assembly of the front cap, transducer and two reed switches
  for controlling on/off state.

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
use <threadedCap.scad>
use <transducer.scad>
use <reedSwitch.scad>

frontCap();

module frontCap(){
    transducer();
    translate([0,reedSwitchDisplacement,0]) reedSwitch();
    translate([0,-reedSwitchDisplacement,0]) reedSwitch();
    color("white",alpha) threadedCap();
}
