shader_type canvas_item;

// Declare screen texture explicitly
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float zoom_strength : hint_range(0.0, 1.0) = 0.2;
uniform float wave_strength : hint_range(0.0, 1.0) = 0.1;
uniform float wave_speed : hint_range(0.0, 10.0) = 2.0;

void fragment() {
    // Only draw the effect within the visible pixels of the line
    if (COLOR.a < 0.01) {
        discard;
    }

    // Use the screen UVs (relative to screen, not UV of Line2D)
    vec2 screen_uv = SCREEN_UV;
    
    // Add a moving wave distortion
    screen_uv.x += sin(UV.y * 40.0 + TIME * wave_speed) * wave_strength * 0.02;
    screen_uv.y += cos(UV.x * 40.0 + TIME * wave_speed) * wave_strength * 0.02;

    // Apply zoom (like a lens)
    vec2 center = vec2(0.5);
    vec2 offset = screen_uv - center;
    screen_uv = center + offset * (1.0 - zoom_strength);

    // Sample the screen through the distortion
    vec4 screen_col = texture(SCREEN_TEXTURE, screen_uv);

    // Output the distorted pixels (preserving alpha of the stroke)
    COLOR = vec4(screen_col.rgb, COLOR.a);
}
