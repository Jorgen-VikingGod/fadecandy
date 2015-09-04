/*
 * Model creation script for a 15x15 grid
 *
 * 2014 Juergen Skrotzky (JorgenVikingGod)
 * This file is released into the public domain.
 *
 * 15x15 grid layout (with 7 strips of 30 LEDs and 1 strip with 15 LEDs):
 * ======================================================================
 * port 1 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 2 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 3 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 4 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 5 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 6 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 7 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 \ 
 *           30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 /
 * port 8 >> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
 * ======================================================================
 */

var model = []
var scale = -1 / 8.0;
var centerX = 14 / 2.0;
var centerY = 14 / 2.0;

function grid15x2(index, x, y) {
    // Instance of a zig-zag 15x2 grid with upper-left corner at (x, y)
    for (var v = 0; v < 2; v++) {
        for (var u = 0; u < 15; u++) {
            var px = (v & 1) ? (x+14-u) : (x+u);
            var py = y + v;
            model[index++] = {
                point: [  (px - centerX) * scale, 0, (py - centerY) * scale ]
            };
        }
    }
}
function strip15(index, y) {
    // Instance of a strip of 15 LEDs upper-left corner at (x, y)
    for (var x = 0; x < 15; x++) {
        model[index++] = {
            point: [  (x - centerX) * scale, 0, (y - centerY) * scale ]
        };
    }
}

// Eight zig-zag grids
var index = 0;
for (var v = 0; v < 14; v++) {
    grid15x2(index, 0, v*14);
    index += 30;
}
strip15(index, 0, 0);

console.log(JSON.stringify(model));
