shader_type spatial;
render_mode unshaded;

uniform float width = 0.3;

void fragment() {
	ALPHA = 1.0 - smoothstep(width, 1.0, UV.y);
	ALBEDO = vec3(0.0, 0.0, 0.0);
	// Called for every pixel the material is visible on.
}