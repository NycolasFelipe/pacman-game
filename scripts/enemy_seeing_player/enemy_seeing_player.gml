///@method enemy_seeing_player(id, map_grid, hunting_speed, hunting_mode, hunting_time, hunting_multiplier)
function enemy_seeing_player(_id, _map_grid, _hunting_speed, _hunting_mode, _hunting_time, _hunting_multiplier) {
	
	//Distância que o inimigo pode ver o player
	var distance = _map_grid * _hunting_multiplier;
	
	//Iniciando variáveis
	var moving_x = hspeed != 0;
	var moving_y = vspeed != 0;
	var x_pos = x;
	var y_pos = y;
	
	if instance_exists(obj_player) var player = obj_player;
	else var player = noone;
	
	var collision = obj_collision;
	
	//Checagem do movimento horizontal
	//Muda a posição x inicial de checagem de acordo com a direção do movimento
	if (moving_x) x_pos = x-sign(hspeed)*(sprite_get_width(spr_enemy)/2);
	
	//Checagem do movimento vertical
	//Muda a posição y inicial de checagem de acordo com a direção do movimento
	if (moving_y) y_pos = y-sign(vspeed)*(sprite_get_height(spr_enemy)/2);

	//Checando acima e abaixo, com o valor inicial de x relacionado à direção do movimento horizontal
	var colliding_player_down = collision_line(x_pos, y, x_pos, y+distance, player, false, true);
	var colliding_player_up = collision_line(x_pos, y, x_pos, y-distance, player, false, true);
	
	//Checando acima e abaixo, com o valor inicial de y relacionado à direção do movimento vertical
	var colliding_player_right = collision_line(x, y_pos, x+distance, y_pos, player, false, true);
	var colliding_player_left = collision_line(x, y_pos, x-distance, y_pos, player, false, true);
	
	//Checa se o inimigo vê o player, checando a intercecção entre colliding_player e colliding_wall	
	var can_see_x = colliding_player_right-colliding_player_left;
	var can_see_y = colliding_player_down-colliding_player_up;
	
	
	//Se puder ver o player vertical ou horizontalmente, e não estiver em modo de caça,
	//aumenta a velocidade do inimigo, e ativa o modo de caça
	if (can_see_x-can_see_y != 0) and (!_hunting_mode) {
		
		//Checa o módulo da distância horizontal e vertical até o player
		var distance_x_to_player = abs(player.x-x);
		var distance_y_to_player = abs(player.y-y);
		
		//Checa qual é a posição do player em relação ao inimigo
		var player_at_right = x < player.x and distance_y_to_player < 3;
		var player_at_left = player.x < x and distance_y_to_player < 3;	
		var player_at_bottom = y < player.y and distance_x_to_player < 3;
		var player_at_top = player.y < y and distance_x_to_player < 3;
		
		//Variável de controle do modo de caça
		var start_hunt = false;
		
		//Blocos responsáveis pelo controle de visão do inimigo
		//Só poderá entrar em modo de caça se não houver nenhuma parede entre ele e o player
		if (player_at_right) {
			var seeing_wall_right = collision_line(x_pos, y_pos, x_pos+distance_x_to_player, y_pos, collision, false, false);
			if not(seeing_wall_right) start_hunt = true;
		}
		else if (player_at_left) {
			var seeing_wall_left = collision_line(x_pos, y_pos, x_pos-distance_x_to_player, y_pos, collision, false, false);
			if not(seeing_wall_left) start_hunt = true;
		}
		
		if (player_at_bottom) {
			var seeing_wall_bottom = collision_line(x_pos, y_pos, x_pos, y_pos+distance_y_to_player, collision, false, false);
			if not(seeing_wall_bottom) start_hunt = true;
		}
		else if (player_at_top) {
			var seeing_wall_up = collision_line(x_pos, y_pos, x_pos, y_pos-distance_y_to_player, collision, false, false);
			if not(seeing_wall_up) start_hunt = true;
		}
		
		//Se cumprir os requisitos do bloco anterior, inicia o modo de caça
		if (start_hunt) {
			//Aciona a flag do modo de caça
			_id.hunting_mode = true;
		
			//Inicia a velocidade de caça
			if (hspeed != 0) hspeed = _hunting_speed;		// * can_see_x;
			else if (vspeed != 0) vspeed = _hunting_speed;	// * can_see_y;
	
			//Inicia o alarme que terá a duração do tempo de caça
			if (_id.alarm[0] == -1) _id.alarm[0] = room_speed*_hunting_time;
		
			//Animação antes de iniciar o modo de caça
			switch(_id.sprite_index) {
				case spr_enemy: _id.sprite_index = spr_enemy_surprised;
					break;
				
				case spr_enemy_green: _id.sprite_index = spr_enemy_surprised_green;
					break;
				
				case spr_enemy_red: _id.sprite_index = spr_enemy_surprised_red;
					break;
				
				case spr_enemy_yellow: _id.sprite_index = spr_enemy_surprised_yellow;
					break;
			}
		
			//Muda a direção do sprite
			if (hspeed != 0) image_xscale = sign(hspeed);
		
			//Toca um som quando ver o player
			if (obj_controller.play_sound) audio_play_sound(snd_player_spotted, 0, false);
		}
	}
	
	//Quando o tempo do alarme terminar, e se estiver em modo de caça, retorna à
	//velocidade padrão
	if (_id.alarm[0] == -1 and _hunting_mode) {
		var walk_speed = _id.walk_speed;

		hspeed = sign(hspeed) * walk_speed;
		vspeed = sign(vspeed) * walk_speed;
		
		//Permite entrar em modo de caça novamente
		_id.hunting_mode = false;
			
		//Retorna ao sprite inicial
		switch(_id.sprite_index) {
			case spr_enemy_surprised: _id.sprite_index = spr_enemy;
				break;
				
			case spr_enemy_surprised_green: _id.sprite_index = spr_enemy_green;
				break;
				
			case spr_enemy_surprised_red: _id.sprite_index = spr_enemy_red;
				break;
				
			case spr_enemy_surprised_yellow: _id.sprite_index = spr_enemy_yellow;
				break;
		}
	}
}