/// @desc controla algumas funções do jogo

//Posicionamento dos elementos da tela
x_text = display_get_width()/30
y_text = display_get_height()/20



//Define a pontuação inicial do jogador
points = 0

//Level do jogador
player_level = 3



//Ativa/desativa a música
play_music = false

//Ativa/desativa os efeitos sonoros
play_sound = false

//Ativa/desativa as luzes piscando
light_on = true

//Toca a música de fundo
if (play_music) audio_play_sound(snd_background_music, 1, true);



//Spawna os inimigos

//Variáveis que controlam o tempo de spawn
spawn_delay = room_speed
spawn_count = spawn_delay

//Sinaliza a quantidade de inimigos criada
enemies_count = 0

//Método para spawnar os inimigos
///@method spawn_enemy_level(enemies_number)
spawn_enemy_level = function(_enemies_number) {
	spawn_count--
	
	if (enemies_count < _enemies_number and spawn_count <= 0) {
		//Cria o inimigo
		var spawn_x = obj_spawn_area.x + sprite_get_width(spr_enemy)/2
		var spawn_y = obj_spawn_area.y - 5 + sprite_get_height(spr_enemy)/2

		instance_create_layer(spawn_x, spawn_y, "enemy", obj_enemy)
		
		//Sinaliza que um inimigo foi criado
		enemies_count += 1
	
		//Aciona o tempo para gerar o próximo inimigo
		spawn_count = spawn_delay
	}
	
	if (enemies_count == _enemies_number) {
		//Depois de spawnar os inimigos, diminui o alfa do cadeado
		//Esse alfa será usado dentro do objeto do inimigo
		//para saber se o cadeado está aberto ou fechado
		obj_padlock.image_alpha = lerp(obj_padlock.image_alpha, 0.5, 0.1)
	}
}





























//Aciona o alarme para gerar os pontos depois de 1 segundo
alarm[0] = room_speed