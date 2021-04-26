if (y < -64) {
	instance_destroy(self);
}

var enemy = instance_place(x + hsp, y, o_enemy);
if (enemy != noone) {
	if (object_get_name(enemy.object_index) == "o_enemy1") {
		if (sign(image_xscale) == sign(enemy.image_xscale)) {
			enemy.stunned = true;
			enemy.stun_timer = enemy.stun_max * 60
			instance_destroy(self);
		}
		else {
			enemy.killed = true;
			o_player.katman_basi_monster_kill_count++;
			global.scr += enemy.scr;
			instance_destroy(self);
		}
	}
	else {
		enemy.killed = true;
		o_player.katman_basi_monster_kill_count++;
		global.scr += enemy.scr;
		instance_destroy(self);
	}
}
else if (place_meeting(x + hsp, y, o_solid)) {
	while (!place_meeting(x + hsp, y, o_solid)) {
		x += sign(hsp);
	}
	instance_destroy(self);
}
else if (place_meeting(x + hsp, y, o_wall)) {
	while (!place_meeting(x + hsp, y, o_wall)) {
		x += sign(hsp);
	}
	instance_destroy(self);
}

x += hsp;