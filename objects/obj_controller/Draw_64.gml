/// @desc exibe info. do player

//Desenha o texto "pontos"
draw_set_font(fnt_main)
draw_text(x_text, y_text, "pontos:")

//Desenha a pontuação atual do jogador
draw_set_font(fnt_points)
draw_text(x_text, y_text * 1.8, string(points))

//Desenha o texto "Vida"
draw_set_font(fnt_main)
draw_text(x_text, y_text * 3.2, "vida:")

//Desenha os pontos de vida do jogador
var temp_x = x_text
var image_scale = 0.7

if (instance_exists(obj_player)) {
	repeat(obj_player.player_hp) {
		draw_sprite_ext(spr_life_points, 0, temp_x, y_text * 4, image_scale, image_scale, image_angle, image_blend, 0.8)
		temp_x += 35
	}
}



//DEBUG Desenha o level atual do jogador
//if (instance_exists(obj_player)) var player_level = obj_player.player_level
//else var player_level = 1

//draw_set_font(fnt_main)
//draw_text(x_text, y_text*10, string(player_level))

//if (instance_exists(obj_enemy)) {
//	var enemy_debug_info = string(obj_enemy.walk_speed) + "," + string(obj_enemy.hunting_speed) + ","
//	enemy_debug_info += string(obj_enemy.hunting_multiplier) + "," + string(obj_enemy.hunting_time)
//	draw_text(x_text, y_text*11, enemy_debug_info)
//}