///@method enemy_seeing_player(id, map_grid, hunting_speed, hunting_mode, hunting_time)
function enemy_seeing_player(_id, _map_grid, _hunting_speed, _hunting_mode, _hunting_time, _hunting_multiplier){
	
	//Distância que o inimigo pode ver o player
	var distance = _map_grid * _hunting_multiplier
	
	//Iniciando variáveis
	var moving_right = hspeed > 0
	var moving_left = hspeed < 0
	var moving_down = vspeed > 0
	var moving_up = vspeed < 0
	
	var x_pos = x
	var y_pos = y
	
	
	
	//Checando se está vendo a parede horizontal ou verticalmente
	var colliding_wall_right = collision_line(x, y, x+distance, y, obj_collision, false, true)
	var colliding_wall_left = collision_line(x, y, x-distance, y, obj_collision, false, true)
	var colliding_wall_down = collision_line(x, y, x, y+distance, obj_collision, false, true)
	var colliding_wall_up = collision_line(x, y, x, y-distance, obj_collision, false, true)
	
	
	
	//Checagem do movimento horizontal
	if (moving_right) {
		//Checando à direita
		var colliding_player_right = collision_line(x, y, x+distance, y, obj_player, false, true)
		
		//Muda a posição x inicial de checagem de acordo com a direção do movimento
		x_pos = x-(sprite_get_width(spr_enemy)/2)
	}
	else if (moving_left) {
		//Checando à esquerda
		var colliding_player_left = collision_line(x, y, x-distance, y, obj_player, false, true)
		
		//Muda a posição x inicial de checagem de acordo com a direção do movimento
		x_pos = x+(sprite_get_width(spr_enemy)/2)
	}
	
	//Checagem do movimento vertical
	if (moving_down) {
		//Checando abaixo
		var colliding_player_down = collision_line(x, y, x, y+distance, obj_player, false, true)
		
		//Muda a posição y inicial de checagem de acordo com a direção do movimento
		y_pos = y-(sprite_get_height(spr_enemy)/2)
	}
	else if (moving_up) {
		//Checando acima
		var colliding_player_up = collision_line(x, y, x, y-distance, obj_player, false, true)
		
		//Muda a posição y inicial de checagem de acordo com a direção do movimento
		y_pos = y+(sprite_get_height(spr_enemy)/2)
	}
	
	//Checando acima e abaixo, com o valor inicial de x relacionado à direção do movimento horizontal
	var colliding_player_down = collision_line(x_pos, y, x_pos, y+distance, obj_player, false, true)
	var colliding_player_up = collision_line(x_pos, y, x_pos, y-distance, obj_player, false, true)
	
	//Checando acima e abaixo, com o valor inicial de y relacionado à direção do movimento vertical
	var colliding_player_right = collision_line(x, y_pos, x+distance, y_pos, obj_player, false, true)
	var colliding_player_left = collision_line(x, y_pos, x-distance, y_pos, obj_player, false, true)
	
	
	
	//Checa se o inimigo vê o player, checando a intercecção entre colliding_player e colliding_wall	
	var can_see_x = (colliding_player_right and !colliding_wall_right) - (colliding_player_left and !colliding_wall_left)
	var can_see_y = (colliding_player_down and !colliding_wall_down) - (colliding_player_up and !colliding_wall_up)
	
	//Se puder ver o player vertical ou horizontalmente, e não estiver em modo de caça,
	//aumenta a velocidade do inimigo, e ativa o modo de caça
	if (can_see_x-can_see_y != 0) and (!_hunting_mode) {
		_id.hunting_mode = true
		
		if (hspeed != 0) hspeed = _hunting_speed * can_see_x;
		else if (vspeed != 0) vspeed = _hunting_speed * can_see_y;
	
		//Define o alarme para durar 5 segundos
		if (_id.alarm[0] == -1) _id.alarm[0] = room_speed * _hunting_time;
		
		
		//Animação antes de iniciar o modo de caça
		switch(_id.sprite_index) {
			case spr_enemy: _id.sprite_index = spr_enemy_surprised;
				break
				
			case spr_enemy_green: _id.sprite_index = spr_enemy_surprised_green;
				break
				
			case spr_enemy_red: _id.sprite_index = spr_enemy_surprised_red;
				break
				
			case spr_enemy_yellow: _id.sprite_index = spr_enemy_surprised_yellow;
				break
		}
		
		//Muda a direção do sprite
		if (hspeed != 0) image_xscale = sign(hspeed);
		
		//Toca um som quando ver o player
		if (obj_controller.play_sound) audio_play_sound(snd_player_spotted, 0, false);
	}
	
	//Quando o tempo do alarme terminar, e se estiver em modo de caça, retorna à
	//velocidade padrão
	if (_id.alarm[0] == -1 and _hunting_mode) {
		var walk_speed = _id.walk_speed

		hspeed = sign(hspeed) * walk_speed
		vspeed = sign(vspeed) * walk_speed
		
		//Permite entrar em modo de caça novamente
		_id.hunting_mode = false
		
		//Retorna ao sprite inicial
		switch(_id.sprite_index) {
			case spr_enemy_surprised: _id.sprite_index = spr_enemy;
				break
				
			case spr_enemy_surprised_green: _id.sprite_index = spr_enemy_green;
				break
				
			case spr_enemy_surprised_red: _id.sprite_index = spr_enemy_red;
				break
				
			case spr_enemy_surprised_yellow: _id.sprite_index = spr_enemy_yellow;
				break
		}
	}
}