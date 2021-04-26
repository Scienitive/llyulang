if (spear_point_type == "enemy") {
	var distance = abs(x - spear_point_inst.x);
	if (distance > 48) {
		if (place_meeting(x + (sign(image_xscale) * spear_slide_speed), y, o_solid) or place_meeting(x + (sign(image_xscale) * spear_slide_speed), y, o_wall)) {
			spear_length = 0;
			spear_active = false;
			spear_cooldown_counter = spear_cooldown * 60;
		}
		else {
			x += sign(image_xscale) * spear_slide_speed;
			spear_point_inst.x += -sign(image_xscale) * spear_slide_speed;
			spear_length--;
			alarm[1] = 1;
		}
	}
	else {
		spear_length = 0;
		spear_active = false;
		spear_cooldown_counter = spear_cooldown * 60;
	}
}
else if (spear_point_type == "wall" or spear_point_type == "solid") {
	var distance = abs(x - spear_point_inst.x);
	if (distance > 48) {
		if (place_meeting(x + (sign(image_xscale) * spear_slide_speed * 2), y, o_solid) or place_meeting(x + (sign(image_xscale) * spear_slide_speed * 2), y, o_wall)) {
			spear_length = 0;
			spear_active = false;
			spear_cooldown_counter = spear_cooldown * 60;
		}
		else {
			x += sign(image_xscale) * spear_slide_speed * 2;
			spear_length--;
			alarm[1] = 1;
		}
	}
	else {
		spear_length = 0;
		spear_active = false;
		spear_cooldown_counter = spear_cooldown * 60;
	}
}