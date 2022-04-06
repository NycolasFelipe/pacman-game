function pause_game() {
	if not(global.game_is_paused) {
		//GAME PAUSE
		global.game_is_paused = true;
		
		//CHANGES PAUSE BUTTON SPRITE INDEX
		obj_controller.pause_index = 1;
	
		//PAUSING PLAYER
		with (obj_controller) {
			if (player_teleporting) {
				if (obj_player.hspeed > 0) obj_player.x = right_portal_x;
				else if (obj_player.hspeed < 0) obj_player.x = left_portal_x;
			}
		}
		with (obj_player) {
			has_control = false;
			speed = 0;
			image_speed = 0;
		}
	
		//PAUSING ENEMIES
		with (obj_enemy) speed /= 10000;
	}
	else {
		//GAME RESUME
		global.game_is_paused = false;
		
		//CHANGES PAUSE BUTTON SPRITE INDEX
		obj_controller.pause_index = 0;
	
		//UNPAUSING PLAYER
		with (obj_player) {
			has_control = true;
			speed = 0;
			image_speed = -1;
		}
		keyboard_lastkey = -1;
	
		//UNPAUSING ENEMIES
		with (obj_enemy) {
			if (hspeed != 0) hspeed = walk_speed*sign(hspeed);
			else if (vspeed != 0) vspeed = walk_speed*sign(vspeed);
		}
	}
}