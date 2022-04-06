//SIZE VARIABLES AND MODE SETUP
w		= room_width;
h		= display_get_height()*1.15;
h_half	= h*0.5;

enum TRANSITION_MODE {
	OFF,
	INTRO,
	GOTO,
}

mode		= TRANSITION_MODE.INTRO;
percent		= 1;
percent_max	= 1.2;
target		= room;

transition_time = 0;


transition = function() {
	if (mode != TRANSITION_MODE.OFF) {
		if (mode == TRANSITION_MODE.INTRO) {
			percent = max(0, percent - max((percent/10), 0.01));
		}
		else {
			percent = min(percent_max, percent + max(((percent_max - percent)/10), 0.01));
		}
		
		if ((percent == percent_max && transition_time <= 0) || percent == 0) {
			switch (mode) {
				case TRANSITION_MODE.INTRO: 
					mode = TRANSITION_MODE.OFF;
				break;
					
				case TRANSITION_MODE.GOTO:
					mode = TRANSITION_MODE.INTRO;
					room_goto(target);
				break;
			}
		}
	}
}


draw_transition = function() {
	if (mode != TRANSITION_MODE.OFF) {
		draw_set_color(c_black);
		draw_rectangle(0, 0, w, h_half*percent, false);
		draw_rectangle(0, h, w, h-(h_half*percent), false);
		draw_set_color(-1);
	}
}
