if (y < -64) {
	instance_destroy(self);
}

var enemy = instance_place(x + hsp, y, o_enemy);
if (place_meeting(x + hsp, y , o_player) and !monster_killer) {
	if (o_player.dash_remains) {
		monster_killer = true;
		x = o_player.x + (sign(o_player.image_xscale) * 16);
		hsp = sign(o_player.image_xscale) * spd;
	}
	else {
		damage();
		instance_destroy(self);
	}
}
else if (enemy != noone and monster_killer) {
	instance_destroy(enemy);
	o_player.katman_basi_monster_kill_count++;
	instance_destroy(self);
}
else if (place_meeting(x + hsp, y, o_solid)) {
	instance_destroy(self);
}
else if (place_meeting(x + hsp, y, o_wall)) {
	instance_destroy(self);
}

x += hsp;