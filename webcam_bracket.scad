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

// Don't do the strengthening bar all the way so that we don't interfere with
// where the camera has to be strapped on to.
cameraClearance = 40;

// A part sticking out next to the main bracket to easily clamp it down with a
// bulldog clip. Only on one side so that this can still be printed flat.
toungeWidth = 40;
toungeLength = width;

// Extra part on the inside to stop things from bending. This is meant to end
// before the camera part starts so as not to interfere with rubber bands there
// and also to not overlap with the bed.
strengthWidth = 10;
strengthCamera = length - cameraClearance;
strengthTounge = length - toungeWidth;

// The lip goes over the build platform so you can slide the bracket on.
// This is just about the only critical size in here. Measure the bed!
lipGap = 3.5;
// If you make this too big, then you're going to cut into your print area.
lipOverlap = 10+wallWidth;

// Two crossbars for strength. Try and place the outer crossbar where the
// shortest strengthening bar ends and then the inner one goes at half that.
crossbarOffset = min(strengthCamera, strengthTounge);
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
translate([-length/2, -lenth/2, 0]) {
  union() {
    // main
    rightAngle(
      length, length,
      length-wallWidth, length-wallWidth,
      width);

    // crossbars
    crossbar(crossbarOffset);
    crossbar(halfCrossbarOffset);

    // tounge
    translate([0, length-toungeWidth, toungeLength])
    cube([wallWidth, toungeWidth, toungeLength]);

    // strength
    rightAngle(
      strengthCamera, strengthTounge,
      strengthCamera-strengthWidth, strengthTounge-strengthWidth,
      wallWidth);

    // lip
    // subtracting a bit to get around the 2-manifold thing..
    translate([lipGap+wallWidth, strengthTounge-0.1, 0])
    rotate([0, 0, 90])
    rightAngle(
      lipOverlap, lipGap,
      lipOverlap-wallWidth, lipGap-wallWidth,
      width);
  }
}
