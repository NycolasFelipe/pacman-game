/// @desc teleporta o player

//Diz em qual dos dois teleportes o player encostou
var teleport_side = other.x

//Encostou no teleporte da direita
if (teleport_side > room_width/2) {
	//Acessa a instância com id teleport_left, e busca a sua
	//coordenada x que está armazenada em x_pos
	x = teleport_left.x_pos + 55
}
//Encostou no teleporte da esquerda
else if (teleport_side < room_width/2) {
	//Acessa a instância com id teleport_left, e busca a sua
	//coordenada x que está armazenada em x_pos
	x = teleport_right.x_pos - 55
}

//Ao final do teleporte, restaura o ângulo da imagem
image_angle = 0

//Ao final do teleporte, devolve o controle de movimento ao jogador
has_control = true

