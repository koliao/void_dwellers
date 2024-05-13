shader_type spatial;
render_mode unshaded;

uniform float width = 0.0;
varying vec3 world_normal;

vec2 rotate(vec2 v, float angle) {
	return abs(mat2( vec2(cos(angle), -sin(angle)),
	             vec2(sin(angle), cos(angle)) ) * v);
}

void vertex() {
	world_normal = NORMAL;
}

void fragment() {
	if(world_normal.y == -1.0) {
		discard;
	}
	
	ALBEDO = vec3(0.0, 0.0, 0.0);
	if(world_normal.x == 1.0) {
		ALPHA = smoothstep(0.0, 0.2, UV.y - 0.5);
	} else {
		ALPHA = smoothstep(0.0, 0.2, UV.y);
	}
	
	if(world_normal.y == 1.0) {
		ALPHA = 1.0;
	}
}