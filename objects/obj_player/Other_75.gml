var type = async_load[? "event_type"];
var index = async_load[? "pad_index"];

if (type == "gamepad discovered") show_debug_message("Controller Connected: " + string(index));
else show_debug_message("Controller Disconnected: " + string(index));
