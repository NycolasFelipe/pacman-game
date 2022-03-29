/// @desc movimentação do player
if (has_control) {
	player_move();
}

//Checa se o player está tentando interromper o movimento
player_stop();

//MANAGE PLAYER HIT SEQUENCE
player_hit_sequence();
