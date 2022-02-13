// @desc DEBUG

draw_self()

if (obj_dev_test.dev_mode) {
	//Define a cor a ser utilizada
	draw_set_color(c_yellow)

	//Distância que o inimigo pode ver o player
	var distance = map_grid * hunting_multiplier

	//Iniciando variáveis
	var moving_x = hspeed != 0
	var moving_y = vspeed != 0
	
	var x_pos = x
	var y_pos = y

	if (moving_x) x_pos = x-sign(hspeed)*(sprite_get_width(spr_enemy)/2)
	if (moving_y) y_pos = y-sign(vspeed)*(sprite_get_height(spr_enemy)/2)


	//Checando acima e abaixo, com o valor inicial de x relacionado à direção do movimento horizontal
	//var colliding_player_down
	draw_line(x_pos, y, x_pos, y+distance)

	//var colliding_player_up
	draw_line(x_pos, y, x_pos, y-distance)


	//Checando acima e abaixo, com o valor inicial de y relacionado à direção do movimento vertical
	//var colliding_player_right
	draw_line(x, y_pos, x+distance, y_pos)

	//var colliding_player_left
	draw_line(x, y_pos, x-distance, y_pos)

	//Reseta a cor
	draw_set_color(-1)
}