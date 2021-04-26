event_inherited();

if (!o_player.dead and !o_player.win) {
if (o_player.spear_active and o_player.spear_point_inst == id) {
	vsp = 0;
}
else {
	vsp += grv;
}


if (-140 < (y - o_player.y) and (y - o_player.y) < 162) {
	enemy_active = true;
}
else {
	enemy_active = false;
	hsp = 0;
	enemy_attack = false;
	enemy_attack_cooldown = enemy_attack_cooldown_max/4;
}

if (enemy_active) {
	var player_dist = o_player.x - x;
	if (abs(player_dist) < mesafe and !enemy_attack and enemy_attack_cooldown == 0 and !enemy_activator) {
		enemy_activator = true;
		image_index = 1;
		alarm[0] = 60;
	}
	
	if (enemy_attack) {
		if (place_meeting(x + hsp, y + vsp, o_player)) {
			if (o_player.dash_active) {
				hsp *= -1;
				enemy_attack = false;
				enemy_attack_cooldown = enemy_attack_cooldown_max;
				grv = 1;
			}
			else if (o_player.sword_swing) {
				instance_destroy(self);
				o_player.katman_basi_monster_kill_count++;
			}
			else {
				damage();
				instance_destroy(self);
				o_player.katman_basi_monster_kill_count++;
			}
		}
		else if (place_meeting(x + hsp, y, o_wall) or place_meeting(x + hsp, y, o_solid)) {
			hsp = 0;
			enemy_attack = false;
			enemy_attack_cooldown = enemy_attack_cooldown_max;
			grv = 1;
			image_index = 0;
		}
		
		if (place_meeting(x, y+1, o_solid) and vsp <= 1 and vsp > 0) {
			hsp /= frict;
			if (abs(hsp) < 1) {
				hsp = 0;
				enemy_attack = false;
				enemy_attack_cooldown = enemy_attack_cooldown_max;
				grv = 1;
				image_index = 0;
			}
		}
	}
}

if (place_meeting(x + hsp, y, o_wall) or place_meeting(x + hsp, y, o_solid)) {
	hsp = 0;
}

if (place_meeting(x, y + vsp, o_solid) and !(o_player.spear_active and o_player.spear_point_inst == id)) {
	while (!place_meeting(x, y + sign(vsp), o_solid)) {
		y += sign(vsp);
	}
	vsp = 0;
}

if (enemy_attack_cooldown > 0) {
	enemy_attack_cooldown--;
}

if (o_player.x - x > turn_spd) {
	image_xscale = default_x_scale;
}
else if (o_player.x - x < -turn_spd) {
	image_xscale = -default_x_scale;
}

if (blood_timer > 8) {
	instance_destroy(self)
}
if (killed) {
	blood_timer++;
	enemy_attack = false;
	image_speed = 0;
	image_index = 0;
}

x += hsp;
if (!(o_player.spear_active and o_player.spear_point_inst == id)) {
	y += vsp;
}
}
else {
	image_speed = 0;
	image_index = 0;
}
