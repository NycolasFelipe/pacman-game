if (dev_mode) {	
	//DEV MODE OFF
	dev_mode = false;
	
	layer_set_visible(collision, false);
	layer_set_visible(background_filter, true);
	layer_set_visible(inside_wall, true);
	layer_set_visible(outside_wall, true);
}
else {
	//DEV MODE ON
	dev_mode = true;
	
	layer_set_visible(collision, true);
	layer_set_visible(background_filter, false);
	layer_set_visible(inside_wall, false);
	layer_set_visible(outside_wall, false);
}