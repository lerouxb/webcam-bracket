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

// millimeters of infill between walls
infill = 5;

thickness = (2*shellThickness+infill);

// Don't do the strengthening bar all the way so that we don't interfere with
// where the camera has to be strapped on to.
cameraClearance = 40;

// A part sticking out next to the main bracket to easily clamp it down with a
// bulldog clip. Only on one side so that this can still be printed flat.
// I had this 40mm, but then it collides with the linear bearings
toungeLength = 30;
toungeWidth = width;

// The lip goes over the build platform so you can slide the bracket on.
// This is just about the only critical size in here. Measure the bed!
// TIP: print a tiny little bracket with the gap first and test fit that before
// you waste hours and lots of plastic.
lipGap = 3.7;
// If you make this too big, then you're going to cut into your print area.
lipOverlap = 10+wallWidth;

// Two crossbars for strength. Try and place the outer crossbar where the
// shortest strengthening bar ends and then the inner one goes at half that.
crossbarOffset = length - max(cameraClearance, toungeLength);
halfCrossbarOffset = crossbarOffset / 2;

module crossbar(offset) {
  translate([offset+wallWidth, wallWidth, 0])
  rotate([0, 0, 45+90])
  cube([sqrt(2)*offset, wallWidth, width]);
}

module rightAngle(w1, h1, w2, h2, depth) {
  difference() {
    cube([w1, h1, depth]);
    translate([w1-w2, h1-h2, 0])
    cube([w2, h2, depth]);
  }
}

rotate([0, 0, 180])
translate([-length/2, -length/2, 0]) {
  union() {
    // main
    rightAngle(
      length, length,
      length-thickness, length-thickness,
      width);

    // crossbars
    crossbar(crossbarOffset);
    crossbar(halfCrossbarOffset);

    // tounge
    translate([0, length-toungeLength, toungeWidth])
    cube([thickness, toungeLength, toungeWidth]);

    // lip
    translate([lipGap+thickness+wallWidth, length-(toungeLength+wallWidth), 0])
    rotate([0, 0, 90])
    rightAngle(
      lipOverlap+wallWidth, lipGap+wallWidth,
      lipOverlap, lipGap,
      width);
  }
}
