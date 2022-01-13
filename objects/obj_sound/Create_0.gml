//Flag de controle do som
music_playing = false


//Inicia o ícone com o index correto
image_index = 1


//Controla o sprite quando o mouse passa por cima do ícone
///@method mouse_hover(scale)
mouse_hover = function(_scale) {
	image_xscale = _scale
	image_yscale = _scale
}


//Controla o comportamento geral do áudio e da aparência do ícone
sound_control = function() {
	//Controla se os efeitos sonoros e música estão sendo tocados
	if (music_playing) { //padrão: false
		obj_controller.play_sound = false
		obj_controller.play_music = false
	
		music_playing = false
	}
	else {
		obj_controller.play_sound = true
		obj_controller.play_music = true
	
		music_playing = true
	}
	
	//Controla a música de fundo e imagem do ícone
	if (obj_controller.play_music) {
		audio_play_sound(snd_background_music, 1, true)
		image_index = 0
	}
	else {
		audio_stop_sound(snd_background_music);
		image_index = 1
	}
}