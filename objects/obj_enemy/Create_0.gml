/// @desc inicia variáveis do inimigo

walk_speed = 2
hunting_speed = 3

vspeed = 0
hspeed = walk_speed



//Após ter visto o player, o inimigo entra temporariamente em modo de caça
hunting_mode = false

//Tempo no modo de caça em segundos
hunting_time = 5

//Tamanho do grid do mapa. 32 é o equivalente à 1 "quadrado"
map_grid = 32

//Escolhe uma cor aleatória para o fantasma
sprite_index = choose(spr_enemy, spr_enemy_green, spr_enemy_red, spr_enemy_yellow)

//Variável de controle da área de spawn. Diz se o inimigo pode sair da área
leaving_area = false



//Método que checa colisão e muda a direção do sprite
check_collision = function() {
	//Checa se o player está colidindo
	var colliding = place_meeting(x+hspeed, y+vspeed, obj_collision)
	
	//Controla a colisão
	if (colliding) {
	hspeed *= -1
	vspeed *= -1
	}
	
	//Controla a direção do sprite
	if (hspeed != 0) image_xscale = sign(hspeed);
}



//Método para lidar com o movimento do inimigo
enemy_move = function() {
	//Se não estiver em modo de caça, se movimenta automaticamente
	if (!hunting_mode) {
		//Controla o movimento automático do inimigo
		enemy_auto_move(walk_speed);
		
		//Checando a colisão e a direção do sprite
		check_collision()
		
		//Assim que o inimigo sair da área do spawn, sinaliza a variável de controle
		if (leaving_area) {
			leaving_area = false
			//Inicial a movimentação automática
			hspeed = choose(walk_speed, -walk_speed)
		}
	}
	//Caso esteja em modo de caça, começa a perseguir o player
	else enemy_hunting(map_grid, hunting_speed)
	
	//Testa se o player pode ser visto pelo inimigo. Caso possa, ativa o modo de caça por 5s
	enemy_seeing_player(id, map_grid, hunting_speed, hunting_mode, hunting_time)
}