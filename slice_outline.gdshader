shader_type canvas_item;

// This uniform lets you control the highlight color from your GDScript
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 0.0, 1.0); // Yellow
// This uniform lets you turn the effect ON or OFF from your GDScript
uniform bool is_highlighted = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if (is_highlighted) {
		// --- The Outline Logic ---
		// We sample the texture at an offset of one pixel in the four cardinal directions (X and Y)
		for (int i = -1; i <= 1; i++) {
			for (int j = -1; j <= 1; j++) {
				// Skip the center pixel and diagonal checks
				if (abs(i) + abs(j) == 1) {
					// Sample the neighboring pixel's alpha (transparency)
					vec2 neighbor_uv = UV + SCREEN_PIXEL_SIZE * vec2(float(i), float(j));
					float neighbor_alpha = texture(TEXTURE, neighbor_uv).a;
					
					// If the neighbor is opaque (has an image) AND the current pixel is transparent...
					if (neighbor_alpha > 0.0 && color.a == 0.0) {
						// ...then color the current transparent pixel with the outline color.
						color = outline_color;
						break;
					}
				}
			}
		}
	}
	
	// Draw the final color (which is either the original texture color, or the outline color)
	COLOR = color;
}