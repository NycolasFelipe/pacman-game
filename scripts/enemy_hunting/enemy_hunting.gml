///@method enemy_hunting(map_grid, hunting_speed)
function enemy_hunting(_map_grid, _hunting_speed){
	//Distância até o objeto de colisão
	var colliding_distance = _map_grid
	
	//Objeto a se checar a colisão
	var collision_object = obj_collision
	
	//Checa se há espaço para o inimigo virar 
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object)
	var left_has_space = !place_meeting(x-colliding_distance, y, collision_object)
	var down_has_space = !place_meeting(x, y+colliding_distance, collision_object)
	var up_has_space = !place_meeting(x, y-colliding_distance, collision_object)

	///

	//Checa se o player está colidindo
	var colliding = place_meeting(x+hspeed, y+vspeed, collision_object)
	
	//Se houver colisão, a movimentação do player é interrompida
	if (!colliding) {
		//Checa a posição do player relativa ao inimigo
		var player_right = obj_player.x > x + _map_grid
		var player_left = obj_player.x < x - _map_grid
		var player_down = obj_player.y > y + _map_grid
		var player_up = obj_player.y < y - _map_grid
		
		//Se move na última direção pedida
		if (right_has_space and player_right) {
			vspeed = 0
			hspeed = _hunting_speed
		}
		else if (left_has_space and player_left) {
			vspeed = 0
			hspeed = -_hunting_speed
		}
		else if (down_has_space and player_down) {
			vspeed = _hunting_speed
			hspeed = 0
		}
		else if (up_has_space and player_up) {
			vspeed = -_hunting_speed
			hspeed = 0
		}
	}
	else {
		if (hspeed != 0) hspeed = 0;
		if (vspeed != 0) vspeed = 0;
	}
	
	//Controla a direção do sprite
	if (hspeed != 0) image_xscale = sign(hspeed)
}