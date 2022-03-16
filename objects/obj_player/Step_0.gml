/// @desc movimentação do player
if (has_control) {
	player_move();
}

//Checa se o player está tentando interromper o movimento
player_stop();


//Controla a sequência de quando o player perde vida
if (play_seq_hurt and player_hp > 0) {
	//Faz com que a animação siga a posição do player
	layer_sequence_x(player_seq_hurt, x);
	layer_sequence_y(player_seq_hurt, y);
	
	//Diminui temporariamente o alfa e a velocidade do player ao perder vida
	image_alpha = 0;
	hspeed /= 2;
	vspeed /= 2;
	
	//Ao terminar a sequência, a destrói e redefine a variável de controle, velocidade e alfa do player
	if (layer_sequence_is_finished(player_seq_hurt)) {
		layer_sequence_destroy(player_seq_hurt);
		play_seq_hurt = false;
		image_alpha = 1;
		hspeed *= 2;
		vspeed *= 2;
	}
}
else if (player_hp == 1 and not(obj_controller.player_teleporting)) {
	num++;
	image_alpha = max(0.5,sin(num/4));
}