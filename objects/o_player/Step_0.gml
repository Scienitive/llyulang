if (!dead and !win) {
	if (!spear_active and !place_meeting(x, y+1, o_solid)) {
		vsp += grv;
	}
	else {
		vsp = 0;
	}

	if (keyboard_check(vk_left) and !spear_active) {
		hsp = -player_speed;
		if (!sword_swing and !arrow_active and !dash_active) {
			sprite_index = player_run;
		}
		image_xscale = -default_x_scale;
	}
	if (keyboard_check(vk_right) and !spear_active) {
		hsp = player_speed;
		if (!sword_swing and !arrow_active and !dash_active) {
			sprite_index = player_run;
		}
		image_xscale = default_x_scale;
	}
	if (!keyboard_check(vk_left) and !keyboard_check(vk_right)) {
		hsp = 0;
		if (!sword_swing and !arrow_active and !dash_active) {
			sprite_index = player_idle;
		}
	}

	if (place_meeting(x, y+1, o_solid)) {
		jump_enable = 0;
	}
	else {
		jump_enable++;
	}
	jump_enable = clamp(jump_enable, 0, jump_forgive);

	if (keyboard_check_pressed(vk_up) and jump_enable < jump_forgive) {
		vsp -= jump_distance;
		jump_enable = jump_forgive;
	}

	if (keyboard_check_pressed(ord("D")) and !sword_swing and attack_cooldown_counter == 0) {
		sword_swing = true;
		sword_finisher = 0;
		sprite_index = player_sword;
		image_index = 0;
		attack_cooldown_counter = attack_cooldown * 60;
	}

	if ((keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down)) and !spear_active) {
		if (!place_meeting(x + ((image_xscale / default_x_scale) * dash_distance), y, o_solid) and dash_cooldown_counter == 0) {
			dash_active = true;
			dash_remains = true;
			alarm[4] = 8;
			dash_finisher = 0;
			sprite_index = player_dash;
			image_index = 0;
			dash_cooldown_counter = dash_cooldown * 60;
		}
	}

	if (keyboard_check_pressed(ord("A")) and arrow_cooldown_counter == 0 and !spear_active) {
		arrow_active = true;
		arrow_dir = sign(image_xscale);
		sprite_index = player_magic;
		image_index = 0;
		arrow_finisher = 0;
	}

	if (keyboard_check_pressed(ord("W")) and spear_cooldown_counter == 0 and !spear_active) {
		spear_active = true;
		spear_length = 3;
		alarm[0] = spear_speed;
		hsp = 0;
	}

	if (sword_swing) {
		if (floor(image_index) == 0) {
			if (sword_finisher == 1) {
				var enemy_ahead = instance_place(x + (sign(image_xscale) * 32), y, o_enemy);
				var inst_cobweb_list = ds_list_create();
				var inst_cobweb_count = instance_place_list(x + (sign(image_xscale) * 16), y, o_cobweb, inst_cobweb_list, false);
				if (enemy_ahead != noone and object_get_name(enemy_ahead.object_index) == "o_enemy1") {
					if (sign(image_xscale) == sign(enemy_ahead.image_xscale)) {
						enemy_ahead.stunned = true;
						enemy_ahead.stun_timer = enemy_ahead.stun_max * 60
					}
					else {
						enemy_ahead.killed = true;
						katman_basi_monster_kill_count++;
						global.scr += enemy_ahead.scr;
					}
				}
				else if (enemy_ahead != noone) {
					enemy_ahead.killed = true;
					katman_basi_monster_kill_count++;
					global.scr += enemy_ahead.scr;
				}
				else if (inst_cobweb_count > 0) {
					var i = 0;
					repeat (inst_cobweb_count) {
						instance_destroy(inst_cobweb_list[| i]);
						i++;
					}
				}
				sword_swing = false;
				sprite_index = player_idle;
				ds_list_destroy(inst_cobweb_list);
			}
			else {
				sword_finisher = 1;
				image_index++;
			}
		}
	}
	if (arrow_active) {
		if (floor(image_index) == 0) {
			if (arrow_finisher == 1) {
				var mgc = instance_create_layer(x + ((image_xscale / default_x_scale) * 8), y, "Instances", o_magic);
				mgc.image_xscale = arrow_dir;
				arrow_cooldown_counter = arrow_cooldown * 60;
				arrow_active = false;
			}
			else {
				arrow_finisher = 1;
				image_index++;
			}
		}
	}
	if (dash_active) {
		if (!place_meeting(x + sign(image_xscale) * dash_distance / 6, y, o_solid) and !place_meeting(x + sign(image_xscale) * dash_distance / 6, y, o_wall)) {
			x += sign(image_xscale) * dash_distance / 6;
			dash_finisher += dash_distance / 6;
			if (dash_finisher == dash_distance) {
				dash_active = false;
				sprite_index = player_idle;
			}
		}
		else {
			dash_active = false;
			sprite_index = player_idle;
		}
	}

	// Cooldowns
	if (attack_cooldown_counter != 0) {
		attack_cooldown_counter--;
	}
	if (dash_cooldown_counter != 0) {
		dash_cooldown_counter--;
	}
	if (arrow_cooldown_counter != 0) {
		arrow_cooldown_counter--;
	}
	if (spear_cooldown_counter != 0) {
		spear_cooldown_counter--;
	}


	// Collisions
	if (place_meeting(x + hsp, y, o_wall)) {
		while (!place_meeting(x + sign(hsp), y, o_wall)) {
			x += sign(hsp);
		}
		hsp = 0;
	}
	if (place_meeting(x + hsp, y, o_solid)) {
		while (!place_meeting(x + sign(hsp), y, o_solid)) {
			x += sign(hsp);
		}
		hsp = 0;
	}
	if (place_meeting(x, y + vsp, o_solid) and !spear_active) {
		while (!place_meeting(x, y + sign(vsp), o_solid)) {
			y += sign(vsp);
		}
		vsp = 0;
	}

	if (place_meeting(x, y, o_cobweb)) {
		player_speed = o_cobweb.spd_decrease_to;
	}
	else {
		player_speed = player_speed_max;
	}
	
	if (place_meeting(x, y+1, o_winblock)) {
		win = true;
	}

	if (!roll_set and y > 336) {
		if (global.mode == "HARD") {
			global.roll_speed = 1;
		}
		else if (global.mode == "EXPERT") {
			global.roll_speed = 2;
		}
		roll_set = true;
	}

	if (y < 32) {
		hp = 0;
	}

	if (y > vertical_pos) {
		vertical_pos += 192;
		var ktmn_lvl = katman_level;
		if (ktmn_lvl == 4) {ktmn_lvl = 3;}
		global.scr += step_scr[ktmn_lvl];
		your_horizontal++;
		katman_basi_monster_kill_count = 0;
	}

	if (hp == 0) {
		global.roll_speed = 0;
		timer_active = false;
		dead = true;
	}

	if (keyboard_check_pressed(ord("R"))) {
		if (global.mode == "HARD") {
			var snd = winter_hard;
		}
		else if (global.mode == "EXPERT") {
			var snd = winter_imposter;
		}
		audio_stop_sound(snd);
		room_restart();
	}
	
	if (timer_active) {
		timer++;
	}

	x += hsp;
	if (!spear_active) {
		y += vsp;
	}

	if (global.roll_speed > 0) {
		y -= global.roll_speed;
		if (instance_exists(o_enemy)) {
			with (o_enemy) {
				y -= global.roll_speed;
				if (object_index == o_enemy2) {
					default_y -= global.roll_speed
				}
			}
		}
		if (instance_exists(o_solid)) {
			with (o_solid) {
				y -= global.roll_speed;
			}
		}
		if (instance_exists(o_magic)) {
			with (o_magic) {
				y -= global.roll_speed;
			}
		}
		if (instance_exists(o_projectile)) {
			with (o_projectile) {
				y -= global.roll_speed;
			}
		}
		if (instance_exists(o_little_heart)) {
			with (o_little_heart) {
				y -= global.roll_speed;
			}
		}
		if (instruction_slide < 320) {
			instruction_slide += global.roll_speed;
		}
		vertical_pos -= global.roll_speed;
	}

	// Creating New Blocks
	var create = false;
	with (o_solid) {
		if (y == 592) {
			create = true;
			break;
		}
	}

	if (create and katman_level <= 3) {
		var empty_block = irandom_range(0, 26);
		var perc = irandom_range(0, 9);
		if (perc < 3) {
			var monster_spawn_count = 1;
		}
		else if (perc < 8) {
			var monster_spawn_count = 2;
		}
		else {
			var monster_spawn_count = 3;
		}
		var i = 0;
		repeat (30) {
			if ((empty_block - i > 0 or empty_block - i < -3)) {
				instance_create_layer(16 + (i * 32), 784, "Instances", katman_block[katman_level]);
			}
			else {
				var block = instance_create_layer(16 + (i * 32), 784, "Instances", katman_block[katman_level]);
				block.breakable = true;
				block.image_index = 1;
				block.sira = horizontal_count + (katman_level * katman_gecis_max);
			}
			i++;
		}
		var i = 0;
		var spawn_places = [];
		repeat (monster_spawn_count) {
			do {
				var match = false
				var spawn_block = irandom_range(1, 28);
				if (spawn_block - empty_block <= 4 and spawn_block - empty_block >= -1) {
					match = true;
				}
				var j = 0;
				repeat (i) {
					if (abs(spawn_block - spawn_places[j]) <= 1) {
						match = true;
						break;
					}
					j++;
				}
			} until (match == false);
			spawn_places[i] = spawn_block;
		
			var monster_type = irandom_range(0, array_length(katman_monsters[katman_level]) - 1);
			var monst = instance_create_layer(16 + (spawn_block * 32), 744, "Instances", katman_monsters[katman_level][monster_type]);
			if (monst.default_x_scale == 4) {monst.y -= 8;}
			if (object_get_name(monst.object_index) == "o_enemy2") {monst.y -= 48; monst.default_y = monst.y;}
			monst.image_xscale *= monst.default_x_scale;
			monst.image_yscale *= monst.default_x_scale;
			i++;
		}
		horizontal_count++;
		if (horizontal_count >= katman_gecis_max) {
			katman_level++;
			horizontal_count = 0;
		}
		array_push(katman_basi_monster, monster_spawn_count);
	}
	else if (create) {
		var i = 0;
		repeat (30) {
			instance_create_layer(16 + (i * 32), 784, "Instances", o_winblock);
			i++;
		}
		alarm[3] = 161;
	}

	// Bug Fix
	var inst_solid = instance_place(x, y, o_solid);
	if (inst_solid != noone) {
		if (inst_solid.x - x < 0) {
			while (place_meeting(x,y,inst_solid)) {
				x++;
			}
		}
		else if (inst_solid.x - x > 0) {
			while (place_meeting(x,y,inst_solid)) {
				x--;
			}
		}
	}

	// Kapi Acilis
	if (your_horizontal < array_length(katman_basi_monster)) {
		if (katman_basi_monster_kill_count == katman_basi_monster[your_horizontal]) {
			with (o_solid) {
				if (sira == other.your_horizontal and breakable) {
					breaking = true;
				}
			}
		}
	}
	
	if (y >= 676) {
		dead = true;
	}
}
else if (dead) {
	sprite_index = player_dead;
	if (floor(image_index == 4)) {
		image_speed = 0;
	}
}
else if (win) {
	
}