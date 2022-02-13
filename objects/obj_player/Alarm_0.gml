/// @desc teleporta o player

//Teleporta para a esquerda
if (hspeed > 0) obj_player.x = 512

//Teleporta para a direita
else if (hspeed < 0) obj_player.x = 1408

//Retorna à transparência original
image_alpha = 1