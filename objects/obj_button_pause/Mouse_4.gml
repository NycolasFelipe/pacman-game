//if player and enemy exists

if not(global.game_is_paused) {
	//GAME PAUSE
	global.game_is_paused = true;
	
	//Botão de pause
	image_index = 1;
	
	//Pausando o player
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
	
	//Pausando os inimigos
	//Inimigos fora da área de spawn
	with (obj_enemy) speed /= 10000;
}
else {
	//GAME RESUME
	global.game_is_paused = false;
	
	//Botão de pause
	image_index = 0;
	
	//Despausando o player
	with (obj_player) {
		has_control = true;
		speed = 0;
		image_speed = -1;
	}
	keyboard_lastkey = -1;
	
	//Despausando os inimigos
	//Inimigos fora da área de spawn
	with (obj_enemy) {
		if (hspeed != 0) hspeed = walk_speed*sign(hspeed);
		else if (vspeed != 0) vspeed = walk_speed*sign(vspeed);
	}
}