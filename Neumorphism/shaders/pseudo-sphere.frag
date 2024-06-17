// https://www.shadertoy.com/view/XdXXRj

#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 size;
    vec4 dark;
    vec4 light;
    float angle;
    float dist;
};

void main() {
    vec2 uv = (2.0 * qt_TexCoord0 - 1.0) * size / min(size.x, size.y);
    uv.y = -uv.y;
    float circle = smoothstep(0.01, 0.0, length(uv) - 0.8);
    float shadow = smoothstep(0.0, 0.8, length(uv - vec2(sin(angle), cos(angle)) / dist) - 0.608);
    vec4 _color = mix(light, dark, shadow);
    FragColor = vec4(1.0) * circle * _color;
}
