if (!rev) {
	if (a > 0) {
		a -= b;
		alarm[1] = 1;
	}
	else {
		rev = true;
		_2 = false;
		_3 = true;
		alarm[1] = 1;
	}
}
else {
	if (a < 1) {
		a += b;
		alarm[1] = 1;
	}
	else {
		rev = false;
	}
}

