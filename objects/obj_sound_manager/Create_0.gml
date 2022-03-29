#region SETTING VARIABLES
animation_speed	= 0.5;
alarm_time = room_speed*2;

moving_audio_control = false;
moving_music_control = false;
moving_effects_control = false;

effects_sound = [
snd_player_eating,
snd_powerup_invincible,
snd_powerup_speed,
snd_powerup_ghost,
snd_life_point_more,
snd_life_point_less,
snd_player_spotted,
snd_point, 
snd_portal,
snd_game_over,
snd_game_over_music
];
effects_sound_length = array_length(effects_sound);
#endregion


#region SETTINGS AUDIO BUTTON'S VARIABLES
//AUDIO BUTTON
AUDIO = spr_button_audio;
AUDIO_subimage = 0;
AUDIO_x = x;
AUDIO_y = y;
AUDIO_width = sprite_get_width(AUDIO)/2;
AUDIO_height = sprite_get_height(AUDIO)/2;
AUDIO_scale = 1;
AUDIO_scale0 = 1;
AUDIO_xscale = AUDIO_scale;
AUDIO_yscale = AUDIO_scale;

//AUDIO BUTTON - SLIDE
AUDIO_SLIDE = spr_button_slide;
AUDIO_SLIDE_subimage = 0;
AUDIO_SLIDE_x = AUDIO_x;
AUDIO_SLIDE_y = AUDIO_y+(AUDIO_height*1.8);
AUDIO_SLIDE_width = sprite_get_width(AUDIO_SLIDE)/2;
AUDIO_SLIDE_height = sprite_get_height(AUDIO_SLIDE)/2;
AUDIO_SLIDE_yscale = 0;

//AUDIO BUTTON - CONTROL
AUDIO_CONTROL = spr_button_slide_control;
AUDIO_CONTROL_subimage = 0;
AUDIO_CONTROL_x = AUDIO_SLIDE_x;
AUDIO_CONTROL_y = AUDIO_SLIDE_y+AUDIO_SLIDE_height;
AUDIO_CONTROL_yscale = 0;
#endregion


#region SETTINGS MUSIC BUTTON'S VARIABLES
//MUSIC BUTTON
MUSIC = spr_button_music;
MUSIC_subimage = 0;
MUSIC_x = AUDIO_x-AUDIO_width*2;
MUSIC_y = AUDIO_y;
MUSIC_width = sprite_get_width(MUSIC)/2;
MUSIC_height = sprite_get_height(MUSIC)/2;
MUSIC_xscale = 0;
MUSIC_yscale = 1;

//MUSIC BUTTON - SLIDE
MUSIC_SLIDE = spr_button_slide;
MUSIC_SLIDE_subimage = 0;
MUSIC_SLIDE_x = MUSIC_x;
MUSIC_SLIDE_x0 = MUSIC_x;
MUSIC_SLIDE_xf = MUSIC_SLIDE_x-MUSIC_width;
MUSIC_SLIDE_y = AUDIO_SLIDE_y;
MUSIC_SLIDE_width = sprite_get_width(MUSIC_SLIDE)/2;
MUSIC_SLIDE_height = sprite_get_height(MUSIC_SLIDE)/2;
MUSIC_SLIDE_xscale = 1;
MUSIC_SLIDE_yscale = 1;

//MUSIC BUTTON - CONTROL
MUSIC_CONTROL = spr_button_slide_control;
MUSIC_CONTROL_subimage = 0;
MUSIC_CONTROL_x = MUSIC_SLIDE_x;
MUSIC_CONTROL_x0 = MUSIC_SLIDE_x;
MUSIC_CONTROL_xf = MUSIC_SLIDE_x-MUSIC_width;
MUSIC_CONTROL_y = MUSIC_SLIDE_y+MUSIC_SLIDE_height;
MUSIC_CONTROL_yscale = 0;
#endregion


#region SETTINGS EFFECTS BUTTON'S VARIABLES
//EFFECTS BUTTON
EFFECTS = spr_button_effects;
EFFECTS_subimage = 0;
EFFECTS_x = MUSIC_x-(AUDIO_width*3);
EFFECTS_y = AUDIO_y;
EFFECTS_width = sprite_get_width(EFFECTS)/2;
EFFECTS_height = sprite_get_height(EFFECTS)/2;
EFFECTS_xscale = 0;
EFFECTS_yscale = 1;

//EFFECTS BUTTON - SLIDE
EFFECTS_SLIDE = spr_button_slide;
EFFECTS_SLIDE_subimage = 0;
EFFECTS_SLIDE_x = EFFECTS_x;
EFFECTS_SLIDE_x0 = EFFECTS_x;
EFFECTS_SLIDE_xf = EFFECTS_SLIDE_x-EFFECTS_width;
EFFECTS_SLIDE_y = AUDIO_SLIDE_y;
EFFECTS_SLIDE_width = sprite_get_width(EFFECTS_SLIDE)/2;
EFFECTS_SLIDE_height = sprite_get_height(EFFECTS_SLIDE)/2;
EFFECTS_SLIDE_yscale = 1;
EFFECTS_SLIDE_xscale = 1;

//EFFECTS BUTTON - CONTROL
EFFECTS_CONTROL = spr_button_slide_control;
EFFECTS_CONTROL_subimage = 0;
EFFECTS_CONTROL_x = EFFECTS_SLIDE_x;
EFFECTS_CONTROL_x0 = EFFECTS_SLIDE_x;
EFFECTS_CONTROL_xf = EFFECTS_SLIDE_x-EFFECTS_width;
EFFECTS_CONTROL_y = EFFECTS_SLIDE_y+EFFECTS_SLIDE_height;
EFFECTS_CONTROL_yscale = 0;
#endregion


#region OTHER VARIABLES
temp_audio_control_y = AUDIO_SLIDE_y;
temp_music_control_y = MUSIC_SLIDE_y;
temp_effects_control_y = EFFECTS_SLIDE_y;
#endregion


draw_sound_menu = function() {
	//DRAWING BUTTON AUDIO
	draw_sprite_ext(AUDIO, AUDIO_subimage, AUDIO_x, AUDIO_y, AUDIO_xscale, AUDIO_yscale, image_angle, image_blend, image_alpha);

	//DRAWING BUTTON AUDIO - SLIDE
	draw_sprite_ext(AUDIO_SLIDE, AUDIO_SLIDE_subimage, AUDIO_SLIDE_x, AUDIO_SLIDE_y, image_xscale, AUDIO_SLIDE_yscale, image_angle, image_blend, image_alpha);

	//DRAWING BUTTON AUDIO - CONTROL
	draw_sprite_ext(AUDIO_CONTROL, AUDIO_CONTROL_subimage, AUDIO_CONTROL_x, AUDIO_CONTROL_y, image_xscale, AUDIO_CONTROL_yscale, image_angle, image_blend, image_alpha);


	//DRAWING BUTTON MUSIC
	draw_sprite_ext(MUSIC, MUSIC_subimage, MUSIC_x, MUSIC_y, MUSIC_xscale, MUSIC_yscale, image_angle, image_blend, image_alpha);

	//DRAWING BUTTON MUSIC - SLIDE
	draw_sprite_ext(MUSIC_SLIDE, MUSIC_SLIDE_subimage, MUSIC_SLIDE_x, MUSIC_SLIDE_y, MUSIC_SLIDE_xscale, MUSIC_SLIDE_yscale, image_angle, image_blend, image_alpha);

	//DRAWING BUTTON MUSIC - CONTROL
	draw_sprite_ext(MUSIC_CONTROL, MUSIC_CONTROL_subimage, MUSIC_CONTROL_x, MUSIC_CONTROL_y, image_xscale, MUSIC_CONTROL_yscale, image_angle, image_blend, image_alpha);


	//DRAWING BUTTON EFFECTS
	draw_sprite_ext(EFFECTS, EFFECTS_subimage, EFFECTS_x, EFFECTS_y, EFFECTS_xscale, EFFECTS_yscale, image_angle, image_blend, image_alpha);

	//DRAWING BUTTON EFFECTS - SLIDE
	draw_sprite_ext(EFFECTS_SLIDE, EFFECTS_SLIDE_subimage, EFFECTS_SLIDE_x, EFFECTS_SLIDE_y, EFFECTS_SLIDE_xscale, EFFECTS_SLIDE_yscale, image_angle, image_blend, image_alpha);

	//DRAWING BUTTON EFFECTS - CONTROL
	draw_sprite_ext(EFFECTS_CONTROL, EFFECTS_CONTROL_subimage, EFFECTS_CONTROL_x, EFFECTS_CONTROL_y, image_xscale, EFFECTS_CONTROL_yscale, image_angle, image_blend, image_alpha);
}


checking_mouse = function() {
	//Iniciando variÃ¡veis
	menu_opened = alarm[0] != -1;
	scale = 0;
	
	
	//CHECKING MOUSE INPUT
	mouse_left_pressed = mouse_check_button_pressed(mb_left);
	mouse_left_check = mouse_check_button(mb_left);
	
	
	//CHECKING MOUSE OVER BUTTON AUDIO
	var mouse_x_audio = (AUDIO_x-AUDIO_width <= mouse_x) && (mouse_x <= AUDIO_x+AUDIO_width);
	var mouse_y_audio = (AUDIO_y-AUDIO_height <= mouse_y) && (mouse_y <= AUDIO_y+AUDIO_height);
	mouse_audio = mouse_x_audio && mouse_y_audio;

	//CHECKING MOUSE OVER BUTTON AUDIO - SLIDE
	var mouse_x_audio_slide = (AUDIO_SLIDE_x-AUDIO_SLIDE_width <= mouse_x) && (mouse_x <= AUDIO_SLIDE_x+AUDIO_SLIDE_width);
	var mouse_y_audio_slide = (AUDIO_SLIDE_y-AUDIO_SLIDE_height <= mouse_y) && (mouse_y <= AUDIO_SLIDE_y+AUDIO_SLIDE_height*2.5);
	mouse_audio_slide = mouse_x_audio_slide && mouse_y_audio_slide;
	
	
	//CHECKING MOUSE OVER BUTTON MUSIC
	var mouse_x_music = (MUSIC_x-(MUSIC_width*2) <= mouse_x) && (mouse_x <= MUSIC_x);
	var mouse_y_music = (MUSIC_y-MUSIC_height <= mouse_y) && (mouse_y <= MUSIC_y+MUSIC_height);
	mouse_music = mouse_x_music && mouse_y_music;
	
	//CHECKING MOUSE OVER BUTTON MUSIC - SLIDE
	var mouse_x_music_slide = (MUSIC_SLIDE_x-MUSIC_SLIDE_width <= mouse_x) && (mouse_x <= MUSIC_SLIDE_x+MUSIC_SLIDE_width);
	var mouse_y_music_slide = (MUSIC_SLIDE_y-MUSIC_SLIDE_height <= mouse_y) && (mouse_y <= MUSIC_SLIDE_y+MUSIC_SLIDE_height*2.5);
	mouse_music_slide = mouse_x_music_slide && mouse_y_music_slide;
	
	
	//CHECKING MOUSE OVER BUTTON EFFECTS
	var mouse_x_effects = (EFFECTS_x-(EFFECTS_width*2) <= mouse_x) && (mouse_x <= EFFECTS_x);
	var mouse_y_effects = (EFFECTS_y-EFFECTS_height <= mouse_y) && (mouse_y <= EFFECTS_y+EFFECTS_height);
	mouse_effects = mouse_x_effects && mouse_y_effects;
	
	//CHECKING MOUSE OVER BUTTON MUSIC - SLIDE
	var mouse_x_effects_slide = (EFFECTS_SLIDE_x-EFFECTS_SLIDE_width <= mouse_x) && (mouse_x <= EFFECTS_SLIDE_x+EFFECTS_SLIDE_width);
	var mouse_y_effects_slide = (EFFECTS_SLIDE_y-EFFECTS_SLIDE_height <= mouse_y) && (mouse_y <= EFFECTS_SLIDE_y+EFFECTS_SLIDE_height*2.5);
	mouse_effects_slide = mouse_x_effects_slide && mouse_y_effects_slide;

	
	
	//KEEP RESETING ALARM'S TIME AS LONG AS THE MOUSE IS HOVERING THE MENU
	if (mouse_audio) alarm[0] = alarm_time;
	
	
	//CHECKING MOUSE HOVERING THE MENU
	var mouse_over_menu = mouse_audio || mouse_audio_slide || mouse_music || mouse_music_slide || mouse_effects || mouse_effects_slide;


	if (menu_opened) {
		//WITH THE MENU OPENED, CONTINUE TO KEEP RESETING ALARM'S TIME AS LONG AS THE MOUSE IS HOVERING THE MENU
		if (mouse_over_menu) alarm[0] = alarm_time;		
		scale = 1;
		
		
		//MOVING AUDIO'S CONTROL
		var clicking_audio_control = (mouse_left_check || mouse_left_pressed) && mouse_audio_slide && !mouse_audio;
		if (clicking_audio_control) moving_audio_control = true;

		//MOVING CONTROL
		if (moving_audio_control) {
			AUDIO_CONTROL_y = clamp(mouse_y, AUDIO_SLIDE_y, AUDIO_SLIDE_y+(AUDIO_SLIDE_height*2));
			moving_audio_control = false;
		}
	
	
		//MOVING MUSIC'S CONTROL
		var clicking_music_control = (mouse_left_check || mouse_left_pressed) && mouse_music_slide && !mouse_music;
		if (clicking_music_control) moving_music_control = true;
	
		//MOVING CONTROL
		if (moving_music_control) {
			MUSIC_CONTROL_y = clamp(mouse_y, MUSIC_SLIDE_y, MUSIC_SLIDE_y+(MUSIC_SLIDE_height*2));
			moving_music_control = false;
		}
	
	
		//MOVING EFFECT'S CONTROL
		var clicking_effects_control = (mouse_left_check || mouse_left_pressed) && mouse_effects_slide && !mouse_effects;
		if (clicking_effects_control) moving_effects_control = true;
	
		//MOVING CONTROL
		if (moving_effects_control) {
			EFFECTS_CONTROL_y = clamp(mouse_y, EFFECTS_SLIDE_y, EFFECTS_SLIDE_y+(EFFECTS_SLIDE_height*2));
			moving_effects_control = false;
		}
		
		
		//ANIMATING BUTTON AUDIO - CONTROL
		AUDIO_CONTROL_yscale = lerp(AUDIO_CONTROL_yscale, scale, animation_speed);
		
		
		//ANIMATING BUTTON MUSIC - SLIDE
		MUSIC_SLIDE_x = lerp(MUSIC_SLIDE_x, MUSIC_SLIDE_xf, animation_speed);
		MUSIC_SLIDE_yscale = lerp(MUSIC_SLIDE_yscale, scale, animation_speed);
		MUSIC_SLIDE_xscale = lerp(MUSIC_SLIDE_xscale, scale, animation_speed);
		
		//ANIMATING BUTTON MUSIC - CONTROL
		MUSIC_CONTROL_x = lerp(MUSIC_CONTROL_x, MUSIC_CONTROL_xf, animation_speed);
		MUSIC_CONTROL_yscale = lerp(MUSIC_CONTROL_yscale, scale, animation_speed);
		
		
		//ANIMATING BUTTON EFFECTS - SLIDE
		EFFECTS_SLIDE_x = lerp(EFFECTS_SLIDE_x, EFFECTS_SLIDE_xf, animation_speed);
		EFFECTS_SLIDE_yscale = lerp(EFFECTS_SLIDE_yscale, scale, animation_speed);
		EFFECTS_SLIDE_xscale = lerp(EFFECTS_SLIDE_xscale, scale, animation_speed);
		
		//ANIMATING BUTTON EFFECTS - CONTROL
		EFFECTS_CONTROL_x = lerp(EFFECTS_CONTROL_x, EFFECTS_CONTROL_xf, animation_speed);
		EFFECTS_CONTROL_yscale = lerp(EFFECTS_CONTROL_yscale, scale, animation_speed);
	}
	else {
		//ANIMATING BUTTON AUDIO - CONTROL
		AUDIO_CONTROL_yscale = lerp(AUDIO_CONTROL_yscale, 0, animation_speed);
		
		
		//ANIMATING BUTTON MUSIC - SLIDE
		MUSIC_SLIDE_x = MUSIC_SLIDE_x0;
		MUSIC_SLIDE_yscale = 0;
		MUSIC_SLIDE_xscale = 0;
		
		//ANIMATING BUTTON MUSIC - CONTROL
		MUSIC_CONTROL_x = MUSIC_CONTROL_x0;
		MUSIC_CONTROL_yscale = lerp(MUSIC_CONTROL_yscale, 0, animation_speed*1.8);
		
		
		//ANIMATING BUTTON EFFECTS - SLIDE
		EFFECTS_SLIDE_x = EFFECTS_SLIDE_x0;
		EFFECTS_SLIDE_yscale = 0;
		EFFECTS_SLIDE_xscale = 0;
		
		//ANIMATING BUTTON MUSIC - CONTROL
		EFFECTS_CONTROL_x = EFFECTS_CONTROL_x0;
		EFFECTS_CONTROL_yscale = lerp(EFFECTS_CONTROL_yscale, 0, animation_speed*1.8);
	}

	//OTHER ANIMATIONS
	AUDIO_SLIDE_yscale = lerp(AUDIO_SLIDE_yscale, scale, animation_speed);
	MUSIC_xscale = lerp(MUSIC_xscale, scale, animation_speed);
	EFFECTS_xscale = lerp(EFFECTS_xscale, scale, animation_speed);


	//CLOSE MENU WHEN CLICKING OUTSIDE
	if (mouse_left_pressed && !(mouse_over_menu)) alarm[0] = -1;
}


change_volume = function() {
	var audio_value = (AUDIO_CONTROL_y-AUDIO_SLIDE_y)/(AUDIO_SLIDE_height*2);
	var music_value = (MUSIC_CONTROL_y-MUSIC_SLIDE_y)/(MUSIC_SLIDE_height*2);
	var effects_value = (EFFECTS_CONTROL_y-EFFECTS_SLIDE_y)/(EFFECTS_SLIDE_height*2);
	
	audio_volume = 1-audio_value;
	music_volume = 1-music_value;	
	effects_volume = 1-effects_value;

	audio_sound_gain(snd_background_music, music_volume*audio_volume*0.1, 0);	//0.1 is there for lowering the background music volume
	
	for (var i = 0; i < effects_sound_length; i++) {
		var effect = effects_sound[i];
		var audio_multiplier = 1;
		
		switch (effect) {
			case snd_player_eating: audio_multiplier = 0.2 break;
			case snd_powerup_invincible: audio_multiplier = 0.1 break;
			case snd_powerup_speed: audio_multiplier = 0.2 break;
			case snd_powerup_ghost: audio_multiplier = 0.2 break;
			case snd_life_point_more: audio_multiplier = 0.1 break;
			case snd_life_point_less: audio_multiplier = 1 break;
			case snd_player_spotted: audio_multiplier = 0.3 break;
			case snd_point: audio_multiplier = 0.05 break;
			case snd_portal: audio_multiplier = 0.6 break;
			case snd_game_over: audio_multiplier = 1 break;
			case snd_game_over_music: audio_multiplier = 0.05;
		}
		
		audio_sound_gain(effect, effects_volume*audio_volume*audio_multiplier, 0);
	}
	
	
	var mouse_audio_pressed = mouse_left_pressed && mouse_audio;
	var mouse_music_pressed = mouse_left_pressed && mouse_music;
	var mouse_effects_pressed = mouse_left_pressed && mouse_effects;
	

	if (mouse_audio_pressed && audio_volume == 0) {
		AUDIO_CONTROL_y = temp_audio_control_y;
	}
	else if (mouse_audio_pressed) {
		temp_audio_control_y = AUDIO_CONTROL_y;
		AUDIO_CONTROL_y = AUDIO_SLIDE_y+AUDIO_SLIDE_height*2;
	}
	
	if (mouse_music_pressed && music_volume == 0) {
		MUSIC_CONTROL_y = temp_music_control_y;
	}
	else if (mouse_music_pressed) {
		temp_music_control_y = MUSIC_CONTROL_y;
		MUSIC_CONTROL_y = MUSIC_SLIDE_y+MUSIC_SLIDE_height*2;
	}
	
	if (mouse_effects_pressed && effects_volume == 0) {
		EFFECTS_CONTROL_y = temp_effects_control_y;
	}
	else if (mouse_effects_pressed) {
		temp_effects_control_y = EFFECTS_CONTROL_y;
		EFFECTS_CONTROL_y = EFFECTS_SLIDE_y+EFFECTS_SLIDE_height*2;
	}
}


checking_icon = function() {
	//CHECKING AUDIO VOLUME
	if (audio_volume == 0) {	//0 - sound on, 1 - sound off
		AUDIO_subimage = 1;
		MUSIC_subimage = 1;
		EFFECTS_subimage = 1;
	}
	else {
		AUDIO_subimage = 0;
		MUSIC_subimage = 0;
		EFFECTS_subimage = 0;
	}
	
	//CHECKING MUSIC VOLUME
	if (music_volume == 0) MUSIC_subimage = 1;
	else if (audio_volume != 0) MUSIC_subimage = 0;
	
	//CHECKING EFFECTS VOLUME
	if (effects_volume == 0) EFFECTS_subimage = 1;
	else if (audio_volume != 0) EFFECTS_subimage = 0;
	
	
	//ANIMATING ICON WHEN MOUSE IS HOVERING
	var icon_scale = 1.1;
	var menu_opened = alarm[0] != -1;
	
	//ANIMATING AUDIO ICON
	if (mouse_audio) {
		AUDIO_xscale = icon_scale;
		AUDIO_yscale = icon_scale;
	}
	else {
		AUDIO_xscale = AUDIO_scale0;
		AUDIO_yscale = AUDIO_scale0;
	}
	
	//ANIMATING MUSIC ICON
	if (mouse_music && menu_opened) {
		MUSIC_xscale = icon_scale;
		MUSIC_yscale = icon_scale;
	}

	//ANIMATING EFFECTS ICON
	if (mouse_effects && menu_opened) {
		EFFECTS_xscale = icon_scale;
		EFFECTS_yscale = icon_scale;
	}
}