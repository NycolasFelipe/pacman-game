// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_sound_manager() {
	var save_data = array_create(0);
	
	//FOR EVERY INSTANCE, CREATE A STRUCT AND ADD IT TO THE ARRAY
	with (obj_sound_manager) {
		var save_entity = {
			AUDIO_VOLUME:	round(AUDIO_CONTROL_y-AUDIO_SLIDE_y),
			MUSIC_VOLUME:	round(MUSIC_CONTROL_y-MUSIC_SLIDE_y),
			EFFECTS_VOLUME:	round(EFFECTS_CONTROL_y-EFFECTS_SLIDE_y),
		}
		
		array_push(save_data, save_entity);
	}
	
	//TURN ALL THIS DATA INTO A JSON STRING AND SAVE IT VIA A BUFFER
	var string_data = json_stringify(save_data);
	var buffer = buffer_create(string_byte_length(string_data)+1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, string_data);
	buffer_save(buffer, "settings_sound.save");
	buffer_delete(buffer);
}

function load_sound_manager() {
	if (file_exists("settings_sound.save")) {
		var buffer = buffer_load("settings_sound.save");
		var string_data = buffer_read(buffer, buffer_string);
		buffer_delete(buffer);
	
		var load_data = json_parse(string_data);
		var load_entity = array_pop(load_data);
	
		with (obj_sound_manager) {
			AUDIO_CONTROL_y		= AUDIO_SLIDE_y+load_entity.AUDIO_VOLUME;
			MUSIC_CONTROL_y		= MUSIC_SLIDE_y+load_entity.MUSIC_VOLUME;
			EFFECTS_CONTROL_y	= EFFECTS_SLIDE_y+load_entity.EFFECTS_VOLUME;
		}
	}
} 
	
	
function save_fullscreen() {
	var save_data = array_create(0);
	
	//FOR EVERY INSTANCE, CREATE A STRUCT AND ADD IT TO THE ARRAY
	with (obj_start_controller) {
		var save_entity = {fullscreen_index: fullscreen_index};
		array_push(save_data, save_entity);
	}
	
	//TURN ALL THIS DATA INTO A JSON STRING AND SAVE IT VIA A BUFFER
	var string_data = json_stringify(save_data);
	var buffer = buffer_create(string_byte_length(string_data)+1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, string_data);
	buffer_save(buffer, "settings_fullscreen.save");
	buffer_delete(buffer);
}

function load_fullscreen() {
	if (file_exists("settings_fullscreen.save")) {
		var buffer = buffer_load("settings_fullscreen.save");
		var string_data = buffer_read(buffer, buffer_string);
		buffer_delete(buffer);
	
		var load_data = json_parse(string_data);
		var load_entity = array_pop(load_data);
	
		with (obj_start_controller) {
			fullscreen_index = load_entity.fullscreen_index;
			
			if (fullscreen_index == 1) window_set_fullscreen(true);
			else window_set_fullscreen(false);
		}
	}
}


function save_high_scores() {
	//FOR EVERY INSTANCE, CREATE A STRUCT AND ADD IT TO THE ARRAY
	with (obj_controller) {
		var save_entity = round(points);
		var high_scores_length = array_length(obj_controller.high_scores_values);
		
		if (save_entity >= obj_controller.high_scores_values[high_scores_length-1]) {
			array_insert(obj_controller.high_scores_values, 0, save_entity);
			array_sort(obj_controller.high_scores_values, false);
			array_pop(high_scores_values);
		}
	}
	
	//TURN ALL THIS DATA INTO A JSON STRING AND SAVE IT VIA A BUFFER
	var string_data	= json_stringify(obj_controller.high_scores_values);
	var buffer = buffer_create(string_byte_length(string_data)+1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, string_data);
	buffer_save(buffer, "high_scores.save");
	buffer_delete(buffer);
}

function load_high_scores() {
	if (file_exists("high_scores.save")) {
		var buffer = buffer_load("high_scores.save");
		var string_data = buffer_read(buffer, buffer_string);
		buffer_delete(buffer);
	
		var load_data = json_parse(string_data);
		
		for (var i = 0; i < array_length(load_data); i++) {
			var load_entity = load_data[i];
			array_push(obj_controller.high_scores_values, load_entity);
		}
	}
}
