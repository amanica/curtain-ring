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

inside_ring_diameter = 55;

rt = 10;         // Thickness of ring
rd = inside_ring_diameter + rt;         // Diameter of outside of ring

zcrop = 0.4;       // Crop bottom say 0.3mm to make it more printable, or print a raft
final_height = rt - 2* zcrop;

ld = rt;         // Lug diameter
lt = 5;          // Lug thickness
hd = 4; //(ld - 2 * zcrop) * 0.6;   // Hole diameter
margin = 1;

precision = 200; // Circular precision
first_lug_hole_xoffset = 1;
second_hole_xoffset = hd/2 + first_lug_hole_xoffset;
lug_xoffset = ld/2 + hd + first_lug_hole_xoffset;

module curtainring() {

    difference() {

        // Things that exist
        union() {
            rotate_extrude( convexity = 10, $fn = precision )
                translate([rd/2, rt/2, 0])
                    circle( r = rt/2 );
            hull() {
                translate([ rd/2, lt/2, ld/2])
                    rotate([90,0,0])
                    cylinder( h = lt, r = ld/2, $fn = precision );
                translate([ rd/2 + lug_xoffset, lt/2, ld/2])
                    rotate([90,0,0])
                    cylinder( h = lt, r = ld/2, $fn = precision );
            }
        }

        // Things to be cut out
        union() {
            // first lug hole
            translate([ rd/2 + lug_xoffset - first_lug_hole_xoffset, lt/2 + margin, ld/2])
                rotate([90,0,0])
                cylinder( h = lt +2*margin, r = hd/2, $fn = precision );
            // second lug hole
            translate([ rd/2 + lug_xoffset - second_hole_xoffset, lt/2 + 2*margin, ld/2])
                rotate([90,0,0])
                cylinder( h = lt + 4*margin, r = hd/2, $fn = precision );
            // little ears between lug holes
            translate([ rd/2 + lug_xoffset - second_hole_xoffset ,- lt/2 -3*margin, rt/2 - hd/2])
                cube( [second_hole_xoffset - first_lug_hole_xoffset,lt + 6*margin,hd] );

            // zcrop top
            translate( [-rd, -rd, rt - zcrop] )
                cube( [rd * 2, rd * 2, rt] );
	    // zcrop bottom
            translate( [-rd, -rd, -rt + zcrop] )
                cube( [rd * 2, rd * 2, rt] );
        }
    }

}

translate( [0, 0, -zcrop] )
    curtainring();

