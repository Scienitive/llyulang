spear_length++;
var spear_point = x + (spear_length * 16 * sign(image_xscale));

var enemy = instance_position(spear_point, y, o_enemy);
var inst_solid = instance_position(spear_point, y, o_solid);
var inst_wall = instance_position(spear_point, y, o_wall);
if (enemy != noone) {
	spear_point_inst = enemy;
	enemy.enemy_attack = false;
	enemy.enemy_attack_cooldown = enemy.enemy_attack_cooldown_max * 60;
	spear_point_type = "enemy";
	alarm[1] = 1;
}
else if (inst_solid != noone) {
	spear_point_inst = inst_solid;
	spear_point_type = "solid";
	alarm[1] = 1;
}
else if (inst_wall != noone) {
	spear_point_inst = inst_wall;
	spear_point_type = "wall";
	alarm[1] = 1;
}
else {
	if (spear_length != spear_length_max) {
		alarm[0] = spear_speed;
	}
	else {
		spear_length = 0;
		spear_active = false;
		spear_cooldown_counter = spear_cooldown * 60;
	}
}