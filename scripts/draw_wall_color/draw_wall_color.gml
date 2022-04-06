///@method draw_wall_color(wall_set, length, index, delay, time)
function draw_wall_color() {
	obj_controller.wall_color_time--;
	
	with (obj_wall) {
		switch (wall_area) {
			case 0: with (obj_controller) wall_color = wall_set[wall_color_index][0] break;
			case 1: with (obj_controller) wall_color = wall_set[wall_color_index][1] break;
		}
		
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, obj_controller.wall_color, image_alpha);
		gpu_set_blendmode(-1);
	}
	
	with (obj_controller) {
		if (wall_color_time <= 0) {
			wall_color_time = wall_color_delay;
		
			if (wall_color_index < wall_set_length-1) wall_color_index++;
			else wall_color_index = 0;
		}
		
		//INCREASING SPEED ACCORDING TO PLAYER'S LEVEL
		wall_color_delay = wall_color_delay_default-10*(player_level-1);
	}
}