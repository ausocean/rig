/*
NAME
  mast_light_cap.scad

DESCRIPTION
  This file generates a mast mast_light_cap for protecting electronic components
  within an AusOcean rig mast.

AUTHOR
  Dan Kortschak <dan@ausocean.org>

LICENSE
  mast_light_cap.scad is Copyright (C) 2017 the Australian Ocean Lab (AusOcean)

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

$fn=100;

use <../logo/logo.scad>;

module mast_light_cap(id=44.2, od=53, length=6, thick=3, edge=1.5, gusset=5, inset=4.5) {
    difference() {
        // Make the general shape with a rounded bottom edge.
        translate([0, 0, edge]) minkowski() {
            cylinder(h=length-2*edge, d=id-2*edge+(od-id)/2+0.2);
            sphere(r=edge);
        }
        
        // Hollow out cap.
        translate([0, 0, thick+gusset]) minkowski() {
            cylinder(h=length-thick, d=id-thick-2*gusset);
            sphere(r=gusset);
        }
        
        // Make lip for cap.
        translate([0, 0, length-inset]) difference() {
            cylinder(h=length, d=id+2.2*2+1);
            cylinder(h=length, d=id);
        }
        
        // Add logo to top.
        scale([-1, 1, 1]) logo(width=od*0.8);
    }
}

// Make a default model inset cap.
mast_light_cap();


// The following code generates a cap that provides greater protection
// from water ingress. It is retained in case it will be useful later.

module cap_flanged(id=44.2, od=53, length=8, thick=3, edge=2, gusset=5, inset=3) {
    difference() {
        // Make the general shape with a rounded bottom edge.
        translate([0, 0, edge]) minkowski() {
            cylinder(h=length-2*edge, d=od-2*edge);
            sphere(r=edge);
        }
        
        // Hollow out cap.
        translate([0, 0, thick+gusset]) minkowski() {
            cylinder(h=length-thick, d=id-thick-2*gusset);
            sphere(r=gusset);
        }
        
        // Make lip for cap.
        translate([0, 0, length-inset]) difference() {
            cylinder(h=length, d=id+2.2*2);
            cylinder(h=length, d=id);
        }
        
        // Add logo to top.
        scale([-1, 1, 1]) logo(width=od*0.8);
    }
}
