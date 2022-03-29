function create_points(){
	//Posição inicial do objeto point
	var point_x = 480;
	var point_y = 144;

	//Posição final do objeto point
	var point_x_limit = 1500;
	var point_y_limit = 900;

	//Posição temporária do objeto ponto
	var temp_x = point_x;
	var temp_y = point_y;

	//Altura e largura do mapa
	var map_width = point_x_limit - point_x;
	var map_height = point_y_limit - point_y;

	//Grid size
	var map_grid = 32;
	
	//Cria os pontos
	repeat((map_height * map_width) / map_grid) {
		
		//Enquanto a posição temporária de x não estiver chegado ao valor limite
		//de x (o lado direito do mapa), continua criando instâncias dos pontos
		if (temp_x <= point_x_limit && temp_y <= point_y_limit) {
			instance_create_layer(temp_x, temp_y, "points", obj_point);
			temp_x += map_grid;
		}
		//Caso x tenha chegado ao limite, retorna ele ao valor inicial, e desce com
		//o valor de y, e repete o processo até que y chegue ao valor limite vertical
		else {
			temp_x = point_x;
			temp_y += map_grid;
		}
	}
	
	
	//Bloco responsável por destruir a instância caso ela colida com a parede ou a
	//safe_area
	with (obj_point) {
		//Retorna se o objeto point está colidindo com a parede
		//ou com a safe area
		var colliding_wall = place_meeting(x, y, obj_collision);
		var colliding_safe_area = place_meeting(x, y, obj_safe_area);
		var colliding_powerup = place_meeting(x, y, obj_powerup_spawn);
		var colliding = colliding_wall || colliding_safe_area || colliding_powerup;
		
		//Se estiver colidindo, a instância é destruída
		if (colliding) instance_destroy(id);
	}
}