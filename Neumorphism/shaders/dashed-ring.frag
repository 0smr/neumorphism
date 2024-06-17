#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float count;
    float dashWidth;
    float borderWidth;
    float smoothstp;
    vec4 color;
};

void main() {
    highp vec2 normal = qt_TexCoord0 - vec2(0.5);
    highp float ticks = smoothstep(
        0.0, 20 * smoothstp / count,
        -abs(fract(atan(normal.x, normal.y) * 57.2958 / count) - 0.5) + dashWidth / count);
    highp float ring
        = smoothstep(0.0, smoothstp, -abs(length(normal) - 0.5 + borderWidth) + borderWidth);
    FragColor = color * ring * ticks;
}