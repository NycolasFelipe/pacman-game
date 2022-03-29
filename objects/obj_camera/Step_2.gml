SCALE = 1080/display_get_width();
camera_width = 1920*SCALE;
camera_height = 1080*SCALE;
camera_set_view_size(view_camera[0], camera_width, camera_height);

surface_resize(application_surface, camera_width, camera_height);

half_view_width = camera_get_view_width(view_camera[0])/2;
half_view_height = camera_get_view_height(view_camera[0])/2;

camera_set_view_pos(view_camera[0], x-half_view_width, y-half_view_height);