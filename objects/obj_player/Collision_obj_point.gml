/// @desc destrói o objeto

//Adiciona um ponto ao placar
obj_controller.points += 10


//Destrói a instância do ponto
with(other) instance_destroy();

//Toca o efeito sonoro ao ser destruído
var play_sound = obj_controller.play_music
if (play_sound) audio_play_sound(snd_point, 1, false);
