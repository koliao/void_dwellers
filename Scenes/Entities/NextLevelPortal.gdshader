shader_type spatial;

varying vec3 world_normal;

void vertex() {
	world_normal = NORMAL;
}

void fragment() {
	if(world_normal.y == 1.0) {
		ALBEDO = vec3(1.0, 0.5, 0.8);
	} else {
		float global_mask = UV.y*8.0;
		float mask = global_mask*abs(sin(fract((UV.y + TIME*0.1) * 10.0) - 0.5));
		vec3 color = vec3(1.0, 0.5, 0.8);
		ALPHA = mask;
		ALBEDO = color;
	}
}
