/// @desc teleporta o player
//Teleporta para a esquerda
with (obj_player) {
	if (hspeed > 0) x = obj_controller.left_portal_x;

	//Teleporta para a direita
	else if (hspeed < 0) x = obj_controller.right_portal_x;

	//Retorna à transparência original
	image_alpha = 1;
}

//Sinaliza que o player encerrou o teleporte
player_teleporting = false;