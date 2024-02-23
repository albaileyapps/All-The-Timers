shader_type canvas_item;

uniform vec4 top : source_color;
uniform vec4 bottom : source_color;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 col = mix(top, bottom, tex.r);
	COLOR = vec4(col.x, col.y, col.z, tex.a);
}