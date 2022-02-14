// See bottom for parameters

module holder(depth=50, wall_thickness=1, slots=4, slot_width=2.5, slot_depth=3, slot_depth_padding=1, slot_spacing=25) {
    holder_height = slot_depth + slot_depth_padding + wall_thickness;
    holder_wall_thickness = wall_thickness;
    holder_width = holder_wall_thickness * 2 + slot_width;
    holder_depth = depth < 10 ? 10 : depth;

    slot_count = slots -1;

    brace_width = holder_width < 10 ? 10 : holder_width;
    brace_length = slot_spacing * slot_count + holder_width;

    // Slots
    for (i=[0:slot_count]) {
        translate([i * slot_spacing, 0, 0])
        difference() {
            cube([holder_width,holder_depth,holder_height]);

            translate([holder_width-holder_wall_thickness-slot_width,0,holder_height-slot_depth])
                cube([slot_width,holder_depth,slot_depth]);
        };
    }

    // Braces
    for (i=[0:1]) {
        translate([0, (holder_depth - brace_width) * i, 0]) {
            difference() {
                // Brace
                cube([brace_length, brace_width, holder_wall_thickness]);

                // Brace holes
                brace_hole_size = 2;
                brace_hole_x_location = (
                    (slot_width + wall_thickness * 2) + (slot_spacing - wall_thickness * 2 - slot_width) / 2 - brace_hole_size/2
                );
                brace_hole_y_location = (brace_width / 2) - brace_hole_size/2;
                for (i=[0:slot_count - 1]) {
                    translate([brace_hole_x_location + slot_spacing * i + brace_hole_size/2, brace_hole_y_location + brace_hole_size/2, 0])
                    cylinder(r=brace_hole_size/2, h=wall_thickness, $fn=12);
                }
            }
        }
    }

    echo(str("Width:  ", brace_length, "mm"));
    echo(str("Depth:  ", holder_depth, "mm"));
    echo(str("Height: ", holder_height, "mm"));
}


holder(
    depth=50,               // Depth of the holder
    wall_thickness=1,       // Thickness of all walls
    slots=4,                // Amount of slots (16 fits width of a standard rack)
    slot_width=2.5,         // Width of the slots
    slot_depth=3,           // Depth of the slots
    slot_depth_padding=1,   // Extra padding for the slot depth, in addition to the wall thickness
    slot_spacing=25         // Spacing between each slot
);
