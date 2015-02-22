// Sized to fit on a 150x150 bed, leaving enough room for a brim.
length=140;

// This is meant to be about the exact width of the Logitech C310's
// clip/bracket thing. Other cameras in the series hopefully have the same size
// or some similar setup.
width=35;

// The thickness that walls will be printed at on your printer. This is to
// prevent infill, so things print fast. (We're going to use 2 x shell
// thickness.)
shellThickness = 0.8;
wallWidth = 2 * shellThickness;

// A crossbar for strength. Put it wherever.
crossbarOffset = 55;

// A part sticking out next to the main bracket to easily clamp it down with a
// bulldog clip. Only on one side so that this can still be printed flat.
lipWidth = 20;
lipLength = width;

// Extra part on the inside to stop things from bending. This is meant to end
// before the camera part starts so as not to interfere with rubber bands there
// and also to not overlap with the bed.
strengthWidth = 10;
strengthLength = 110;

translate([-length/2, -lenth/2, 0]) {
  union() {
    // main
    difference() {
      cube([length, length, width]);
      translate([wallWidth, wallWidth, 0])
      cube([length-wallWidth, length-wallWidth, width]);
    }

    // crossbar
    translate([crossbarOffset+wallWidth, wallWidth, 0])
    rotate([0, 0, 45+90])
    cube([sqrt(2)*crossbarOffset, wallWidth, width]);

    // lip
    translate([0, length-lipWidth, lipLength])
    cube([wallWidth, lipWidth, lipLength]);

    // strength
    difference() {
      cube([strengthLength, strengthLength, wallWidth]);
      translate([strengthWidth, strengthWidth, 0])
      cube([strengthLength-strengthWidth, strengthLength-strengthWidth, wallWidth]);
    }
  }
}
