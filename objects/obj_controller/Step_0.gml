#region PLAYER LEVEL
player_level_up();
#endregion

#region ENEMY SPAWN
var player_exists = instance_exists(obj_player);

if (player_exists && not(global.game_is_paused)) enemy_spawn();
#endregion

#region OTHER
//CHECKING TELEPORT
if not(global.game_is_paused) teleport_check();
#endregion

#region POWERUPS
powerups();
#endregion

#region GAME OVER SEQUENCE
if (player_exists && obj_player.player_hp <= 0) instance_destroy(obj_player);

if !(player_exists) {
	var layers = ["Player", "Enemy", "Powerup", "Points", "Sequence_Portal_Effect", "Sequence_Portal", "Inside_Wall", "Outside_Wall"];
	var layers_length = array_length(layers);
	
	for (var i = 0; i < layers_length; i++) layer_set_visible(layers[i], false);
	
	game_over_sequence();
	game_restart_check();
}
#endregion

#region DEBUG
//Apertar seta p/ cima aumenta o nível do player e para baixo diminui
level_up = keyboard_check_pressed(vk_up);
level_down = keyboard_check_pressed(vk_down);

if (level_up and player_level < 10) {
	player_level++;
	leveled_up = true;
}
else if (level_down and player_level > 1) player_level--;
#endregion

