//Velocidade de movimento
vel = 4

//Diz se o player está no controle no momento
has_control = true

//Pontos de vida do player
player_hp = 3

//Level atual do player
player_level = 1	//padrão: 1


//Método de movimento do player
player_move = function() {
	
	//Checa a última movimentação do player
	var last_key_right = keyboard_lastkey == ord("D")
	var last_key_left = keyboard_lastkey == ord("A")
	var last_key_down = keyboard_lastkey == ord("S")
	var last_key_up = keyboard_lastkey == ord("W")
	
	///
	
	//Distância até o objeto de colisão
	var colliding_distance = 10
	
	//Objeto a se checar a colisão
	var collision_object = obj_collision
	
	//Checa se há espaço para o player virar se no modo automático
	//A distância de colisão é maior porque o propósito é ser usado para checar
	//se o player pode virar, e não se deve interromper o seu movimento
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object)
	var left_has_space = !place_meeting(x-colliding_distance, y, collision_object)
	var down_has_space = !place_meeting(x, y+colliding_distance, collision_object)
	var up_has_space = !place_meeting(x, y-colliding_distance, collision_object)

	///

	//Checa se o player está colidindo
	var colliding = place_meeting(x+hspeed, y+vspeed, collision_object)
	
	//Se houver colisão, a movimentação do player é interrompida
	if (colliding) {
		vspeed = 0
		hspeed = 0
	}
	else {
		//Caso não haja colisão, checa pra qual direção player quer se movimentar
		//e se há espaço para virar.
		//O bloco vai ficar fazendo esse teste, e tentará virar para a última
		//direção ativada, a não ser que o player mude de direção
		if (last_key_right) and (right_has_space) {
			vspeed = 0
			hspeed = vel
		}
		else if (last_key_left) and (left_has_space) {
			vspeed = 0
			hspeed = -vel
		}
		else if (last_key_down) and (down_has_space) {
			vspeed = vel
			hspeed = 0
		}
		else if (last_key_up) and (up_has_space) {
			vspeed = -vel
			hspeed = 0
		}
	}
	
	///
	
	//Controla a direção do sprite
	var facing_up, facing_left, facing_down, facing_right
	facing_up = 90
	facing_left = 180
	facing_down = 270
	facing_right = 0
	
	if (vspeed < 0) {
		image_angle = facing_up
		if (image_yscale != 1) image_yscale = 1;
	}
	else if (vspeed > 0) {
		image_angle = facing_down
		image_yscale = -1
	}
	else if (hspeed < 0) {
		image_angle = facing_left
		image_yscale = -1
	}
	else if (hspeed > 0) {
		image_angle = facing_right
		if (image_yscale != 1) image_yscale = 1;
	}
}
	
	
//Método que controla os pontos de vida
life_points = function() {
	if (player_hp > 0) {
		//Diminui os pontos de vida
		player_hp--
		
		//Toca o som da animação (somente se o som estiver ativado)
		if (obj_controller.play_sound) audio_play_sound(snd_life_point_less, 0, false);
		
		//Executa a sequência de animação dos pontos de vida
		var x_text = 230 + (player_hp * 50) //mesma posição horizontal dos pontos de vida
		var y_text = 275 //mesma posição vertical dos pontos de vida
		layer_sequence_create("player", x_text, y_text, seq_life_point_less)
	}
	
	//Destrói o inimigo
	with (other) instance_destroy();
}