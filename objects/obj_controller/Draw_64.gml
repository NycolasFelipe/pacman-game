/// @desc exibe info. do player

//Desenha o texto "pontos"
draw_set_font(fnt_main)
draw_text(x_text, y_text, "pontos:")

//Desenha a pontuação atual do jogador
draw_set_font(fnt_points)
draw_text(x_text, y_text * 1.8, string(points))

///

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