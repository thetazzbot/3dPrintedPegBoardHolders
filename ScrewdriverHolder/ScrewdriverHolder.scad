// Cheat Sheet
//This is a work in progress.
//
//I made this thing to fit my metal pegboard rack that I recently purchased.  Most of the pegboard holders that i see on Thingiverse waste plastic, so I wanted a minimalist design that was fast to print and conservative on plastic.
//
//There are several variables that you can tweak.
//
//All measurements in millimeter, but I'm in the USA so my sizes are relative to standard US pegboards.
//
//top_diameter = Tool Diameter; measure your screw driver handle and enter the value in milimeters here
//bottom_diameter = if you want a concave inside cylinder, to better fit the handle of a screw driver, enter a value like top_diameter + 2 (meaning two mm wider than the tool handle diameter)
//heigholder_height = 10; this is the heigholder_height of the tool holder.  10 mm is good 'nuff
//pegboard_thickness = 1.75; my metal peg board size; wooden boards are like 6 mm i believe, measure it to be sure.
//peg_size = 6.75; standard US size here.  Fits snugly and doesn't fall out.
//shell=1.5; thickness of the basic holder
//holders=1; number of holders.
//pegs=2; experimental; I added this to just see if it worked, but needs work.  Leave it for now at 2.
//spacing=0; additional spacing between holders.  For larger holders they may overlap if you don't put a value here.
//holders_connected=false; if you want the holders to be connected by a length of plastic.  See photos.


// Variables
// Tool Holder Top Inner Diameter
top_diameter = 24;
//Tool Holder Bottom Inner Diameter
bottom_diameter = 26;
// Tool holder heigholder_height, 10 mm is good for starter
holder_height = 10;
// Thickness of backing board
pegboard_thickness = 1.75;
// Peg size, diameter
peg_size = 6.75;
// Peg hole spacing (US=25.4)
peg_spacing = 25.4;
// Holder shell thickness
shell = 1.5;
// Number of holders
holders = 5;
// spacing between holders
spacing = 5;
// Holders connected? 
holders_connected = "yes"; // [yes,no]


// Facets
// Number of facets (higher # = smoother but time intensive)
$fn=32;

/* [Hidden] */
// The Code
x1 = ((top_diameter+shell)/2)*cos(00);
y1 = ((top_diameter+shell)/2)*sin(00);
x2 = ((top_diameter-shell)/2)*cos(46);
y2 = ((top_diameter-shell)/2)*sin(62.5);
x3 = ((top_diameter-shell/2)/2)*cos(0);
tx = 0; // tool x
for(n = [0 : 1 : holders-1]) { //(peg_spacing+spacing): (holders-1)*(peg_spacing+spacing)]) {
    translate([0,(n*(peg_spacing+spacing)),0]) {
        translate([-(bottom_diameter/2)-shell,0,0]) difference() {
            // outside cylinder
            color("red") cylinder(r=(top_diameter/2)+shell+1,h=holder_height,center=true);
            // we could make the inner a bit like a code if we could figure out
            // the ratio
            // inside cylinder
            translate([-shell,0,0]) color("blue") cylinder(r1=(bottom_diameter/2),r2=(top_diameter/2),h=holder_height+2,center=true);
            // cutout cylinder
            translate([-x1,-y1,0]) cylinder(r=(top_diameter/2)-shell,h=holder_height,center=true);
        }
        // these two lines are supposed to put a small pin at the edges of the holder
        // to add grip, but they aren't working at the moment.  too much math.
        *translate([-x2-((bottom_diameter-shell)),-y2,-(holder_height/2)]) cylinder(r=.75,h=holder_height);
        *translate([-x2-((bottom_diameter-shell)),y2,-(holder_height/2)]) cylinder(r=.75,h=holder_height);
         translate([(peg_size/2),0,0]) fit_peg();
    }
    
}
if(holders>1 && holders_connected=="yes") {
    translate([-shell,0,-holder_height/2]) cube([shell,(holders-1)*(25+spacing),holder_height]);
}

module fit_peg()
{
    rotate([0,-90,0]) difference() {    
    union() {
        translate ([0,0,0]) 
            sphere(peg_size/2);
        translate ([0,0,0]) 
            cylinder(h = pegboard_thickness+3, r = (peg_size-1)/2);
    }
    rotate([0,0,-90]) {
        translate([0,peg_size-.5,1]) cube([peg_size,peg_size,peg_size],center=true);
        translate([0,-peg_size+.5,1]) cube([peg_size,peg_size,peg_size],center=true);
        translate([0,0,-1]) cube([peg_size/4,peg_size,peg_size],center=true);
        }
    }
}
    

