//STARTING BACKGROUND TITLE SCREEN MUSIC
audio_play_sound(snd_game_start_screen, 0, true);

#region SETTING MENU VALUES
#macro START_MENU_H_WIDTH 200	//HALF MENU WIDTH
#macro START_MENU_H_HEIGHT 100	//HALF MENU HEIGHT	

MENU_YPOS = 100;

MENU_COORD = [
	//MENU, MENU OPEN, MENU CLOSED
	[0, (room_width/2)-START_MENU_H_WIDTH, room_width/2],				//MENU_x1
	[0, (room_height/2)-START_MENU_H_HEIGHT+MENU_YPOS, room_height/2],	//MENU_y1
	[0, (room_width/2)+START_MENU_H_WIDTH, room_width/2],				//MENU_x2
	[0, (room_height/2)+START_MENU_H_HEIGHT+MENU_YPOS, room_height/2],	//MENU_y2
];

MENU_SOUND_moving = snd_menu_moving;
MENU_SOUND_select = snd_menu_select;

mx = mouse_x;
my = mouse_y;
mouse_moved = false;
mouse_check_delay = 30;
mouse_check_time = mouse_check_delay;
#endregion


MENU_OPTIONS_item = [
	//MAIN MENU
	["START GAME", "CREDITS", "QUIT"],
	
	//QUIT MENU
	["YES", "NO"],
];

MENU_OPTION_delay = 5;
MENU_OPTION_time = 0;


#region SETTING MENU FUNCTION
MENU_OPTIONS_function_0 = function() {
	if (MENU_OPTION_time <= 0) {
		//MAIN MENU - START GAME
		if (MENU_OPTIONS[0][2] == "START GAME") {
			slide_transition(TRANSITION_MODE.GOTO, room_game, 210);
			audio_stop_sound(snd_game_start_screen);
			audio_play_sound(snd_game_start, 0, false);
		}
		//QUIT MENU - YES
		else if (MENU_OPTIONS[0][2] == "YES") {
			game_end();
		}
	
		MENU_OPTION_time = MENU_OPTION_delay;
	}
}

MENU_OPTIONS_function_1 = function() {
	if (MENU_OPTION_time <= 0) {
		//MAIN MENU - CREDITS
		if (MENU_OPTIONS[1][2] == "CREDITS") {
			slide_transition(TRANSITION_MODE.GOTO, room_credits, 20);
		}
		//QUIT MENU - NO
		else if (MENU_OPTIONS[1][2] == "NO") {
			MENU_OPTIONS_quit = false;
		
			MENU_OPTIONS[MENU_OPTIONS_pos][0] = false;
		
			MENU_OPTIONS_pos = 0;
			MENU_OPTIONS[MENU_OPTIONS_pos][0] = true;
		
			for (var i = 0; i < MENU_OPTIONS_length; i++) {
				MENU_OPTIONS[i][2] = MENU_OPTIONS_item[0][i];
			}
		}
	
		audio_play_sound(MENU_SOUND_select, 1, false);
		MENU_OPTION_time = MENU_OPTION_delay;
	}
}

MENU_OPTIONS_function_2 = function() {
	if (MENU_OPTION_time <= 0) {
		//MAIN MENU - QUIT
		if (MENU_OPTIONS[2][2] == "QUIT") {
			MENU_OPTIONS_length = array_length(MENU_OPTIONS_item[1]);
			MENU_OPTIONS_quit = true;
		
			MENU_OPTIONS[MENU_OPTIONS_pos][0] = false;
		
			MENU_OPTIONS_pos = 0;
			MENU_OPTIONS[MENU_OPTIONS_pos][0] = true;
		
			for (var i = 0; i < MENU_OPTIONS_length; i++) {
				MENU_OPTIONS[i][2] = MENU_OPTIONS_item[1][i];	
			}
		}
	
		audio_play_sound(MENU_SOUND_select, 1, false);
		MENU_OPTION_time = MENU_OPTION_delay;
	}
}
#endregion


#region SETTING MENU OPTIONS
MENU_OPTIONS = [
	//menu selected, menu index, menu item, menu sound flag
	[1,	0,	MENU_OPTIONS_item[0][0],	false],
	[0,	1,	MENU_OPTIONS_item[0][1],	false],
	[0,	2,	MENU_OPTIONS_item[0][2],	false],
];

MENU_OPTIONS_item_x = MENU_COORD[0][2];
MENU_OPTIONS_item_y = MENU_COORD[1][2];

MENU_OPTIONS_length = array_length(MENU_OPTIONS);
MENU_OPTIONS_pos = 0;
MENU_OPTIONS_item_color_default = c_yellow;
MENU_OPTIONS_item_color = MENU_OPTIONS_item_color_default;
MENU_OPTIONS_item_color_off = c_grey;
MENU_OPTIONS_draw_arrow = true;

MENU_OPTIONS_quit = false;
#endregion


#region DRAWING MENU
draw_menu = function() {
	MENU_OPTION_time--;
	
	#region DRAWING MENU BACKGROUND
	draw_set_alpha(0);
	draw_rectangle(MENU_COORD[0][0], MENU_COORD[1][0], MENU_COORD[2][0], MENU_COORD[3][0], false);
	draw_set_alpha(1);
	#endregion
	
	draw_set_halign(fa_center);
	
	#region DRAWING MENU ITEMS
	var menu_ypos = 0;
	var menu_yquit;
	
	for (var i = 0; i < MENU_OPTIONS_length; i++) {
		if not(MENU_OPTIONS_quit) menu_yquit = 0;
		else menu_yquit = 85;
		
		//IF THE MENU OPTION IS SELECTED, CHANGE ITS COLOR
		if (MENU_OPTIONS[i][0] == true) draw_set_color(MENU_OPTIONS_item_color);
		else draw_set_color(MENU_OPTIONS_item_color_off);
		
		if (MENU_OPTIONS[i][2] == "START GAME") draw_set_font(fnt_menu_main);
		else draw_set_font(fnt_menu);
		
		draw_text(MENU_OPTIONS_item_x, MENU_OPTIONS_item_y+menu_ypos+menu_yquit, MENU_OPTIONS[i][2]);
		
		if (i == 0 && !MENU_OPTIONS_quit) menu_ypos += 85;
		else menu_ypos += 70;
		
		draw_set_font(-1);
	}
	#endregion	
	
	#region DRAWING QUIT TEXT
	if (MENU_OPTIONS_quit) {
		draw_set_font(fnt_menu_main);
		draw_set_color(c_white);
		draw_text(MENU_OPTIONS_item_x, MENU_OPTIONS_item_y, "ARE YOU SURE?");
		draw_set_color(-1);
		draw_set_font(-1);
	}
	#endregion
	
	draw_set_halign(-1);
	draw_set_color(-1);
	
	#region DRAWING MENU ITEM ARROW
	draw_set_font(fnt_menu);
	draw_set_color(MENU_OPTIONS_item_color_default);
	
	var arrow_gap_x;
	var arrow_gap_y;
	
	if not(MENU_OPTIONS_quit) {
		switch (MENU_OPTIONS_pos) {
			case 0: 
				arrow_gap_x = string_width(MENU_OPTIONS[MENU_OPTIONS_pos][2])*0.75;
				arrow_gap_y = +5;
			break;
			
			case 1: 
				arrow_gap_x = string_width(MENU_OPTIONS[MENU_OPTIONS_pos][2])*0.7;
				arrow_gap_y = MENU_OPTIONS_pos*85;
			break;
			
			case 2: 
				arrow_gap_x = string_width(MENU_OPTIONS[MENU_OPTIONS_pos][2])*0.85;
				arrow_gap_y = MENU_OPTIONS_pos*78;
			break;
		}		
	}
	else {
		switch (MENU_OPTIONS_pos) {
			case 0: 
				arrow_gap_x = string_width(MENU_OPTIONS[MENU_OPTIONS_pos][2])*1.1;
				arrow_gap_y = 85;
			break;
			
			case 1: 
				arrow_gap_x = string_width(MENU_OPTIONS[MENU_OPTIONS_pos][2])*1.6;
				arrow_gap_y = 155;
			break;
		}	
	}
	
	if (MENU_OPTIONS_draw_arrow) draw_text(MENU_COORD[0][2]-arrow_gap_x, MENU_COORD[1][2]+arrow_gap_y, ">");
	
	draw_set_font(-1);
	draw_set_color(-1);
	#endregion
}
#endregion


#region CHECKING INPUT
checking_input = function() {
	#region SETTING VARIABLES
	var key_menu_up		= keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
	var key_menu_down	= keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
	var key_menu_move	= key_menu_down-key_menu_up;
	
	var gamepad_selected	= gamepad_button_check_pressed(global.gamepad_device_number, gp_face1);
	var key_menu_select		= keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_selected;
	var mouse_left_pressed	= mouse_check_button_pressed(mb_left);
	#endregion
	
	
	#region GAMEPAD SUPPORT
	//RESETING GAMEPAD FLAG	
	if (key_menu_up || key_menu_down) global.gamepad = 0;
	
	//GAMEPAD - CHEKING STICK
	var gamepad_moving_stick =  abs(gamepad_axis_value(global.gamepad_device_number, gp_axislv)) > 0.2;
	
	//GAMEPAD - CHECKING PAD
	var gamepad_pad_up = gamepad_button_check(global.gamepad_device_number, gp_padu);
	var gamepad_pad_down = gamepad_button_check(global.gamepad_device_number, gp_padd);
	var gamepad_moving_pad = gamepad_pad_up || gamepad_pad_down;
	
	if (MENU_OPTION_time <= 0) {
		//GAMEPAD - MOVING STICK
		if (gamepad_moving_stick) {
			global.gamepad = 1;
		
			var gamepad_stick_up = abs(min(gamepad_axis_value(global.gamepad_device_number, gp_axislv), 0));
			var gamepad_stick_down = max(gamepad_axis_value(global.gamepad_device_number, gp_axislv), 0);
		
			if (gamepad_stick_up) key_menu_move = -1;
			if (gamepad_stick_down) key_menu_move = 1;
		}
	
		//GAMEPAD - MOVING PAD
		if (gamepad_pad_up) key_menu_move = -1;
		if (gamepad_pad_down) key_menu_move = 1;
	}
	
	//RESETING GAMEPAD TIME
	if (gamepad_moving_stick || gamepad_moving_pad) MENU_OPTION_time = MENU_OPTION_delay/2;
	show_debug_message(MENU_OPTION_time);
	
	//RETURN BUTTON
	var gamepad_back = gamepad_button_check_pressed(global.gamepad_device_number, gp_face2);
	if (gamepad_back && MENU_OPTIONS[1][2] == "NO") MENU_OPTIONS_function_1();
	#endregion
	
	
	#region MOVING MENU ARROW
	switch (key_menu_move) {
		//MOVING DOWN
		case 1:
			if (MENU_OPTIONS_pos == MENU_OPTIONS_length-1) {
				MENU_OPTIONS[MENU_OPTIONS_pos][0] = 0;
				MENU_OPTIONS[0][0] = 1;
				
				MENU_OPTIONS_pos = 0;
			}
			else if (MENU_OPTIONS_pos < MENU_OPTIONS_length) {
				MENU_OPTIONS[MENU_OPTIONS_pos][0] = 0;
				MENU_OPTIONS[MENU_OPTIONS_pos+1][0] = 1;
				
				MENU_OPTIONS_pos++;
			}
			MENU_OPTIONS_item_color = MENU_OPTIONS_item_color_default;
			MENU_OPTIONS_draw_arrow = true;
			audio_play_sound(MENU_SOUND_moving, 1, false);
		break;
		
		//MOVING UP
		case -1:
			if (MENU_OPTIONS_pos == 0) {
				MENU_OPTIONS[MENU_OPTIONS_pos][0] = 0;
				MENU_OPTIONS[MENU_OPTIONS_length-1][0] = 1;
				
				MENU_OPTIONS_pos = MENU_OPTIONS_length-1;
			}
			else if (MENU_OPTIONS_pos > 0) {
				MENU_OPTIONS[MENU_OPTIONS_pos][0] = 0;
				MENU_OPTIONS[MENU_OPTIONS_pos-1][0] = 1;
				
				MENU_OPTIONS_pos--;
			} 
			MENU_OPTIONS_item_color = MENU_OPTIONS_item_color_default;
			MENU_OPTIONS_draw_arrow = true;
			audio_play_sound(MENU_SOUND_moving, 1, false);
		break;
	}
	#endregion
	
	
	#region SELECTING MENU OPTION
	//CHECKING MOUSE OVER MENU OPTIONS	
	var item_initial_y = MENU_OPTIONS_item_y+60;
	var item_height = 50;
	var item_gap = 20;
	var menu_yquit;
	
	for (var i = 0; i < MENU_OPTIONS_length; i++) {
		if (MENU_OPTIONS[0][2] == "YES") menu_yquit = 65;
		else menu_yquit = 0;
		
		var x_pos_i = MENU_OPTIONS_item_x-240;
		var x_pos_f = MENU_OPTIONS_item_x+240;
		var y_pos_i = item_initial_y+i*(item_height+item_gap)-item_height+menu_yquit;
		var y_pos_f = item_initial_y+i*(item_height+item_gap)+menu_yquit;
		
		var mouse_item_x = x_pos_i <= mouse_x && mouse_x <= x_pos_f;
		var mouse_item_y = y_pos_i <= mouse_y && mouse_y <= y_pos_f;
		var mouse_item = mouse_item_x && mouse_item_y;

		if (mouse_item) {
			MENU_OPTIONS[MENU_OPTIONS_pos][0] = 0;
			MENU_OPTIONS[i][0] = 1;
			
			if (MENU_OPTIONS_pos != i) audio_play_sound(MENU_SOUND_moving, 1, false);
			
			MENU_OPTIONS_pos = i;
			MENU_OPTIONS_item_color = MENU_OPTIONS_item_color_default;
			
			if (MENU_OPTIONS[i][3] == false) {
				for (var j = 0; j < MENU_OPTIONS_length; j++) MENU_OPTIONS[j][3] = false;
				MENU_OPTIONS[i][3] = true;
			}
		}
		
		if (mouse_left_pressed && mouse_item) {
			switch (MENU_OPTIONS[MENU_OPTIONS_pos][1]) {
				case 0:	MENU_OPTIONS_function_0() break;
				case 1:	MENU_OPTIONS_function_1() break;
				case 2:	MENU_OPTIONS_function_2() break;
			}
		}
	}
	
	if (key_menu_select) {
		switch (MENU_OPTIONS[MENU_OPTIONS_pos][1]) {
			case 0:	MENU_OPTIONS_function_0() break;
			case 1:	MENU_OPTIONS_function_1() break;
			case 2:	MENU_OPTIONS_function_2() break;
		}
	}


	#region CHECKING MOUSE MOVING
	mouse_check_time--;
		
	if (mouse_moved) {
		MENU_OPTIONS_draw_arrow = false;
		MENU_OPTIONS_item_color = MENU_OPTIONS_item_color_off;
		for (var j = 0; j < MENU_OPTIONS_length; j++) MENU_OPTIONS[j][3] = false;
	}
	
	
	//WHEN THE MOUSE STARTS MOVING, HIDES THE MENU OPTION ARROW
	if (mx != mouse_x || my != mouse_y) && (mouse_check_time <= 0) {
		if !(mouse_moved) mouse_moved = true;
		mouse_check_time = mouse_check_delay;
	}
	else mouse_moved = false;
	
	if (mx != mouse_x) mx = mouse_x;
	if (my != mouse_y) my = mouse_y;
	#endregion
	
	#endregion
}
#endregion
