///@method enemy_auto_move(walk_speed, collision_object)
function enemy_auto_move(_walk_speed){
	//Distância até o objeto de colisão
	var colliding_distance = 20
	
	//Objeto a se checar a colisão
	var collision_object = obj_collision

	//Checa se há espaço para o player virar se no modo automático
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object)
	var left_has_space = !place_meeting(x-colliding_distance, y, collision_object)
	var down_has_space = !place_meeting(x, y+colliding_distance, collision_object)
	var up_has_space = !place_meeting(x, y-colliding_distance, collision_object)

	var has_vertical_space = down_has_space or up_has_space
	var has_horizontal_space = right_has_space or left_has_space

	///

	if (has_vertical_space and has_horizontal_space) {

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
					
					//show_message("me movi para esquerda!")
				break;
					
				case moveright:
					hspeed = _walk_speed
					vspeed = 0
					//show_message("me movi para direita!")
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
				
					//show_message("me movi para cima!")
				break;
					
				case movedown:
					vspeed = _walk_speed
					hspeed = 0
				
					//show_message("me movi para baixo!")
				break;
			}
		}	
	}
}