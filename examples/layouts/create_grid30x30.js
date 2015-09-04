/*
 * Model creation script for a 30x30 grid
 *
 * 2014 Juergen Skrotzky (JorgenVikingGod)
 * This file is released into the public domain.
 *
 * 30x30 grid layout (with 15 strips of 60 LEDs in zig-zag order):
 * ======================================================================
 * board 1 port 1 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 2 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 3 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 4 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 5 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 6 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 7 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 1 port 8 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 1 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 2 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 3 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 4 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 5 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 6 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * board 2 port 7 >> 01 02 03 ... 28 29 30 \ 
 *                   60 59 58 ... 33 32 31 /
 * ======================================================================
 */

var model = []
var scale = -1 / 8.0;
var centerX = 29 / 2.0;
var centerY = 29 / 2.0;

function grid30x2(index, x, y) {
    // Instance of a zig-zag 30x2 grid with upper-left corner at (x, y)
    for (var v = 0; v < 2; v++) {
        for (var u = 0; u < 30; u++) {
            var px = (v & 1) ? (x+29-u) : (x+u);
            var py = y + v;
            model[index++] = {
                point: [  (px - centerX) * scale, 0, (py - centerY) * scale ]
            };
        }
    }
}

// 15x zig-zag grids
var index = 0;
for (var v = 0; v < 29; v++) {
    grid30x2(index, 0, v*29);
    index += 60;
}

console.log(JSON.stringify(model));
