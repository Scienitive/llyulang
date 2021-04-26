event_inherited();
if (!o_player.dead and !o_player.win) {
if ((x + hsp > max_x) or (x + hsp < min_x)) {
	hsp *= -1;
}
if ((y + vsp > default_y + sapma_y) or (y + vsp < default_y - sapma_y)) {
	vsp *= -1;
}

if (-128 < (y - o_player.y) and (y - o_player.y) < 128) {
	enemy_active = true;
}
else {
	enemy_active = false;
	enemy_attack = false;
	enemy_attack_cooldown = enemy_attack_cooldown_max/2;
}
if (enemy_active) {
	
	if (!enemy_attack and enemy_attack_cooldown == 0) {
		enemy_attack = true;
		image_index++;
		image_speed = 1;
	}
	
	if (enemy_attack) {
		if (floor(image_index) == 0) {
			var len = point_direction(x, y, o_player.x, o_player.y);
			var atk = instance_create_layer(x, y, "Instances", o_skeleton_attack);
			atk.hsp = dcos(len) * atk.spd
			atk.vsp = dsin(len) * -atk.spd
			image_speed = 0;
			enemy_attack = false;
			enemy_attack_cooldown = enemy_attack_cooldown_max;
		}
	}
}

if (enemy_attack_cooldown > 0) {
	enemy_attack_cooldown--;
}

if (o_player.x - x > turn_spd) {
	image_xscale = -default_x_scale;
}
else if (o_player.x - x < -turn_spd) {
	image_xscale = +default_x_scale;
}

if (blood_timer > 8) {
	instance_destroy(self)
}
if (killed) {
	blood_timer++;
	enemy_attack = false;
	image_speed = 0;
}

x += hsp;
y+= vsp;
}
else {
	image_speed = 0;
	image_index = 0;
}