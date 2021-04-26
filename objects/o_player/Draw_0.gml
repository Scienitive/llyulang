draw_set_font(f_coolvetica_little);
draw_set_halign(fa_left);
draw_set_color(c_black);
// Instructions
if (instruction_slide < 320) {
	draw_sprite(inst1, 0, 96, 160 - instruction_slide);
	draw_sprite(inst2, 0, 400, 96 - instruction_slide);
	draw_sprite(inst3, 0, 400, 224 - instruction_slide);
	draw_sprite(inst4, 0, 700, 96 - instruction_slide);
	draw_sprite(inst5, 0, 700, 224 - instruction_slide);
}

var i = 0;
repeat (3) {
	if ((o_player.hp - i) > 0) {
		var hrt = 0;
	}
	else {
		var hrt = 1;
	}
	draw_sprite_ext(heart, hrt, 32 + (i * 32), 48, 2, 2, 0, c_white, 1);
	i++;
}

draw_text(680, 48, global.scr);

if (attack_cooldown_counter == 0) {
	var subimg = 0;
}
else {
	var subimg = 1;
}
draw_sprite_ext(x_cooldown, subimg, 224, 48, 3, 3, 0, c_white, 1);

if (dash_cooldown_counter == 0) {
	var subimg = 0;
}
else {
	var subimg = 1;
}
draw_sprite_ext(c_cooldown, subimg, 288, 48, 3, 3, 0, c_white, 1);

if (arrow_cooldown_counter == 0) {
	var subimg = 0;
}
else {
	var subimg = 1;
}
draw_sprite_ext(z_cooldown, subimg, 160, 48, 3, 3, 0, c_white, 1);

if (spear_cooldown_counter == 0) {
	var subimg = 0;
}
else {
	var subimg = 1;
}
draw_sprite_ext(v_cooldown, subimg, 352, 48, 3, 3, 0, c_white, 1);

draw_self();

if (spear_active) {
	var spear_point = x + (spear_length * 16 * sign(image_xscale));
	draw_point_color(spear_point, y, c_red);
	var i = 0;
	repeat (spear_length) {
		if (i == 0) {
			draw_sprite_ext(spear, 0, x + (sign(image_xscale) * 8 + (i * 16 * sign(image_xscale))), y, sign(image_xscale), 1, 0, c_white, 1);
		}
		else if (i == spear_length - 1) {
			draw_sprite_ext(spear, 2, x + (sign(image_xscale) * 8 + (i * 16 * sign(image_xscale))), y, sign(image_xscale), 1, 0, c_white, 1);
		}
		else {
			draw_sprite_ext(spear, 1, x + (sign(image_xscale) * 8 + (i * 16 * sign(image_xscale))), y, sign(image_xscale), 1, 0, c_white, 1);
		}
		i++;
	}
}

var i = 0;
repeat (30) {
	draw_sprite_ext(spike, 0, 16 + (i * 32), 16, 4, 4, 0, c_white, 1);
	i++;
}