///@method enemy_auto_move(walk_speed, collision_object)
function enemy_auto_move(_walk_speed, _map_grid){
	//DISTANCE TO COLLISION OBJECT
	var colliding_distance = _map_grid/2;
	
	//COLLISION OBJECT
	var collision_object = obj_collision;

	//CHECKING IF THERE IS ROOM TO CHANGE DIRECTION
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object);
	var left_has_space	= !place_meeting(x-colliding_distance, y, collision_object);
	var down_has_space	= !place_meeting(x, y+colliding_distance, collision_object);
	var up_has_space	= !place_meeting(x, y-colliding_distance, collision_object);

	var has_vertical_space = down_has_space || up_has_space;
	var has_horizontal_space = right_has_space || left_has_space;

	//CHECKING IF ENEMY IS STUCK IN A WALL
	var stuck = (hspeed == 0 && vspeed == 0);
	
	//MAKE SURE THE ENEMY IS ALREADY OUT OF THE SPAWN AREA
	//THE COORDINATES X = 944 AND Y = 416 ARE THE GRID JUST ABOVE THE PADLOCK
	var outside_spawn = !(x < 944 && x > 944+_map_grid) && !(y < 416+_map_grid && y > 416);
	
	//IF THE ENEMY IS STUCK IN A WALL, FIX THEIR POSITION AND MOVEMENT
	if (stuck && outside_spawn) {
		//_map_grid = 32
		var colliding_wall_x = place_meeting(ceil(x/_map_grid)*_map_grid, y, collision_object);
		var colliding_wall_y = place_meeting(x, (ceil(y/_map_grid)*_map_grid)-16, collision_object);
		
		var valid_teleport_x = !colliding_wall_x;
		var valid_teleport_y = !colliding_wall_y;
		
		//TELEPORT THE ENEMY TO THE LAST VALID GRID ON THE X AXIS
		if (valid_teleport_x) x = ceil(x/_map_grid)*_map_grid;
		else x = (ceil(x/_map_grid)*_map_grid)-_map_grid;
		
		//TELEPORT THE ENEMY TO THE LAST VALID GRID ON THE Y AXIS
		if (valid_teleport_y) y = (ceil(y/_map_grid)*_map_grid)-16;
		else y = (ceil(y/_map_grid)*_map_grid)-16;
		
		//START MOVING AGAIN
		if (has_vertical_space) vspeed = choose(_walk_speed, -_walk_speed);
		else if (has_horizontal_space) hspeed = choose(_walk_speed, -_walk_speed);
	}
	//CONTROLS THE ENEMY'S MOVEMENT
	else if (has_vertical_space && has_horizontal_space) {

		var movex, movey;
		movex = 0;
		movey = 1;
	
		var choice_xy = choose(movex, movey);
		
		//MOVE HORIZONTALLY
		if (choice_xy == movex) {
			var moveleft, moveright;
			moveleft = 0;
			moveright = 1;
			
			var choice_left_right = choose(irandom_range(0, 3));
			
			switch(choice_left_right) {
				case moveleft:
					hspeed = -_walk_speed;
					vspeed = 0;
				break;
					
				case moveright:
					hspeed = _walk_speed;
					vspeed = 0;
				break;
			}
			
		}
		
		//MOVE VERTICALLY
		else if (choice_xy == movey) {
			var moveup, movedown;
			moveup = 0;
			movedown = 1;
			
			var choice_up_down = choose(irandom_range(0, 3));
			
			switch(choice_up_down) {
				case moveup:
					vspeed = -_walk_speed;
					hspeed = 0;
				break;
					
				case movedown:
					vspeed = _walk_speed;
					hspeed = 0;
				break;
			}
		}	
	}
}