//CHECKS IF THE ENEMY IS INSIDE THE SPAWN AREA
inside_spawn_area = place_meeting(x, y, obj_spawn_area);

if (inside_spawn_area) {
	//CONTROLS ENEMY BEHAVIOR WITHIN THE SPAWN AREA
	enemy_spawn_behavior(id, walk_speed, leaving_area, map_grid);
}
//IT WILL ONLY BE ABLE TO MOVE AUTOMATICALLY IF IT IS NOT INSIDE THE SPAWN AREA
else if not(global.game_is_paused) {
	enemy_move();
}