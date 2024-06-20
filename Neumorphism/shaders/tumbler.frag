#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float _xrad;
    float _gapsize;
    vec4 _shade;
    vec4 _highlight;
};

void main() {
    vec2 coord = 2. * qt_TexCoord0 - 1.0;
    float h = smoothstep(0.0, 0.20, -abs(coord.x) + _xrad);
    float v = smoothstep(0.0, 0.50, -abs(coord.y) + 0.58);
    float gap = smoothstep(0.0, 0.01, abs(coord.x) - _gapsize);
    vec4 color = qt_TexCoord0.x > 0.5 ? _shade : _highlight;
    FragColor = color * h * v * gap * qt_Opacity;
}
