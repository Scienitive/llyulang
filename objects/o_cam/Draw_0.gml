draw_set_font(f_middle_little)
draw_set_halign(fa_center);
draw_set_color(c_white);

if (o_player.dead) {
	draw_sprite_ext(black, 0, 480, 320, 1, 1, 0, c_white, a);
}
else if (o_player.win) {
	draw_sprite_ext(black, 0, 480, 320, 1, 1, 0, c_white, b);
}

if (a >= 1) {
	draw_text(480, 128, "YOU LOST! - SCORE: " + string(global.scr));
	draw_text(480, 232, "PRESS \"R\" TO RESTART");
	draw_text(480, 300, "PRESS \"ESC\" TO EXIT");
	draw_text(480, 432, "LLYULANG ZAI WAI BIEN!");
}

if (b >= 1) {
	draw_text(480, 128, "YOU WIN! - SCORE: " + string(global.scr));
	draw_text(480, 232, "PRESS \"R\" TO RESTART");
	draw_text(480, 300, "PRESS \"ESC\" TO EXIT");
	draw_text(480, 432, "LLYULANG ZAI WAI BIEN!");
}

if (dmg) {
	draw_sprite_ext(red, 0, 480, 320, 1, 1, 0, c_white, c);
}