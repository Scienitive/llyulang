randomize();
var luck = irandom_range(0,7);

if (luck == 0) {
	var dir = sign(o_player.x - x) * -1;
	var lil_heart = instance_create_layer(x + (dir * 8), y, "Instances", o_little_heart);
	lil_heart.hsp = dir * lil_heart.spd;
	lil_heart.vsp = lil_heart.spd * -1;
}