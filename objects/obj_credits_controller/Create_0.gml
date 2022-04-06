pacman_x		= obj_camera.x;
pacman_y		= obj_camera.y-170;
pacman_scale	= 7;


ghost_sprites = [
	spr_enemy,
	spr_enemy_surprised,
	spr_enemy_red,
	spr_enemy_surprised_red,
	spr_enemy_green,
	spr_enemy_surprised_green,
	spr_enemy_yellow,
	spr_enemy_surprised_yellow,
];

draw_ghost_x		= obj_camera.x;
draw_ghost_y		= obj_camera.y+35;
draw_ghost_delay	= 180;
draw_ghost_time		= draw_ghost_delay;
draw_ghost_gap		= 60;


credits_text_x	= obj_camera.x;
credits_text_y	= obj_camera.y+120;
credits_gap		= 70;

credits_text = [
	[credits_text_x, credits_text_y, "CREDITS:",					fnt_menu_main],
	[credits_text_x, credits_text_y, "CREATED BY NYCOLASFELIPE",	fnt_menu],
	[credits_text_x, credits_text_y, "PACMAN GAME - 2022",			fnt_menu],
]
credits_text_length = array_length(credits_text);


draw_credits_screen = function() {
	draw_ghost_time--;
	
	//DRAWING PACMAN
	draw_sprite_ext(spr_player, image_index, pacman_x, pacman_y, pacman_scale, pacman_scale, image_angle, image_blend, 1);
	
	//SHUFFLING GHOST SPRITES ARRAY
	if (draw_ghost_time <= 0) {
		draw_ghost_time = draw_ghost_delay;
		
		for (count = 0; count < array_length(ghost_sprites); count++) {
		    var i = irandom_range(1, array_length(ghost_sprites)-1);
		    var tmp = ghost_sprites[i];
		    ghost_sprites[i] = ghost_sprites[0];
		    ghost_sprites[0] = tmp;
		}
	}
	
	//DRAWING GHOSTS
	for (var i = 0; i < 5; i++) {
		draw_sprite(ghost_sprites[i], image_index, draw_ghost_x+draw_ghost_gap*(i-2), draw_ghost_y);
	}
	
	//DRAWING CREDITS TEXT
	draw_set_halign(fa_center);
	
	for (var i = 0; i < credits_text_length; i++) {
		draw_set_font(credits_text[i][3]);
		draw_text(credits_text[i][0], credits_text[i][1]+(credits_gap*i), credits_text[i][2]);
	}	
	
	draw_set_font(-1);
	draw_set_halign(-1);
}
	

checking_input = function() {
	var any_key = keyboard_check_pressed(vk_anykey);
	if (any_key) game_restart();
}
