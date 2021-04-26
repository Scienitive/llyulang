if (o_player.dead and a < 1) {
	a += 0.005;
}
if (o_player.win and b < 1) {
	b += 0.005;
}

if (o_player.dead) {
	if (global.mode == "HARD") {
		var snd = winter_hard;
	}
	else if (global.mode == "EXPERT") {
		var snd = winter_imposter;
	}
	audio_sound_gain(snd, 0, 1000);
}

if ((o_player.dead or o_player.win) and keyboard_check_pressed(vk_escape)) {
	room_goto(asset_get_index("r_menu"));
}
else if ((o_player.dead or o_player.win) and keyboard_check_pressed(ord("R"))) {
	if (global.mode == "HARD") {
		var snd = winter_hard;
		var k = 0.05;
	}
	else if (global.mode == "EXPERT") {
		var snd = winter_imposter;
		var k = 0.1;
	}
	audio_stop_sound(snd);
	audio_sound_gain(snd, k, 1);
	room_restart();
}

if (dmg) {
	if (back) {
		c -= 0.025;
	}
	else {
		c += 0.025;
	}
	if (c >= 0.3) {
		back = true;
	}
	if (c <= 0 and back) {
		dmg = false;
		back = false;
		c = 0;
	}
}