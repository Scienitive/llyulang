player_speed = 6;
player_speed_max = 6;
hsp = 0;
vsp = 0;
grv = 1;
global.scr = 0;
jump_enable = 0;
jump_forgive = 6;
jump_distance = 13;
default_x_scale = 2;
sword_swing = false;
sword_finisher = 0;
hp = 3;
dead = false;
win = false;
dash_distance = 64;
attack_cooldown = 0.3;
attack_cooldown_counter = 0;
dash_cooldown = 2;
dash_cooldown_counter = 0;
dash_active = false;
dash_remains = false;
dash_finisher = 0;
arrow_dir = 0;
arrow_cooldown = 4;
arrow_cooldown_counter = 0;
arrow_active = false;
arrow_finisher = 0;

spear_active = false;
spear_length = 0;
spear_length_max = 24;
spear_cooldown = 3;
spear_cooldown_counter = 0;
spear_speed = 1;
spear_slide_speed = 8;
spear_point_inst = noone;
spear_point_type = "";

timer = 0;
timer_active = true;

global.roll_speed = 0;
roll_set = false;
instruction_slide = 0;
randomize();

vertical_pos = 336;
step_scr = [400, 600, 1000, 1600];
katman_block = [o_grass, o_stone, o_cave, o_nether];
katman_monsters = [
	[o_enemy1, o_enemy4],
	[o_enemy2, o_enemy3, o_enemy1],
	[o_enemy7, o_enemy8, o_enemy2],
	[o_enemy5, o_enemy6, o_enemy8]
];
katman_level = 0;
katman_basi_monster = [0, 1, 2];
katman_basi_monster_kill_count = 0;
horizontal_count = 3;
your_horizontal = 0;
katman_gecis_max = 16; // Katman başı satır sayısı

if (global.mode == "HARD") {
	audio_play_sound(winter_hard, 1, 1);
}
else if (global.mode == "EXPERT") {
	audio_play_sound(winter_imposter, 1, 1);
}