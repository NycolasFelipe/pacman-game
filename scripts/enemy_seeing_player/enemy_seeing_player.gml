///@method enemy_seeing_player(id, map_grid, hunting_speed, hunting_mode, hunting_time, hunting_duration, hunting_multiplier)
function enemy_seeing_player(_id, _map_grid, _hunting_speed, _hunting_mode, _hunting_time, _hunting_duration, _hunting_multiplier) {
	//DISTANCE THE ENEMY CAN SEE THE PLAYER
	var distance = _map_grid * _hunting_multiplier;
	
	//SETTING VARIABLES
	var moving_x = hspeed != 0;
	var moving_y = vspeed != 0;
	var x_pos = x;
	var y_pos = y;
	
	if instance_exists(obj_player) var player = obj_player;
	else var player = noone;
	
	//COLLISION OBJECT
	var collision = obj_collision;
	

	//CHECKING HORIZONTAL COLLISION WITH PLAYER
	//CHANGE THE X INITIAL CHECK POSITION ACCORDING TO THE MOVEMENT'S DIRECTION
	if (moving_x) x_pos = x-sign(hspeed)*(sprite_get_width(spr_enemy)/2);
	
	//CHECKING VERTICAL COLLISION WITH PLAYER
	//CHANGE THE Y INITIAL CHECK POSITION ACCORDING TO THE MOVEMENT'S DIRECTION
	if (moving_y) y_pos = y-sign(vspeed)*(sprite_get_height(spr_enemy)/2);

	//CHECKING ABOVE AND BELOW, WITH THE INITIAL VALUE OF X RELATED TO THE DIRECTION OF HORIZONTAL MOVEMENT
	var colliding_player_down = collision_line(x_pos, y, x_pos, y+distance, player, false, true);
	var colliding_player_up = collision_line(x_pos, y, x_pos, y-distance, player, false, true);
	
	//CHECKING RIGHT AND LEFT, WITH THE INITIAL VALUE OF Y RELATED TO THE DIRECTION OF VERTICAL MOVEMENT
	var colliding_player_right = collision_line(x, y_pos, x+distance, y_pos, player, false, true);
	var colliding_player_left = collision_line(x, y_pos, x-distance, y_pos, player, false, true);
	
	//CHECKS IF THE ENEMY SEES THE PLAYER, CHECKING THE INTERSECTION BETWEEN COLLIDING_PLAYER AND COLLIDING_WALL
	var can_see_x = colliding_player_right-colliding_player_left;
	var can_see_y = colliding_player_down-colliding_player_up;

	
	//IF THE ENEMY CAN SEE THE PLAYER VERTICALLY OR HORIZONTALLY AND THEY'RE NOT IN HUNTING MODE,
	//INCREASE ENEMY SPEED, AND ACTIVATE HUNTING MODE
	if (can_see_x-can_see_y != 0) && (!_hunting_mode) {
		//CHECKING HORIZONTAL AND VERTICAL ABSOLUTE DISTANCE TO THE PLAYER
		var distance_x_to_player = abs(player.x-x);
		var distance_y_to_player = abs(player.y-y);
		
		//CHECKING PLAYER'S POSITION IN RELATION TO THE ENEMY
		var player_at_right		= x < player.x && distance_y_to_player < 3;
		var player_at_left		= player.x < x && distance_y_to_player < 3;	
		var player_at_bottom	= y < player.y && distance_x_to_player < 3;
		var player_at_top		= player.y < y && distance_x_to_player < 3;
		
		//HUNTING MODE FLAG
		var start_hunt = false;
		
		//MANAGING ENEMY VISION
		//ENEMY CAN ONLY ENTER HUNTING MODE IF THERE IS NO WALL BETWEEN THEM AND THE PLAYER
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

		
		//HUNTING MODE BEHAVIOR
		if (start_hunt) {
			_id.hunting_mode = true;
		
			//START HUNTING SPEED
			if (hspeed != 0) hspeed = _hunting_speed;
			else if (vspeed != 0) vspeed = _hunting_speed;
	
			//STARTS THE ALARM THAT WILL LAST FOR THE DURATION OF THE HUNTING TIME
			_id.hunting_time = _hunting_duration;
			if (_id.alarm[0] == -1) _id.alarm[0] = room_speed*_hunting_time;
		
			//ANIMATION BEFORE STARTING HUNTING MODE
			switch(_id.sprite_index) {
				case spr_enemy: _id.sprite_index = spr_enemy_surprised break;
				case spr_enemy_green: _id.sprite_index = spr_enemy_surprised_green break;
				case spr_enemy_red: _id.sprite_index = spr_enemy_surprised_red break;
				case spr_enemy_yellow: _id.sprite_index = spr_enemy_surprised_yellow break;
			}
		
			//CHANGES SPRITE'S DIRECTION
			if (hspeed != 0) image_xscale = sign(hspeed);
		
			//PLAY PLAYER SPOTTED SOUND EFFECT
			if (obj_controller.play_sound) audio_play_sound(snd_player_spotted, 0, false);
		}
	}
	
	//END HUNT
	if !(global.game_is_paused) _id.hunting_time--;
	
	//WHEN THE ALARM TIME IS UP, AND IF IN HUNTING MODE, RETURNS TO DEFAULT SPEED
	if (_id.hunting_time <= 0 && _hunting_mode) {
		var walk_speed = _id.walk_speed;

		hspeed = sign(hspeed)*walk_speed;
		vspeed = sign(vspeed)*walk_speed;
		
		//ALLOWS TO ENTER IN HUNTING MODE AGAIN
		_id.hunting_mode = false;
			
		//RETURNS TO INITIAL SPRITE
		switch(_id.sprite_index) {
			case spr_enemy_surprised: _id.sprite_index = spr_enemy break;
			case spr_enemy_surprised_green: _id.sprite_index = spr_enemy_green break;
			case spr_enemy_surprised_red: _id.sprite_index = spr_enemy_red break;
			case spr_enemy_surprised_yellow: _id.sprite_index = spr_enemy_yellow break;
		}
	}
}