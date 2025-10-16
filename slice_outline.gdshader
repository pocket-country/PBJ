shader_type canvas_item;

// This uniform lets you control the highlight color from your GDScript
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 0.0, 1.0); // Bright Yellow
// This uniform lets you turn the effect ON or OFF from your GDScript
uniform bool is_highlighted = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	// Start by drawing the default sprite color
	COLOR = color;
	
	if (is_highlighted) {
		
		// We only draw outlines on the image itself.
		if (color.a > 0.0) {
			
			bool is_on_border = false;
			
			for (int i = -1; i <= 1; i++) {
				for (int j = -1; j <= 1; j++) {
					
					// Skip the center pixel (0, 0)
					if (i == 0 && j == 0) {
						continue;
					}
					
					// Calculate the UV coordinate of the neighbor
					vec2 neighbor_uv = UV + SCREEN_PIXEL_SIZE * vec2(float(i), float(j));
					
					// Check if the neighbor UV is outside the 0.0 to 1.0 range.
					// This condition means we have reached the edge of the texture itself.
					if (neighbor_uv.x < 0.0 || neighbor_uv.x > 1.0 || 
						neighbor_uv.y < 0.0 || neighbor_uv.y > 1.0) {
						
						is_on_border = true;
						break; // Found the edge, no need to check other neighbors
					}
					
				}
				if (is_on_border) {
					break;
				}
			}
			
			// 4. If the pixel is on the border, change its color to the highlight color
			if (is_on_border) {
				COLOR.rgb = outline_color.rgb; // Only modify RGB, keep original alpha/opacity
			}
		}
	}
COLOR.rgb = vec3(0.0, 0.0, 1.0);
if (is_highlighted) {
	COLOR.rgb = vec3(1.0, 0.0, 0.0);
	}
}
