/// @desc controla algumas funções do jogo

//Posicionamento dos elementos da tela
x_text = display_get_width()/30
y_text = display_get_height()/20


//Variável que controla se o player pode subir de level
leveled_up = false

//Define a pontuação inicial do jogador
points = 0

//Aciona o alarme para gerar os pontos depois de 1 segundo
alarm[0] = room_speed

//Ativa/desativa a música
play_music = false

//Ativa/desativa os efeitos sonoros
play_sound = false

//Ativa/desativa as luzes piscando
light_on = true

//Toca a música de fundo
if (play_music) audio_play_sound(snd_background_music, 1, true);


//Spawna os inimigos
//Método para spawnar os inimigos
spawn_enemy = function() {
	//Cria o inimigo
	var spawn_x = obj_spawn_area.x + sprite_get_width(spr_enemy)/2
	var spawn_y = obj_spawn_area.y - 5 + sprite_get_height(spr_enemy)/2
	instance_create_layer(spawn_x, spawn_y, "enemy", obj_enemy)
	
	//Depois de spawnar o inimigo, muda o index do sprite
	//Esse index será usado dentro do objeto do inimigo
	//para saber se o cadeado está aberto ou fechado
	obj_padlock.image_speed = 1
}


//Controla como o player sobe de level
//Método para controle do level
player_level_up = function() {
	var point_count = instance_number(obj_point)
	var alarm_reseted = alarm[0] == -1

	if (point_count == 0 and alarm_reseted and !leveled_up) {
		leveled_up = true
		obj_player.player_level++
		
		//Cria os pontos novamente depois de 2 segundos
		alarm[0] = room_speed*2
	}
}