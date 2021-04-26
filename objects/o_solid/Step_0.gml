if (y < -64) {
	instance_destroy(self);
}

if (breaking) {
	image_speed = 1;
	if (floor(image_index) == 7) {
		instance_destroy(self);
	}
}