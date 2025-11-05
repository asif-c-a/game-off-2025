shader_type canvas_item;

// sample the screen texture manually (Godot 4.3+)
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// distortion controls
uniform float zoom_strength : hint_range(0.0, 1.0) = 0.2;
uniform float wave_strength : hint_range(0.0, 1.0) = 0.1;
uniform float wave_speed : hint_range(0.0, 10.0) = 2.0;

// invert controls
uniform bool invert_colors = false;
uniform float invert_blend : hint_range(0.0, 1.0) = 1.0; // 0 = normal, 1 = fully inverted

void fragment() {
    // only affect visible parts of the line
    if (COLOR.a < 0.01) {
        discard;
    }

    // screen-space coordinates
    vec2 screen_uv = SCREEN_UV;

    // small wave distortion along the line
    screen_uv.x += sin(UV.y * 40.0 + TIME * wave_speed) * wave_strength * 0.02;
    screen_uv.y += cos(UV.x * 40.0 + TIME * wave_speed) * wave_strength * 0.02;

    // zoom effect
    vec2 center = vec2(0.5);
    vec2 offset = screen_uv - center;
    screen_uv = center + offset * (1.0 - zoom_strength);

    // sample the screen texture behind the line
    vec4 col = texture(SCREEN_TEXTURE, screen_uv);

    // color inversion (with smooth blending)
    if (invert_colors) {
        vec3 inverted = vec3(1.0) - col.rgb;
        col.rgb = mix(col.rgb, inverted, invert_blend);
    }

    // output distorted screen through line stroke
    COLOR = vec4(col.rgb, COLOR.a);
}
