// kw10.scad
// Kwikset KW10 key blank generator (based on kwikset module)
// Outline/warding currently uses KW1 profile

use <keygen.scad>
include <kwikset.gen.scad>

// ---- KW10 OUTLINE + WARDING ----
// Placeholder: using KW1 data until KW10 trace is added
warding_kw10_points = warding_kw1_points;
warding_kw10_paths  = warding_kw1_paths;

outline_kw10_points = outline_points;
outline_kw10_paths  = outline_paths;

engrave_kw10_points = engrave_points;
engrave_kw10_paths  = engrave_paths;

// ---- KW10 MODULE ----
module kwikset_kw10(bitting="") {

    name = "Kwikset KW10";

    outlines_k = ["KW10"];
    outlines_v = [[outline_kw10_points, outline_kw10_paths,
                   [-outline_kw10_points[34][0], -outline_kw10_points[26][1]],
                   engrave_kw10_points,
                   engrave_kw10_paths]];

    wardings_k = ["KW10"];
    wardings_v = [warding_kw10_points];

    outline_param   = key_lkup(outlines_k, outlines_v, "KW10");
    outline_points  = outline_param[0];
    outline_paths   = outline_param[1];
    offset          = outline_param[2];
    engrave_points  = outline_param[3];
    engrave_paths   = outline_param[4];

    warding_points  = key_lkup(wardings_k, wardings_v, "KW10");
    
    // ---- KW10 SPACINGS ----
    // Shoulder-to-pin-center distances, in inches -> mm
    cut_locations = [for (i=[0.2470, 0.3970, 0.5470, 0.6970, 0.8470, 0.9970]) i*25.4];

    // ---- KW10 DEPTH TABLE ----
    // Width at bottom of cut, in inches -> mm
    depth_table = [for (i=[0.335, 0.329, 0.306, 0.283, 0.260, 0.237, 0.214, 0.191]) i*25.4];

    heights = key_code_to_heights(bitting, depth_table);

    difference() {
        if($children == 0) {
            key_blank(outline_points,
                      warding_points,
                      outline_paths=outline_paths,
                      engrave_right_points=engrave_points,
                      engrave_right_paths=engrave_paths,
                      engrave_left_points=engrave_points,
                      engrave_left_paths=engrave_paths,
                      offset=offset,
                      plug_diameter=12.7);
        } else {
            children(0);
        }
        key_bitting(heights, cut_locations, 2.1336, 90);
    }
}

// ---- Defaults ----
bitting="";
kwikset_kw10(bitting);
