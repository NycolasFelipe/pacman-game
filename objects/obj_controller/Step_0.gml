//CHECKING IF PLAYER'S ALIVE
var player_exists = instance_exists(obj_player);

#region PLAY BACKGROUND MUSIC
background_music_time--;

if (play_music && !background_music_playing && background_music_time <= 0) {
	background_music_playing = true;
	audio_play_sound(snd_background_music, 0, true);
}
#endregion

#region PLAYER LEVEL
if (player_exists) player_level_up();
#endregion

#region ENEMY SPAWN
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
if (player_exists && obj_player.player_hp <= 0) {
	instance_destroy(obj_player);
	light_on = false;
	save_high_scores();
}

if not(player_exists) {
	var layers = ["Player", "Enemy", "Powerup", "Points", "Sequence_Portal_Effect", "Sequence_Portal", "Inside_Wall", "Outside_Wall"];
	var layers_length = array_length(layers);
	
	for (var i = 0; i < layers_length; i++) layer_set_visible(layers[i], false);
	
	game_over_sequence();
	game_restart_check();
}
#endregion

if (keyboard_check_pressed(vk_up)) {
	player_level++;
}
