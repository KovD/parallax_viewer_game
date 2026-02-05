shader_type canvas_item;

uniform sampler2D depth_map;
uniform float layer_offset = 0.0;
uniform float depth_strength = 0.02;
uniform float opacity : hint_range(0.0, 1.0) = 0.5;
uniform vec2 motion_offset;
uniform float internal_parallax_power = 0.05;

void fragment() {
	// 1. Domborzat
	float d = texture(depth_map, UV).r;
	
	// 2. Belső Parallax
	vec2 uv_parallax = UV + (motion_offset * d * internal_parallax_power);
	
	// 3. 3D eltolás
	float total_shift = layer_offset + (d * depth_strength);
	vec2 offset_3d = vec2(total_shift, 0.0);
	
	// 4. Színek kiolvasása
	vec4 col_left = texture(TEXTURE, uv_parallax - offset_3d);
	vec4 col_right = texture(TEXTURE, uv_parallax + offset_3d);
	
	// 5. --- JAVÍTÁS: VISSZA A NORMÁLISRA ---
	// Az előző verzióban felcseréltük a jobb/bal szemet. 
	// Most visszaállítjuk: Piros = col_left.r
	vec3 final_color = vec3(col_left.r, col_right.g, col_right.b);
	
	float alpha = min(col_left.a, col_right.a);
	
	// Szél levágás
	if (uv_parallax.x < 0.0 || uv_parallax.x > 1.0 || uv_parallax.y < 0.0 || uv_parallax.y > 1.0) {
		alpha = 0.0;
	}
	
	COLOR = vec4(final_color, alpha * opacity);
}