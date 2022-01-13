/// @desc animação de teleporte

//Toca o som do teleporte ao colidir
var play_sound = obj_controller.play_sound
if (has_control and play_sound) audio_play_sound(snd_teleport, 1, false)


//Desativa o controle de movimento do player
//durante a animação
has_control = false


//Inicia o alarme contendo o bloco de código
//que irá de fato teleportar o player
alarm[0] = 2


//Animação do teleporte

//Valor padrão de rotação para a direita
var rotation_angle = 359

//Executa a animação enquanto o alarme não for disparado,
//e o player for teleportado de fato
if (alarm[0] != -1) {
	//Se o player estiver se movendo para a esquerda
	//muda a direção de rotação do sprite
	if (hspeed < 0) rotation_angle = 0;
	
	//Muda a velocidade, o ângulo, e a velocidade aos poucos,
	//criando o efeito de "sugar" do buraco negro
	image_angle = lerp(image_angle, rotation_angle, 0.01)
	image_alpha = lerp(image_alpha, 0, 0.1)
	hspeed = lerp(hspeed, sign(hspeed), 0.1)
}

//Cancela a caça quando usar o portal
if (instance_exists(obj_enemy)) obj_enemy.hunting_mode = false;
