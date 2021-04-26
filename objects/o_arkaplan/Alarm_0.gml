if (!rev) {
	if (a > 0) {
		a -= b;
		alarm[0] = 1;
	}
	else {
		rev = true;
		_1 = false;
		_2 = true;
		alarm[0] = 1;
	}
}
else {
	if (a < 1) {
		a += b;
		alarm[0] = 1;
	}
	else {
		rev = false;
	}
}


