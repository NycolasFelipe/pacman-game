/// @desc spawna os inimigos

//Level do jogador, armazenado no obj_player
var player_level = obj_player.player_level;


//Método para spawnar os inimigos
if (alarm[1] == -1) {
	switch(player_level) {
		case 1:	//padrão: 1
			spawn_enemy();
			alarm[1] = room_speed*12;
		break;
		
		case 2:
			spawn_enemy();
			alarm[1] = room_speed*9;
		break;
	}
}


//Controla como o player sobe de level
player_level_up();

//Checa o teleporte e controla a sequência do portal
teleport_check();


///DEBUG
//Apertar seta p/ cima aumenta o nível do player e para baixo diminui
level_up = keyboard_check_pressed(vk_up);
level_down = keyboard_check_pressed(vk_down);

if (level_up and player_level < 5) obj_player.player_level++;
else if (level_down and player_level > 1) obj_player.player_level--;