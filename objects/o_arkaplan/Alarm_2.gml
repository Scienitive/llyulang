if (!rev) {
	if (a > 0) {
		a -= b;
		alarm[2] = 1;
	}
	else {
		rev = true;
		_3 = false;
		_4 = true;
		alarm[2] = 1;
	}
}
else {
	if (a < 1) {
		a += b;
		alarm[2] = 1;
	}
	else {
		rev = false;
	}
}

