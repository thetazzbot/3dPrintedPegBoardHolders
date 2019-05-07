// Cheat Sheet
// Variables
$fn=32;
// tool handle diameter
td = 24;
td2 = td+2;
// peg holder height, 10 mm is good for starter
ht = 10;
// thickness of backing board
backing_board = 1.75;
// peg hole size, diameter
peg_size = 6.75;
// shell width
shell = 1.5;
// number of tools
tools = 1;
// spacing between tools
spacing = 0;
// number of pegs
pegs = 2;
// tools connected?
connected = false;

// Facets
// Body
x1 = ((td+shell)/2)*cos(00);
y1 = ((td+shell)/2)*sin(00);
x2 = ((td-shell/2)/2)*cos(40);
y2 = ((td-shell/2)/2)*sin(52.5);
x3 = ((td-shell/2)/2)*cos(0);
tx = 0; // tool x
for(n = [0 : (25+spacing): (tools-1)*(25+spacing)]) {
    translate([0,n,0]) {
        translate([-(td2/2)-shell,0,0]) difference() {
            cylinder(r1=(td/2)+shell,r2=(td2/2)+shell,h=ht,center=true);
            // we could make the inner a bit like a code if we could figure out
            // the ratio
            translate([-shell,0,0]) cylinder(r1=(td/2),r2=(td2/2),h=ht+2,center=true);
            translate([-x1,-y1,0]) cylinder(r=(td/2)-shell,h=ht,center=true);
        }
        *translate([-x2,-y2,-(ht/2)]) cylinder(r=1.1,h=ht);
        *translate([-x2,y2,-(ht/2)]) cylinder(r=1.1,h=ht);
        translate([(peg_size/2),0,0]) fit_peg();
    }
    
}
if(tools>1 && connected) {
    translate([-shell,0,-ht/2]) cube([shell,(tools-1)*(25+spacing),ht]);
}

module fit_peg()
{
    rotate([0,-90,0]) difference() {    
    union() {
        translate ([0,0,0]) 
            sphere(peg_size/2);
        translate ([0,0,0]) 
            cylinder(h = backing_board+3, r = (peg_size-1)/2);
    }
    rotate([0,0,-90]) {
        translate([0,peg_size-.5,1]) cube([peg_size,peg_size,peg_size],center=true);
        translate([0,-peg_size+.5,1]) cube([peg_size,peg_size,peg_size],center=true);
        translate([0,0,-1]) cube([peg_size/4,peg_size,peg_size],center=true);
        }
    }
}
    

