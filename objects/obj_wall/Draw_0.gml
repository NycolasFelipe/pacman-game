/// @desc adiciona cor

//Desenha si próprio
draw_self()

//Determina a velocidade de acordo com o level
if instance_exists(obj_player) var player_level = obj_player.player_level/2;
else var player_level = 3

//Diz se a funcionalidade de mudar de cor está ativada
var light_on = obj_controller.light_on
var alarm_off = alarm[0] == -1

if (light_on) {
	
	//Muda as cores da parede de fora
	if (wall_area = 0 and alarm_off) {
		var first_color = c_navy
		var second_color = c_red
	
		if (color != second_color) color = second_color;
		else if (color == second_color) color = first_color;
		
		//Aciona o alarme, que está funcionando somente como um contador de tempo
		alarm[0] = room_speed/player_level
	}
	
	//Muda as cores das paredes de dentro
	else if (wall_area = 1 and alarm_off) {
		var first_color = c_yellow
		var second_color = c_fuchsia
		var third_color = c_aqua
	
		if (color == c_red) color = first_color;
		else if (color == first_color) color = second_color;
		else if (color == second_color) color = third_color;
		else if (color == third_color) color = first_color;
		
		alarm[0] = room_speed/player_level
	}

	//Aplica a cor selecionada no efeito gerado pelo blendmode
	gpu_set_blendmode(bm_add)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha)
	gpu_set_blendmode(bm_normal)
}