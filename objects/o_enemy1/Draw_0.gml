draw_self();
if (killed) {
	draw_sprite_ext(blood, floor(blood_timer/2), x, y, 2, 2, 0, c_white, 1);
}

if (stunned) {
	draw_sprite_ext(stun, 0, x, y - 48, 2, 2, 0, c_white, 1);
}