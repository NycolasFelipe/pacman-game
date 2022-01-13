if (sprite_index != spr_enemy) {
	switch(sprite_index) {
	case spr_enemy_surprised: sprite_index = spr_enemy;
		break
				
	case spr_enemy_surprised_green: sprite_index = spr_enemy_green;
		break
				
	case spr_enemy_surprised_red: sprite_index = spr_enemy_red;
		break
				
	case spr_enemy_surprised_yellow: sprite_index = spr_enemy_yellow;
		break
	}
}