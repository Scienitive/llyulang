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
	var player_dir = sign(o_player.x - x); // - ise sol + ise sağ
	var player_dist = o_player.x - x;
	if (abs(player_dist) > mesafe + 2) {
	if (place_meeting(x + (player_dir * 64), y + 1, o_solid) and !place_meeting(x + (player_dir * 32), y, o_enemy) and !place_meeting(x + (player_dir * 32), y, o_player)) {
			hsp = player_dir * spd;
			if (!enemy_attack) {
				sprite_index = enemy6_run;
			}
		}
		else {
			hsp = 0;
			if (!enemy_attack) {
				sprite_index = enemy6_idle;
			}
		}
	}
	else if (abs(player_dist) < mesafe - 2) {
		if (place_meeting(x + ((-player_dir) * 64), y + 1, o_solid) and !place_meeting(x + ((-player_dir) * 32), y, o_enemy) and !place_meeting(x + ((-player_dir) * 32), y, o_player)) {
			hsp = -player_dir * spd;
			if (!enemy_attack) {
				sprite_index = enemy6_run;
			}
		}
		else {
			hsp = 0;
			if (!enemy_attack) {
				sprite_index = enemy6_idle;
			}
		}
	}
	else {
		hsp = 0;
		if (!enemy_attack) {
			sprite_index = enemy6_idle;
		}
	}
	
	if (player_dist <= mesafe and !enemy_attack and enemy_attack_cooldown == 0) {
		enemy_attack = true;
		sprite_index = enemy6_attack;
	}
	
	if (enemy_attack) {
		if (floor(image_index) == 2) {
			var atk = instance_create_layer(x, y, "Instances", o_blaze_attack);
			atk.hsp = sign(image_xscale) * atk.spd
			enemy_attack = false;
			enemy_attack_cooldown = enemy_attack_cooldown_max;
		}
	}
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
	sprite_index = enemy6_idle;
}

x += hsp;
if (!(o_player.spear_active and o_player.spear_point_inst == id)) {
y += vsp;
}
}
else {
	sprite_index = enemy6_idle;
}