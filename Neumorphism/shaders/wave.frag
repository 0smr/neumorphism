#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 size;
    vec4 color;
    vec4 dark;
    vec4 light;
    vec4 attrs;
    float seed;
};

void main() {
    float spread = attrs.x, angle = attrs.y, thickness = attrs.z, _min = min(size.x, size.y),
          blend = attrs.w * 5.0 / _min;
    vec2 uv = (qt_TexCoord0 - 0.5) * size / _min;
    float len = fract(length(uv * attrs.w) - seed);

    thickness *= spread *= max(sin(length(uv) * 6.28), 0.0);

    float dist = dot(uv, normalize(vec2(sin(angle), cos(angle)))) / 0.5 + 0.5;
    dist = clamp(dist, 0.0, 1.0);
    float cswitch = smoothstep(blend, 0.0, len - spread - thickness + blend / 2.0);
    float wave = smoothstep(spread, 0.0, abs(len - spread - thickness) - thickness);

    FragColor = mix(dark, light, mix(dist, 1.0 - dist, cswitch)) * wave * qt_Opacity;
}
