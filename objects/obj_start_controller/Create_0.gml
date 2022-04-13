#region SETTING TITLE SEQUENCE
START_TITLE_x = obj_camera.x;
START_TITLE_y = obj_camera.y-160;

//CREATING START TITLE SEQUENCE
layer_sequence_create("Sequences", START_TITLE_x, START_TITLE_y, seq_start_title);
#endregion


#region SETTING VARIABLES
//DRAWING INTERFACE - SETTING VARIABLES
draw_text_xl	= obj_camera.x-display_get_width()/1.9;		//DRAW TEXT X - LEFT
draw_text_xr	= obj_camera.x+display_get_width()/1.9;		//DRAW TEXT X - RIGHT
draw_text_y		= obj_camera.y-display_get_height()/1.9;	//DRAW TEXT Y - TOP
draw_text_yb	= obj_camera.y+display_get_height()/1.9;	//DRAW TEXT Y - BOTTOM

//PLAYER USING GAMEPAD FLAG
global.gamepad = 0; //0 - USING KEYBOARD, 1 - USING GAMEPAD

//INITIALISING DEVICE NUMBER
global.gamepad_device_number = 0;
#endregion


#region STARTING SOUND MANAGER
//DRAWING INTERFACE - SETTING SOUND MANAGER VALUES
sound_manager_width		= sprite_get_width(spr_button_audio);
sound_manager_height	= sprite_get_height(spr_button_audio);
sound_manager_x			= draw_text_xr-(sound_manager_width/2);
sound_manager_y_start	= draw_text_y+(sound_manager_height/2)+15;
sound_manager_y_game	= draw_text_y+(sound_manager_height/2)+60;

//CREATE SOUND MANAGER BUTTON
instance_create_layer(sound_manager_x, sound_manager_y_start, "Instances", obj_sound_manager);

//CHECK ANY ROOM CHANGE AND CHANGE SOUND BUTTON Y POSITION BASED ON THE ROOM
sound_manager = function() {
	var player_exists = instance_exists(obj_player);
	
	if not(player_exists) {
		obj_sound_manager.y = sound_manager_y_start;
		if (instance_exists(obj_controller)) obj_controller.pause_off = true;
	}
	else {
		switch(room) {
			case room_start:	obj_sound_manager.y = sound_manager_y_start break;
			case room_game:		obj_sound_manager.y = sound_manager_y_game break;
		}
	}
}
#endregion


#region STARTING FULLSCREEN BUTTON
fullscreen_sprite	= spr_button_fullscreen;
fullscreen_width	= sprite_get_width(fullscreen_sprite);
fullscreen_height	= sprite_get_height(fullscreen_sprite);
fullscreen_x		= draw_text_xl+(fullscreen_width/2);
fullscreen_y		= draw_text_y+(fullscreen_height/2)+10;
fullscreen_index	= 0;
fullscreen_xscale	= 1;
fullscreen_yscale	= 1;
fullscreen_newscale	= 1.2;

load_fullscreen();

fullscreen_mode = function() {
	draw_sprite_ext(fullscreen_sprite, fullscreen_index, fullscreen_x, fullscreen_y, fullscreen_xscale, fullscreen_yscale, image_angle, image_blend, image_alpha);
	
	var mouse_fullscreen_x = fullscreen_x-(fullscreen_width/2) <= mouse_x && mouse_x <= fullscreen_x+(fullscreen_width/2);
	var mouse_fullscreen_y = fullscreen_y-(fullscreen_height/2) <= mouse_y && mouse_y <= fullscreen_y+(fullscreen_height/2);
	var mouse_fullscreen = mouse_fullscreen_x && mouse_fullscreen_y;
	
	var key_fullscreen = keyboard_check_pressed(vk_f11);
	
	if (mouse_fullscreen) {
		fullscreen_xscale = fullscreen_newscale;
		fullscreen_yscale = fullscreen_newscale;
	}
	else {
		fullscreen_xscale = 1;
		fullscreen_yscale = 1;
	}
	
	var mouse_pressed = mouse_check_button_pressed(mb_left);
	if (mouse_pressed && mouse_fullscreen) || (key_fullscreen) {
		switch(fullscreen_index) {
			case 0: 
				fullscreen_index = 1; 
				window_set_fullscreen(true);
			break;
			
			case 1: 
				fullscreen_index = 0;
				window_set_fullscreen(false);
			break;
		}
		save_fullscreen();
	}
}
#endregion


#region SETTING START MENU
//CREATING MENU OBJECT
instance_create_layer(0, 0, "Instances", obj_start_menu);
#endregion


