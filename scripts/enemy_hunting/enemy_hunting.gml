///@method enemy_hunting(map_grid, hunting_speed)
function enemy_hunting(_map_grid, _hunting_speed){
	//DISTANCE TO COLLISION OBJECT
	var colliding_distance = _map_grid;
	
	//COLLISION OBJECT
	var collision_object = obj_collision;
	
	//CHECKING IF THERE IS ROOM TO CHANGE DIRECTION
	var right_has_space = !place_meeting(x+colliding_distance, y, collision_object);
	var left_has_space	= !place_meeting(x-colliding_distance, y, collision_object);
	var down_has_space	= !place_meeting(x, y+colliding_distance, collision_object);
	var up_has_space	= !place_meeting(x, y-colliding_distance, collision_object);

	//CHECKING IF ENEMY IS COLLIDING
	var colliding = place_meeting(x+hspeed, y+vspeed, collision_object);	
	
	//CHECKING IF ENEMY IS STUCK IN A WALL
	var stuck = (hspeed == 0 && vspeed == 0);
		
	if (stuck) {
		//PLACES THE ENEMY IN A VALID POSITION
		var collision_object = obj_collision;
		
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
	}
	
	
	//IF THERE IS NO COLLISION AND PLAYER IS STILL ALIVE, MOVE NORMALLY
	if (!colliding && instance_exists(obj_player)) {
		var player = obj_player;
		
		//CHECKS PLAYER'S POSITION RELATIVE TO THE ENEMY
		var player_right	= player.x > x + _map_grid;
		var player_left		= player.x < x - _map_grid;
		var player_down		= player.y > y + _map_grid;
		var player_up		= player.y < y - _map_grid;
		
		//Se move na última direção pedida
		if (right_has_space && player_right) {
			vspeed = 0;
			hspeed = _hunting_speed;
		}
		else if (left_has_space && player_left) {
			vspeed = 0;
			hspeed = -_hunting_speed;
		}
		else if (down_has_space && player_down) {
			vspeed = _hunting_speed;
			hspeed = 0;
		}
		else if (up_has_space && player_up) {
			vspeed = -_hunting_speed;
			hspeed = 0;
		}
	}
	else {
		if (hspeed != 0) hspeed = 0;
		if (vspeed != 0) vspeed = 0;
	}
	
	//Controla a direção do sprite
	if (hspeed != 0) image_xscale = sign(hspeed);
}