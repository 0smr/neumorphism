#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float a;
    float b;
    float dir;
    float spread;
    vec2 ratio;
    vec4 color;
};

void main() {
    highp vec2 coord = (qt_TexCoord0 - vec2(0.5)) * ratio;
    highp float bx = b * coord.x;
    highp float slop = a * b / (1 + bx * bx);
    highp float coordDist = (slop * coord.x + coord.y) / sqrt(slop * slop + 1);

    highp float edges = smoothstep(0, 0.20, -abs(coord.x) + 0.48);
    highp float shade = smoothstep(0, 0.01, -dir * coordDist) * (spread + dir * 10 * coordDist);

    FragColor = color * edges * shade * qt_Opacity;
}