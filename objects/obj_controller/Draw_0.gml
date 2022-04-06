#region DRAWING THE POWERUPS
powerup_speed();
powerup_ghost();
powerup_invincible();
powerup_circle_duration();
#endregion

#region DRAWING WALL COLORS
if (light_on) draw_wall_color();
#endregion

#region DRAWING INTERFACE
draw_interface();
#endregion

#region DRAWING HIGHSCORE
var player_exists = instance_exists(obj_player);
if not(player_exists) draw_score();
#endregion
