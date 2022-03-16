function enemy_spawn_behavior(_id, _walk_speed, _leaving_area, _map_grid){
	//Checa se o inimigo está colidindo com a parede
	var colliding = place_meeting(x+hspeed, y+vspeed, obj_collision)
	
	//Checa a transparência do cadeado
	var padlock_index = obj_padlock.image_index
	var padlock_x = obj_padlock.x
	
	//Posição y final da animação
	var y_out = 432
	
	//Controla o comportamento do inimigo de saída da área de spawn
	if (_leaving_area) {
		//Velocidade de aproximação da função lerp, que dá o efeito de animação
		var animation_speed = 0.15
		
		//Interrompe a movimentação vertical para iniciar a animação
		vspeed = 0
		
		//Muda a direção da sprite para que aponte no sentido da animação
		image_xscale = 1
		
		//Aproxima o x do inimigo do x do cadeado, para que fique centralizado à saída
		x = lerp(x, padlock_x, animation_speed)
		
		//Assim que o x do inimigo se aproximar o suficente do centro, inicia a animação vertical
		if (padlock_x-1 <= x and x <= padlock_x+1) {
			y = lerp(y, y_out, animation_speed/2)
			
			//Retorna a imagem cadeado ao seu index inicial
			obj_padlock.image_index = 0
		}
	}
	
	//Controla o movimento do inimigo dentro da área do spawn
	else if (colliding and hspeed > 0) {
		hspeed = 0
		vspeed = _walk_speed
	}
	else if (colliding and vspeed > 0) {
		vspeed = 0
		hspeed = -_walk_speed
	}
	else if (colliding and hspeed < 0) {
		hspeed = 0
		vspeed = -_walk_speed
	}
	else if (colliding and vspeed < 0) {
		//Se estiver se movendo para cima e o cadeado estiver apagado,
		//Inicia a animação de saída do inimigo
		if (padlock_index != 0) _id.leaving_area = true
		else {
			hspeed = _walk_speed
			vspeed = 0
		}
	}

	//Controla a direção do sprite
	if (hspeed != 0) image_xscale = sign(hspeed)
}