// Inherit the parent event
event_inherited();

dev_mode = false; //default: false

//Layers id's
collision = layer_get_id("Collision");
background_filter = layer_get_id("Background_Filter");
inside_wall = layer_get_id("Inside_Wall");
outside_wall = layer_get_id("Outside_Wall");