/// @desc movimento do inimigo

//Diz se o inimigo está dentro da área de spawn
var inside_spawn_area = place_meeting(x, y, obj_spawn_area)

if (inside_spawn_area) {
	//Controla o comportamento do inimigo dentro da área de spawn
	enemy_spawn_behavior(id, walk_speed, leaving_area, map_grid)
}
//Só poderá mover-se automaticamente se não estiver dentro da área de spawn
else {
	enemy_move();
}