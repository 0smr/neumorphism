#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 FragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec4 color;
    float weight1;
    float weight2;
    float weight3;
    float weight4;
    float weight5;
};
layout(binding = 1) uniform sampler2D source1;
layout(binding = 2) uniform sampler2D source2;
layout(binding = 3) uniform sampler2D source3;
layout(binding = 4) uniform sampler2D source4;
layout(binding = 5) uniform sampler2D source5;

void main() {
    lowp float op = texture(source1, qt_TexCoord0).a * weight1;
    op += texture(source2, qt_TexCoord0).a * weight2;
    op += texture(source3, qt_TexCoord0).a * weight3;
    op += texture(source4, qt_TexCoord0).a * weight4;
    op += texture(source5, qt_TexCoord0).a * weight5;
    FragColor = op * qt_Opacity * color;
}
