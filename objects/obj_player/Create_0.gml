#region SETTING VARIABLES
//MOVEMENT SPEED
vel_default = 3;
vel = vel_default;

//CHECKS IF THE PLAYER IS CURRENTLY IN CONTROL
has_control = true;

//PLAYER HIT POINTS
player_hp = 3;	//DEFAULT: 3

//VARIABLE THAT CONTROLS THE PLAYER'S ALPHA
num = 1;
#endregion

//PLAYER MOVEMENT METHOD
player_move = function() {
	//CHECK THE PLAYER'S LAST MOVE
	var last_key_right	= keyboard_lastkey == ord("D") || keyboard_lastkey == vk_right;
	var last_key_left	= keyboard_lastkey == ord("A") || keyboard_lastkey == vk_left;
	var last_key_down	= keyboard_lastkey == ord("S") || keyboard_lastkey == vk_down;
	var last_key_up		= keyboard_lastkey == ord("W") || keyboard_lastkey == vk_up;


	//DISTANCE TO THE COLLISION OBJECT
	var colliding_distance = 10;
	
	//OBJECT TO CHECK FOR COLLISION
	var collision_object = obj_collision;
	
	//CHECKS IF THERE IS ROOM FOR THE PLAYER TO MOVE AUTOMATICALLY
	var right_has_space	= !place_meeting(x+colliding_distance, y, collision_object);
	var left_has_space	= !place_meeting(x-colliding_distance, y, collision_object);
	var down_has_space	= !place_meeting(x, y+colliding_distance, collision_object);
	var up_has_space	= !place_meeting(x, y-colliding_distance, collision_object);

	//CHECKS IF THE PLAYER IS COLLIDING
	var colliding = place_meeting(x+hspeed, y+vspeed, collision_object);
	
	//IF THERE IS A COLLISION, THE PLAYER'S MOVEMENT IS STOPPED
	if (colliding) {
		vspeed = 0;
		hspeed = 0;
	}
	else {
		//IF THERE IS NO COLLISION, CHECK WHICH DIRECTION THE PLAYER WANTS TO MOVE AND IF THERE IS ROOM TO TURN.
		//THE BLOCK WILL KEEP DOING THIS TEST, AND WILL TRY TO TURN TO THE LAST ACTIVATED DIRECTION,
		//UNLESS THE PLAYER CHANGES DIRECTION.
		if (last_key_right) and (right_has_space) {
			vspeed = 0;
			hspeed = vel;
		}
		else if (last_key_left) and (left_has_space) {
			vspeed = 0;
			hspeed = -vel;
		}
		else if (last_key_down) and (down_has_space) {
			vspeed = vel;
			hspeed = 0;
		}
		else if (last_key_up) and (up_has_space) {
			vspeed = -vel;
			hspeed = 0;
		}
	}
	
	
	//CONTROLS SPRITE DIRECTION
	var facing_up, facing_left, facing_down, facing_right;
	facing_up		= 90;
	facing_left		= 180;
	facing_down		= 270;
	facing_right	= 0;
	
	if (vspeed < 0) {
		image_angle = facing_up;
		if (image_yscale != 1) image_yscale = 1;
	}
	else if (vspeed > 0) {
		image_angle = facing_down;
		image_yscale = -1;
	}
	else if (hspeed < 0) {
		image_angle = facing_left;
		image_yscale = -1;
	}
	else if (hspeed > 0) {
		image_angle = facing_right;
		if (image_yscale != 1) image_yscale = 1;
	}
	

	//UNSTUCK PLAYER
	var map_grid = 32;
	
	if (place_meeting(x, y, collision_object) && hspeed == 0 && vspeed == 0) {
		var colliding_wall_x = place_meeting(ceil(x/map_grid)*map_grid, y, collision_object);
		var colliding_wall_y = place_meeting(x, (ceil(y/map_grid)*map_grid)-16, collision_object);
		
		var valid_teleport_x = !colliding_wall_x;
		var valid_teleport_y = !colliding_wall_y;
		
		if (valid_teleport_x) x = ceil(x/map_grid)*map_grid;
		else x = (ceil(x/map_grid)*map_grid)-map_grid;
		
		if (valid_teleport_y) y = (ceil(y/map_grid)*map_grid)-16;
		else y = (ceil(y/map_grid)*map_grid)-16;
	}
}

//METHOD TO STOP PLAYER MOVEMENT
player_stop = function() {
	//CHECK PLAYER INPUT
	var key_right	= keyboard_check(ord("D"))	|| keyboard_check(vk_right);
	var key_left	= keyboard_check(ord("A"))	|| keyboard_check(vk_left);
	var key_down	= keyboard_check(ord("S"))	|| keyboard_check(vk_down);
	var key_up		= keyboard_check(ord("W"))	|| keyboard_check(vk_up);
	
	//CHECKS IF KEYS IN OPPOSITE DIRECTIONS ARE BEING PRESSED
	var stop_x = key_right and key_left;
	var stop_y = key_down and key_up;
	var stop = stop_x or stop_y;
	
	//IF SO, INTERRUPTS THE PLAYER'S MOVEMENT
	if (stop) {
		has_control = false;

		hspeed = 0;
		vspeed = 0;
		
		//RESETS THE LAST KEY PRESSED
		keyboard_lastkey = -1;
		
		//AT THE END, IT RETURNS CONTROL TO THE PLAYER
		has_control = true;
	}
}

#region PLAYER HITTING ENEMIES
//HIT ANIMATION FLAG
run_player_hit_sequence = false;

//CONTROL IF PLAYER IS INVINCIBLE
player_invincible = false;

//CONTROL IF PLAYER IS IN GHOST MODE
ghost_mode = false;


player_hit = function() {
	if (player_hp > 0 && !ghost_mode) {
		player_hp--;
		
		//CREATE ANIMATION SEQUENCE WHEN PLAYER LOSES LIFE
		player_seq_hit = layer_sequence_create("Sequence_Player", x, y, seq_player_hurt);
		run_player_hit_sequence = true;

		layer_sequence_xscale(player_seq_hit, image_xscale);
		layer_sequence_yscale(player_seq_hit, image_yscale);
		layer_sequence_angle(player_seq_hit, image_angle);
		layer_sequence_speedscale(player_seq_hit, 1.2);

		//PLAY SOUND EFFECT
		if (obj_controller.play_sound) audio_play_sound(snd_life_point_less, 1 , false);
		
		//CREATE SEQUENCE ANIMATION ON THE HUD
		var x_text = (obj_controller.draw_text_xl+20)+obj_controller.temp_life_points_x*player_hp;
		var y_text = (obj_controller.draw_text_y+195);
		layer_sequence_create("Sequence_Player", x_text, y_text, seq_life_point_less);
		
		//DESTROY ENEMY INSTANCE
		with (other) instance_destroy();
	}
	else if (player_invincible) {	
		//CREATE ANIMATION SEQUENCE WHEN PLAYER HIT ENEMY BUT IS IN INVINCIBLE MODE
		player_seq_hit = layer_sequence_create("Sequence_Player", x, y, seq_player_invincible);
		run_player_hit_sequence = true;
		
		layer_sequence_xscale(player_seq_hit, image_xscale);
		layer_sequence_yscale(player_seq_hit, image_yscale);
		layer_sequence_angle(player_seq_hit, image_angle);
		
		//PLAY SOUND EFFECT
		if (obj_controller.play_sound) audio_play_sound(snd_player_eating, 1 , false);
		
		//DESTROY ENEMY INSTANCE
		with (other) instance_destroy();
	}
}

player_hit_sequence = function() {
	if (run_player_hit_sequence && player_hp > 0) {
		//LAYER SEQUENCE FOLLOWS THE PLAYER
		layer_sequence_x(player_seq_hit, x);
		layer_sequence_y(player_seq_hit, y);
	
		//TEMPORARILY REDUCE PLAYER'S ALPHA WHEN LOSING HP
		image_alpha = 0;
		
		//IF NOT IN INVINCIBLE MODE, REDUCES TEMPORARILY THE PLAYER'S SPEED
		if not(player_invincible) {
			if (hspeed != 0) hspeed = sign(hspeed)*vel/2;
			if (vspeed != 0) vspeed = sign(vspeed)*vel/2;
		}
	
		//WHEN THE SEQUENCE IS FINISHED, RESTORE ALL PREVIOUS VALUES
		if (layer_sequence_is_finished(player_seq_hit)) {
			layer_destroy("Sequence_Player");
			layer_create(1,"Sequence_Player");
			run_player_hit_sequence = false;
			image_alpha = 1;
			
			if not(player_invincible) {
				if (hspeed != 0) hspeed = sign(hspeed)*vel;
				if (vspeed != 0) vspeed = sign(vspeed)*vel;
			}
		}
	}
	else if (player_hp == 1 && not(obj_controller.player_teleporting)) {
		num++;
		image_alpha = max(0.5,sin(num/4));
	}
}
#endregion