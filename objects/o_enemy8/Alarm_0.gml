var player_dist = o_player.x - x;
enemy_attack = true;
grv = 0.5;
hsp = sign(image_xscale) * spd * (abs(player_dist) / 300);
vsp = -abs(player_dist)/40;
enemy_activator = false;