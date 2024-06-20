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
    vec4 radius;
    vec4 attrs;
    float style;
};

float ss(in vec2 arg, in float x) {
    vec2 tmp = mix(arg.yx, arg.xy, style);
    return smoothstep(tmp.x, tmp.y, x);
}

void main() {
    float _min = min(size.x, size.y), spread = clamp(attrs.x, 1.0 / _min, 1.0), angle = attrs.y,
          padding = attrs.z, blend = attrs.w, _innerpad = mix(0.0, attrs.x / 2.0, style);
    vec2 _rsize = .5 * (size / _min - 1.0);

    vec2 uv = (qt_TexCoord0 - 0.5) * size / _min;

    vec2 temp = mix(radius.xw, radius.yz, step(uv.x, 1.0));
    float rad = mix(temp.x, temp.y, step(uv.y, 1.0));

    float _cblend = dot(uv, normalize(vec2(sin(angle), cos(angle)))) / blend + 0.5;
    spread = clamp(spread, 1.0 / _min, 1.0);
    rad = min((1.0 - spread - padding) / 2.0, rad);

    float rdist
        = length(max(abs(uv) - 0.5 + rad + spread / 2.0 + padding / 2.0 - _rsize, 0.0)) - rad;

    vec4 glow = mix(
        mix(dark, light, clamp(_cblend, 0.0, 1.0)), color,
        ss(vec2(0.0, 4.0 / _min), rdist - _innerpad));
    FragColor = glow * ss(vec2(0.0, spread), rdist + _innerpad / 2.0) * qt_Opacity;
}
