function enemy_spawn_behavior(_id, _walk_speed, _leaving_area, _map_grid){	//CHECKING IF THE ENEMY IS COLLIDING WITH THE WALL
	var colliding = place_meeting(x+hspeed, y+vspeed, obj_collision);
	
	//CHECKING PADLOCK'S TRANSPARENCY
	var padlock_index = obj_padlock.image_index;
	var padlock_x = obj_padlock.x;
	
	//ANIMATION'S END Y POSITION
	var y_out = 432;
	
	//CONTROLS BEHAVIOR OF ENEMY LEAVING SPAWN AREA
	if (_leaving_area) {
		//ANIMATION SPEED
		var animation_speed = 0.15;
		
		//STOP VERTICAL MOVEMENT TO START ANIMATION
		vspeed = 0;
		
		//CHANGES THE SPRITE'S DIRECTION SO THAT IT POINTS IN THE DIRECTION OF THE ANIMATION
		image_xscale = 1;
		
		//MOVES THE ENEMY'S X CLOSER TO THE PADLOCK'S X, SO THAT IT IS CENTERED ON THE EXIT
		x = lerp(x, padlock_x, animation_speed);
		
		//AS SOON AS THE ENEMY'S X GETS CLOSE ENOUGH TO THE CENTER, THE VERTICAL ANIMATION STARTS
		if (padlock_x-1 <= x and x <= padlock_x+1) {
			y = lerp(y, y_out, animation_speed/2);
			
			//RETURNS THE PADLOCK SPRITE TO ITS INITIAL INDEX
			obj_padlock.image_index = 0;
		}
	}
	
	//CONTROLS ENEMY MOVEMENT WITHIN THE SPAWN AREA
	else if (colliding and hspeed > 0) {
		hspeed = 0;
		vspeed = _walk_speed;
	}
	else if (colliding and vspeed > 0) {
		vspeed = 0;
		hspeed = -_walk_speed;
	}
	else if (colliding and hspeed < 0) {
		hspeed = 0;
		vspeed = -_walk_speed;
	}
	else if (colliding and vspeed < 0) {
	//IF MOVING UP AND PADLOCK IS OFF, STARTS ENEMY EXIT ANIMATION
		if (padlock_index != 0) _id.leaving_area = true;
		else {
			hspeed = _walk_speed;
			vspeed = 0;
		}
	}

	//CONTROLS THE SPRITE DIRECTION
	if (hspeed != 0) image_xscale = sign(hspeed);
}