///@method enemy_seeing_player(id, map_grid, hunting_speed, hunting_mode, hunting_time)
function enemy_seeing_player(_id, _map_grid, _hunting_speed, _hunting_mode, _hunting_time){
	//Distância que o inimigo pode ver o player
	var distance_x = _map_grid * 5
	var distance_y = _map_grid * 5
	
	var x_pos = x + (sign(hspeed)*sprite_get_width(spr_enemy)/2)
	var y_pos = y + (sign(vspeed)*sprite_get_height(spr_enemy)/2)
	
	//Checando se pode ver o player horizontal ou verticalmente
	var colliding_player_right = collision_line(x, y_pos, x+distance_x, y_pos, obj_player, false, true)
	var colliding_player_left = collision_line(x, y_pos, x-distance_x, y_pos, obj_player, false, true)
	var colliding_player_down = collision_line(x_pos, y, x_pos, y+distance_y, obj_player, false, true)
	var colliding_player_up = collision_line(x_pos, y, x_pos, y-distance_y, obj_player, false, true)
	
	//Checando se está vendo a parede horizontal ou verticalmente
	var colliding_wall_right = collision_line(x, y_pos, x+distance_x, y_pos, obj_collision, false, true)
	var colliding_wall_left = collision_line(x, y_pos, x-distance_x, y_pos, obj_collision, false, true)
	var colliding_wall_down = collision_line(x_pos, y, x_pos, y+distance_y, obj_collision, false, true)
	var colliding_wall_up = collision_line(x_pos, y, x_pos, y-distance_y, obj_collision, false, true)
	
	//Se estiver vendo o player e NÃO estiver vendo uma parede, então retorna true
	//1 - Vê o player à direita \ acima
	//-1 - Vê o player à esquerda \ abaixo
	var can_see_x = (colliding_player_right and !colliding_wall_right) - (colliding_player_left and !colliding_wall_left)
	var can_see_y = (colliding_player_down and !colliding_wall_down) - (colliding_player_up and !colliding_wall_up)
	
	//Se puder ver o player vertical ou horizontalmente, e não estiver já em modo de caça,
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
	}
}