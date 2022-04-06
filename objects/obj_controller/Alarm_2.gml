//TELEPORT THE PLAYER
with (obj_player) {
	//TELEPORT TO THE LEFT
	if (hspeed > 0) x = obj_controller.left_portal_x;

	//TELEPORT TO THE RIGHT
	else if (hspeed < 0) x = obj_controller.right_portal_x;

	//RETURN PLAYER'S ORIGINAL TRANSPARENCY
	image_alpha = 1;
}

//WARN THAT THE PLAYER HAS ENDED TELEPORTING
player_teleporting = false;