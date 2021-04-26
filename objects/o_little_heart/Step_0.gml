if (y < -64) {
	instance_destroy(self);
}

vsp += grv;

if (place_meeting(x + hsp, y, o_solid) or place_meeting(x + hsp, y, o_wall)) {
	hsp = 0;
}

if (place_meeting(x, y + vsp, o_solid) or place_meeting(x, y + vsp, o_wall)) {
	while (!place_meeting(x, y + sign(vsp), o_solid) and !place_meeting(x, y + sign(vsp), o_wall)) {
		y += sign(vsp);
	}
	vsp = 0;
	hsp = 0;
}

if (place_meeting(x, y, o_player)) {
	if (o_player.hp < 3) {
		o_player.hp++;
	}
	instance_destroy(self);
}

x += hsp;
y += vsp;