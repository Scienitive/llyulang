if (position_meeting(mouse_x, mouse_y, self)) {
	image_index = 0;
}
else {
	image_index = 1;
}

if (image_index == 0 and mouse_check_button_pressed(mb_left)) {
	if (str == "PLAY") {
		str = "HARD";
		var a = id
		with (o_button) {
			if (id != a) {
				str = "EXPERT";
			}
		}
	}
	else if (str == "EXIT") {
		game_end();
	}
	else if (str == "HARD") {
		global.mode = str;
		room_goto(asset_get_index("r_game"));
	}
	else if (str == "EXPERT") {
		global.mode = str;
		room_goto(asset_get_index("r_game"));
	}
}