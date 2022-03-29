//Velocidade de movimento
vel_default = 3;
vel = vel_default;

//Diz se o player está no controle no momento
has_control = true;

//Pontos de vida do player
player_hp = 3;		//padrão: 3

//Variável que controla o alfa do player
num = 1;


//Método de movimento do player
player_move = function() {
	//Checa a última movimentação do player
	var last_key_right = keyboard_lastkey == ord("D");
	var last_key_left = keyboard_lastkey == ord("A");
	var last_key_down = keyboard_lastkey == ord("S");
	var last_key_up = keyboard_lastkey == ord("W");
	

	//Distância até o objeto de colisão
	var colliding_distance = 10;
	
	//Objeto a se checar a colisão
	var collision_object = obj_collision;
	
	//Checa se há espaço para o player virar se no modo automático
	//A distância de colisão é maior porque o propósito é ser usado para checar
	//se o player pode virar, e não se deve interromper o seu movimento
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object);
	var left_has_space = !place_meeting(x-colliding_distance, y, collision_object);
	var down_has_space = !place_meeting(x, y+colliding_distance, collision_object);
	var up_has_space = !place_meeting(x, y-colliding_distance, collision_object);


	//Checa se o player está colidindo
	var colliding = place_meeting(x+hspeed, y+vspeed, collision_object);
	
	//image_xscale = vel_default/vel;
	//image_yscale = vel_default/vel;
	
	//Se houver colisão, a movimentação do player é interrompida
	if (colliding) {
		vspeed = 0;
		hspeed = 0;
	}
	else {
		//Caso não haja colisão, checa pra qual direção player quer se movimentar
		//e se há espaço para virar.
		//O bloco vai ficar fazendo esse teste, e tentará virar para a última
		//direção ativada, a não ser que o player mude de direção
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
	
	
	//Controla a direção do sprite
	var facing_up, facing_left, facing_down, facing_right;
	facing_up = 90;
	facing_left = 180;
	facing_down = 270;
	facing_right = 0;
	
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
	if (floor(x) != x || floor(y) != y) {
		x = floor(x);
		y = floor(y);
	}
}


//Método para interromper o movimento do player
player_stop = function() {
	//Checa o input do player
	var key_right = keyboard_check(ord("D"));
	var key_left = keyboard_check(ord("A"));
	var key_down = keyboard_check(ord("S"));
	var key_up = keyboard_check(ord("W"));
	
	//Checa se teclas em direções opostas estão sendo pressionadas
	var stop_x = key_right and key_left;
	var stop_y = key_down and key_up;
	var stop = stop_x or stop_y;
	
	//Caso estejam, interrompe o movimento do player
	if (stop) {
		has_control = false;

		hspeed = 0;
		vspeed = 0;
		
		//Reseta a última tecla armazenada em lastkey
		keyboard_lastkey = -1;
		
		//Ao final, devolve o controle ao jogador, que pode novamente se movimentar
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
		player_seq_hit = layer_sequence_create("Player", x, y, seq_player_hurt);
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
		layer_sequence_create("Player", x_text, y_text, seq_life_point_less);
		
		//DESTROY ENEMY INSTANCE
		with (other) instance_destroy();
	}
	else if (player_invincible) {	
		//CREATE ANIMATION SEQUENCE WHEN PLAYER HIT ENEMY BUT IS IN INVINCIBLE MODE
		player_seq_hit = layer_sequence_create("Player", x, y, seq_player_invincible);
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
	if (run_player_hit_sequence and player_hp > 0) {
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
			layer_sequence_destroy(player_seq_hit);
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