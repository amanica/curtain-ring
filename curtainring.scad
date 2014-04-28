// curtainring.scad
// Curtain Ring
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


// Global Parameters
rd = 70;         // Diameter of ring
rt = 10;         // Thickness of ring
ld = rt;         // Lug diameter
lt = 3;          // Lug thickness
hd = ld * 0.6;   // Hole diameter
zcrop = 0;       // Crop bottom say 0.3mm to make it more printable, or print a raft
precision = 200; // Circular precision

module curtainring() {

    difference() {

        // Things that exist
        union() {
            rotate_extrude( convexity = 10, $fn = precision )
                translate([rd/2, rt/2, 0])
                    circle( r = rt/2 );
            hull() {
                translate([ rd/2, 0, ld/2])
                    rotate([90,0,0])
                    cylinder( h = lt, r = ld/2, $fn = precision );
                translate([ rd/2 + ld, 0, ld/2])
                    rotate([90,0,0])
                    cylinder( h = lt, r = ld/2, $fn = precision );
            }
        }

        // Things to be cut out
        union() {
            translate([ rd/2 + ld, 0, ld/2])
                rotate([90,0,0])
                cylinder( h = lt, r = hd/2, $fn = precision );
            translate( [-rd, -rd, -rt + zcrop] )
                cube( [rd * 2, rd * 2, rt] );

        }
    }

}

translate( [0, 0, -zcrop] )
    curtainring();

