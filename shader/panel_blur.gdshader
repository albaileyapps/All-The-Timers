shader_type canvas_item;

uniform vec4 panel_color : source_color;
uniform float alpha : hint_range(0.0, 1.0);
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void fragment() {
	vec4 tex = textureLod(SCREEN_TEXTURE, SCREEN_UV, 5.0);
	COLOR = mix(panel_color, tex, alpha);
}