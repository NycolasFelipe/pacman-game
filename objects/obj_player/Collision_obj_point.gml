//ADD POINT TO THE SCOREBOARD
obj_controller.points += 10;

//DESTROY THE POINT INSTANCE
with(other) instance_destroy();

//PLAYS SOUND EFFECT WHEN DESTROYED
var play_sound = obj_controller.play_sound;
if (play_sound) audio_play_sound(snd_point, 1, false);
