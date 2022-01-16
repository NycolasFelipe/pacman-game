///@method enemy_auto_move(walk_speed, collision_object)
function enemy_auto_move(_walk_speed, _map_grid){
	//Distância até o objeto de colisão
	var colliding_distance = _map_grid
	
	//Objeto a se checar a colisão
	var collision_object = obj_collision

	//Checa se há espaço para o player virar se no modo automático
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object)
	var left_has_space = !place_meeting(x-colliding_distance, y, collision_object)
	var down_has_space = !place_meeting(x, y+colliding_distance, collision_object)
	var up_has_space = !place_meeting(x, y-colliding_distance, collision_object)

	var has_vertical_space = down_has_space or up_has_space
	var has_horizontal_space = right_has_space or left_has_space

	//Diz se o inimigo está preso em uma parede
	var stuck = (hspeed == 0 and vspeed == 0)
	
	//Garante que já está fora da área de spawn
	//As coordenas x = 944 e y = 416 são as do grid logo acima do padlock, isto é, da entrada da àrea de spawn
	var outside_spawn = !(x < 944 and x > 944+_map_grid) and !(y < 416+_map_grid and y > 416)
	
	//Se o inimigo estiver preso em uma parede, corrige a sua posição e seu movimento
	if (stuck and outside_spawn) {
		//_map_grid = 32
		var valid_teleport_x = !place_meeting(ceil(x/_map_grid)*_map_grid, y, collision_object)
		var valid_teleport_y = !place_meeting(x, (ceil(y/_map_grid)*_map_grid)-16, collision_object)
		
		//Teleporta o inimigo ao último grid válido no eixo x
		if (valid_teleport_x) x = ceil(x/_map_grid)*_map_grid
		else x = (ceil(x/_map_grid)*_map_grid)-_map_grid
		
		//Teleporta o inimigo ao último grid válido no eixo y
		if (valid_teleport_y) y = (ceil(y/_map_grid)*_map_grid)-16
		else y = (ceil(y/_map_grid)*_map_grid)-16
		
		//Inicia novamente o movimento
		if (has_vertical_space) vspeed = choose(_walk_speed, -_walk_speed)
		else if (has_horizontal_space) hspeed = choose(_walk_speed, -_walk_speed)
	}
	//Controla a movimentação do inimigo
	else if (has_vertical_space and has_horizontal_space) {

		var movex, movey
		movex = 0
		movey = 1
	
		var choice_xy = choose(movex, movey)
		
		//Mover horizontalmente
		if (choice_xy == movex) {
			var moveleft, moveright
			moveleft = 0
			moveright = 1
			
			var choice_left_right = choose(irandom_range(0, 3))
			
			switch(choice_left_right) {
				case moveleft:
					hspeed = -_walk_speed
					vspeed = 0
				break;
					
				case moveright:
					hspeed = _walk_speed
					vspeed = 0
				break;
			}
			
		}
		
		//Mover verticalmente
		else if (choice_xy == movey) {
			var moveup, movedown
			moveup = 0
			movedown = 1
			
			var choice_up_down = choose(irandom_range(0, 3))
			
			switch(choice_up_down) {
				case moveup:
					vspeed = -_walk_speed
					hspeed = 0
				break;
					
				case movedown:
					vspeed = _walk_speed
					hspeed = 0
				break;
			}
		}	
	}
}