#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 size;
    vec4 color;
    vec4 shade;
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
    float _min = min(size.x, size.y), spread = clamp(attrs.x, 1./_min, 1.0), angle = attrs.y, padding = attrs.z,
          blend = attrs.w, _innerpad = mix(0., attrs.x/2.0, style);

    vec2 uv = (qt_TexCoord0 - 0.5) * size/_min;

    radius.xy = mix(radius.xw, radius.yz, step(uv.x, 1.0));
    float rad = mix(radius.x, radius.y, step(uv.y, 1.0));

    float dist = dot(uv, normalize(vec2(sin(angle), cos(angle)))) / blend + 0.5;
    spread = clamp(spread, 1./_min, 1.0);
    rad = min((1.0 - spread - padding)/2.0, rad);

    float blur = length(max(abs(uv) - 0.5 + rad + spread/2. + padding/2., 0.)) - rad;

    vec4 _color = mix(mix(shade, light, clamp(dist, 0., 1.)), color, ss(vec2(0., 5./_min), blur - _innerpad));
    gl_FragColor = _color * ss(vec2(0., spread), blur + _innerpad/2.) * qt_Opacity;
}
