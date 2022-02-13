/// @desc retorna ao sprite inicial

//Retorna ao sprite inicial
switch(id.sprite_index) {
	case spr_enemy_surprised: id.sprite_index = spr_enemy;
		break
				
	case spr_enemy_surprised_green: id.sprite_index = spr_enemy_green;
		break
				
	case spr_enemy_surprised_red: id.sprite_index = spr_enemy_red;
		break
				
	case spr_enemy_surprised_yellow: id.sprite_index = spr_enemy_yellow;
		break
}