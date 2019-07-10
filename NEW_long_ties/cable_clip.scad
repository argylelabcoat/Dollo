include <include.scad>;
include <globals.scad>;

use <long_tie.scad>;
use <mockups.scad>;

$fn=60;

module _clip(d=12) {
    rotate([90,180,0]) difference() {
        union() {
            scale([1.1,1,1.1]) rotate([90,0,0]) male_dovetail(15);
            translate([0,0,-d/2+(1.5-3*0.01*d)]) rotate([90,0,0]) difference() {
                cylinder(d=d, h=15);
                cylinder(d=d-3, h=16);
            }
        }
        rotate([0,9,0]) translate([-1,-15,-2]) cube([2,20,8]);
        rotate([0,-9,0]) translate([-1,-15,-2]) cube([2,20,8]);
    }
}

module clip_verylarge() {
    _clip(d=15);
}

module clip_large() {
    _clip(d=12);
}

module clip_small() {
    _clip(d=7);
}

module _shroud_holder(h=25,d=13.5,edge_h=1, gap=9) {
    outer_d = d + 5;
    difference() {
        hull() {
            cylinder(d=outer_d, h=h, $fn=30);
            translate([-outer_d/2,-outer_d/2,0]) cube([outer_d,1,h]);
        }
        cylinder(d=d-2, h=h+1, $fn=30);
        translate([0,0,edge_h]) cylinder(d1=d-2, d2=d, h=0.7, $fn=30);
        translate([0,0,edge_h+0.7]) cylinder(d=d, h=h+1-edge_h, $fn=30);
        translate([-gap/2,0,0]) cube([gap,outer_d,h+1]);
    }
}

module cable_shroud_frame_mount() {
    h = 25;
    d = 13.5;

    union() {
        difference() {
            rounded_cube_side(20,20,h+1,4);
            translate([8,0,0]) cube([30,40,30]);
            translate([8.01,20/2,0]) rotate([0,0,90]) male_dovetail(h+1.1);
        }

        translate([-(12+2.4)/2+0.01,10,0]) rotate([0,0,90]) _shroud_holder();
    }
}

module cable_shroud_frame_clip() {
    h = 25;
    d = 13.5;

    union() {
        difference() {
            rounded_cube_side(20,20,h+1,4);
            translate([8,0,0]) cube([30,40,30]);
            translate([8.01,20/2,0]) rotate([0,0,90]) male_dovetail(h+1.1);
        }

        translate([-(12+2.4)/2+0.01,10,0]) rotate([0,0,90]) _shroud_holder(edge_h=-1, gap=11);
    }
}

use <../../_downloaded/Customizable_Cable_Shroud/shroud-twirl-gap.scad>;

module cable_shroud_frame_clip2() {
    // params for shroud: 10 cable d, 2.1 spine d, height 15
    h = 14;
    w = 17;
    
    union() {
        difference() {
            union() {
                rounded_cube_side(w,20,h,4);
                translate([w/2,0,0]) cylinder(d=3.7,h=h,$fn=64);
            }
            translate([0,8,0]) cube([30,40,30]);
            translate([w/2,0,0]) cylinder(d=2.1,h=h,$fn=30);
            translate([w/2,8.01,0]) rotate([0,0,180]) male_dovetail(h+1.1);
        }
        translate([w/2,-5.40,0]) ring();
    }
}

module cable_shroud_motor_clip() {
    %rotate([90,0,0]) translate([0,0,-42.5/2]) mock_stepper_motor(false);
    
    module _body_form(side) {
        d = 500;
        difference() {
            hull() {
                translate([0,side/2-1/2,0]) cube([side,1,10],center=true);
                translate([0,-side/2+1/2,0]) cube([side-6,1,10],center=true);
            }
            translate([0,-d/2-side/2+0.7,0]) cylinder(d=d,h=11,center=true,$fn=400);
        }
    }
    
    difference() {
        union() {
            difference() {
                _body_form(motor_side_length+5);
                _body_form(motor_side_length+0.2);
                translate([0,-60/2-3,0]) cube([20,60,20],center=true);
            }
            translate([motor_side_length/2,motor_side_length/2]) rotate([90,0,45]) cylinder(d=5,h=12,center=true,$fn=40);
        }
        translate([motor_side_length/2,motor_side_length/2]) rotate([90,0,45]) cylinder(d=2.4,h=13,center=true,$fn=40);
    }
}

//clip_verylarge();
//clip_large();
//clip_small();
//cable_shroud_frame_mount();
//cable_shroud_frame_clip();
cable_shroud_frame_clip2();
//cable_shroud_motor_clip();