/// @desc animação de teleporte

show_message("ok")


//Cancela a caça quando usar o portal
if (instance_exists(obj_enemy)) obj_enemy.hunting_mode = false;
