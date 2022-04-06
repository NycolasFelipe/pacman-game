function create_points(){	//OBJ_POINT'S STARTING POSITION
	var point_x = 480;
	var point_y = 144;

	//OBJ_POINT'S FINAL POSITION
	var point_x_limit = 1500;
	var point_y_limit = 900;

	//OBJ_POINT'S TEMPORARY POSITION
	var temp_x = point_x;
	var temp_y = point_y;

	//MAP DIMENSIONS
	var map_width	= point_x_limit-point_x;
	var map_height	= point_y_limit-point_y;

	//GRID SIZE
	var map_grid = 32;
	
	//SPAWNING THE POINTS
	repeat((map_height*map_width)/map_grid) {
		//AS LONG AS THE TEMPORARY POSITION OF X HAS NOT REACHED THE THRESHOLD VALUE OF X (THE RIGHT SIDE OF THE MAP),
		//IT CONTINUES TO CREATE INSTANCES OF THE POINTS
		if (temp_x <= point_x_limit && temp_y <= point_y_limit) {
			instance_create_layer(temp_x, temp_y, "points", obj_point);
			temp_x += map_grid;
		}
		//IF X HAS REACHED THE LIMIT, RETURN IT TO THE INITIAL VALUE, AND GO DOWN A GRID IN Y, 
		//AND THEN REPEAT THE PROCESS UNTIL Y REACHES THE VERTICAL LIMIT VALUE
		else {
			temp_x = point_x;
			temp_y += map_grid;
		}
	}
	
	
	//DESTROYS THE INSTANCE IF IT COLLIDES WITH THE WALL OR SAFE_AREA
	with (obj_point) {
		//RETURNS IF THE POINT OBJECT IS COLLIDING WITH THE WALL OR THE SAFE AREA
		var colliding_wall		= place_meeting(x, y, obj_collision);
		var colliding_safe_area = place_meeting(x, y, obj_safe_area);
		var colliding_powerup	= place_meeting(x, y, obj_powerup_spawn);
		var colliding = colliding_wall || colliding_safe_area || colliding_powerup;
		
		//IF COLLIDING, DESTROY THE POINT INSTANCE
		if (colliding) instance_destroy(id);
	}
}