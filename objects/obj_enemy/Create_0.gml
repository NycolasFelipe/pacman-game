/// @desc inicia variáveis do inimigo

walk_speed = 1;		//padrão: 1
hunting_speed = 0;	//padrão: 0

vspeed = 0;
hspeed = walk_speed;


//Após ter visto o player, o inimigo entra temporariamente em modo de caça
hunting_mode = false;

//Tempo no modo de caça em segundos
hunting_time = 0;		//valor definido em check_level(), de acordo com o level atual do jogador

//Número que multiplica o map_grid e determina o quão longe o inimigo consegue ver o player
hunting_multiplier = 0;	//valor definido em check_level(), de acordo com o level atual do jogador

//Tamanho do grid do mapa. 32 é o equivalente à 1 "quadrado"
map_grid = 32			//padrão: 32

//Escolhe uma cor aleatória para o fantasma
sprite_index = choose(spr_enemy, spr_enemy_green, spr_enemy_red, spr_enemy_yellow);

//Variável de controle da área de spawn. Diz se o inimigo pode sair da área
leaving_area = false;


//Muda os valores dos atributos do inimigo de acordo com o level atual do jogador
check_level = function() {
	if (instance_exists(obj_player)) var player_level = obj_player.player_level;
	else var player_level = 1;
	
	//Valores iniciais dos inimigos, d - default
	var d_walk_speed = 1;
	var d_hunting_speed = 2;
	var d_hunting_time = 3;
	var d_hunting_multiplier = 3;
	
	switch(player_level) {
		case 1:
			walk_speed = d_walk_speed;
			hunting_speed = d_hunting_speed;
			hunting_time = d_hunting_time;
			hunting_multiplier = d_hunting_multiplier;
		break;
		
		case 2:
			walk_speed = d_walk_speed+1;
			hunting_speed = d_hunting_speed+1;
			hunting_time = d_hunting_time+1;
			hunting_multiplier = d_hunting_multiplier+1;
		break;
		
		case 3:
			hunting_time = d_hunting_time+2;
			hunting_multiplier = d_hunting_multiplier+2;
		break;
		
		case 4:
			walk_speed = d_walk_speed+1.6;
			hunting_speed = d_hunting_speed+1.6;
		break;
	}
}


//Método que checa colisão e muda a direção do sprite
check_collision = function() {
	//Checa se o inimigo está colidindo
	var colliding = place_meeting(x+hspeed, y+vspeed, obj_collision);
	
	//Controla a colisão e previne o inimigo de entrar na área do teleporte
	if (colliding) {
		hspeed *= -1;
		vspeed *= -1;
	}

	//Controla a direção do sprite
	if (hspeed != 0) image_xscale = sign(hspeed);
}


//Método para lidar com o movimento do inimigo
enemy_move = function() {
	//Muda os valores de movimento de acordo com o level
	check_level();
	
	//Se não estiver em modo de caça, se movimenta automaticamente
	if (!hunting_mode) {
		//Checando a colisão e a direção do sprite
		check_collision();
		
		//Controla o movimento automático do inimigo
		enemy_auto_move(walk_speed, map_grid);
		
		//Assim que o inimigo sair da área do spawn, sinaliza a variável de controle
		if (leaving_area) {
			leaving_area = false;
			//Inicial a movimentação automática
			hspeed = choose(walk_speed, -walk_speed);
		}
	}
	//Caso esteja em modo de caça, começa a perseguir o player
	else enemy_hunting(map_grid, hunting_speed);
	
	//Testa se o player pode ser visto pelo inimigo. Caso possa, ativa o modo de caça.
	enemy_seeing_player(id, map_grid, hunting_speed, hunting_mode, hunting_time, hunting_multiplier);
}