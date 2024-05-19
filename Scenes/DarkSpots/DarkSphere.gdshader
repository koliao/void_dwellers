shader_type spatial;
render_mode unshaded;

uniform float width = 0.0;
varying vec3 world_normal;

void vertex() {
	world_normal = NORMAL;
}

void fragment() {
	if(world_normal.y == -1.0) {
		discard;
	}
	//ALPHA = UV.x;
	float mask = dot(normalize(CAMERA_DIRECTION_WORLD), NORMAL);
	ALBEDO = vec3(0.0, 0.0, 0.0);
	ALPHA = smoothstep(0.9, 1.0, fract(abs(mask)));
}