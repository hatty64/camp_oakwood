shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

const float curvature = 4.0;

uniform sampler2D screen_texture: hint_screen_texture;

void fragment() {
	vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;
	vec2 uv_offset = centered_uv.yx / curvature;
	vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
	vec3 cutoff = vec3(step(abs(warped_uv.x), 1.0) * step(abs(warped_uv.y),1.0));
	vec3 scanlines = vec3(sin(2.0 * warped_uv.y * 180.0) * 0.25 + 0.5);

	vec3 screen_color = texture(screen_texture, (warped_uv + 1.0) / 2.0).rgb * cutoff * scanlines;
	//COLOR = vec4(warped_uv, 0.0, 1.0);
	COLOR = vec4(screen_color, 1.0);
}
