/// @desc controla algumas funções do jogo

//Posicionamento dos elementos da tela
x_text = display_get_width()/30;
y_text = display_get_height()/20;

//Variável que armazena as informações do player
if instance_exists(obj_player) player = obj_player;
else player = noone;

//Variável que controla se o player pode subir de level
leveled_up = false;

//Define a pontuação inicial do jogador
points = 0;

//Variável de controle para criar o aviso de último ponto restante
point_warning_created = false;

//Aciona o alarme para gerar os pontos depois de 1 segundo
alarm[0] = room_speed;


//Ativa/desativa a música
play_music = false;

//Ativa/desativa os efeitos sonoros
play_sound = false;

//Ativa/desativa as luzes piscando
light_on = true;

//Toca a música de fundo
if (play_music) audio_play_sound(snd_background_music, 1, true);


//Spawna os inimigos
//Método para spawnar os inimigos
spawn_enemy = function() {
	//Cria o inimigo
	var spawn_x = obj_spawn_area.x + sprite_get_width(spr_enemy)/2;
	var spawn_y = obj_spawn_area.y - 5 + sprite_get_height(spr_enemy)/2;
	instance_create_layer(spawn_x, spawn_y, "enemy", obj_enemy);
	
	//Depois de spawnar o inimigo, muda o index do sprite
	//Esse index será usado dentro do objeto do inimigo
	//para saber se o cadeado está aberto ou fechado
	obj_padlock.image_speed = 1;
}


//Controla como o player sobe de level
//Método para controle do level
player_level_up = function() {
	//Armazena a quantidade pontos atual no jogo
	var points_count = instance_number(obj_point)
	var alarm_reseted = alarm[0] == -1

	if (points_count == 0 and alarm_reseted and !leveled_up) {
		leveled_up = true
		obj_player.player_level++
		
		//Cria os pontos novamente depois de 2 segundos
		alarm[0] = room_speed*2
		
		//Quando o número de pontos chega à zero, remove o aviso de último ponto
		if (instance_exists(obj_point_warning)) {
			point_warning_created = false
			instance_destroy(obj_point_warning)
		}
	}
	
	//Quando restar somente 1 ponto, cria um aviso de ponto restante
	if (points_count == 1 and not(point_warning_created)) {
		point_warning_created = true
		instance_create_layer(obj_point.x, obj_point.y, "points", obj_point_warning)
	}
}


//Inicia as sequências dos portais
right_portal_sequence = layer_sequence_create("Sequences", right_teleport.x, right_teleport.y, seq_portal);
left_portal_sequence = layer_sequence_create("Sequences", left_teleport.x, left_teleport.y, seq_portal);
layer_sequence_xscale(left_portal_sequence, -1);

layer_sequence_pause(right_portal_sequence);
layer_sequence_pause(left_portal_sequence);

portal_angle = 0;

//Método para controlar o teleporte e as sequências do portal
teleport_check = function() {
	portal_angle += 0.5;
	
	layer_sequence_angle(right_portal_sequence, portal_angle);
	layer_sequence_angle(left_portal_sequence, -portal_angle);
	
	with (player) {
		var colliding_portal = place_meeting(x+sign(hspeed)*sprite_get_width(spr_player)/3, y, obj_teleport);
		
		if (colliding_portal) {
			//Teleporte da direita
			if (hspeed > 0) {
				layer_sequence_play(obj_controller.right_portal_sequence);
			
				var player_portal_right = layer_sequence_create("Sequences_1", right_teleport.x-sign(hspeed)*48, right_teleport.y, seq_player_portal);
				layer_sequence_speedscale(player_portal_right, 3);
			}
			//Teleporte da esquerda
			else if (hspeed < 0) {
				layer_sequence_play(obj_controller.left_portal_sequence);
			
				var player_portal_left = layer_sequence_create("Sequences_1", left_teleport.x-sign(hspeed)*48, left_teleport.y, seq_player_portal);
				layer_sequence_xscale(player_portal_left, -1);
				layer_sequence_speedscale(player_portal_left, 3);
			}
		
			//Toca o som do portal
			if (obj_controller.play_sound and !audio_is_playing(snd_portal)) audio_play_sound(snd_portal, 1, false);
		
			//Cancela o modo de caça dos inimigos
			obj_enemy.hunting_mode = false;
		
			//Reseta a última tecla salva
			keyboard_lastkey = -1;

			//Esconde o player durante a animação
			image_alpha = 0;
		
			//Executa o alarme, que irá transportar o player e torná-lo visível de novo
			alarm[0] = room_speed/2;
		}
	}
}