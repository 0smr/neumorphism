#ifdef GL_ES
    precision mediump float;
#endif

uniform highp float qt_Opacity;
varying highp vec2 qt_TexCoord0;
uniform highp vec2 size;
uniform highp vec4 color;
uniform highp vec4 dark;
uniform highp vec4 light;
uniform highp vec4 radius;
uniform highp vec4 attrs;
uniform lowp float style;

float ss(in vec2 arg, in float x) {
    vec2 tmp = mix(arg.yx, arg.xy, style);
    return smoothstep(tmp.x, tmp.y, x);
}

void main() {
    float _min = min(size.x, size.y), spread = clamp(attrs.x, 1./_min, 1.0), angle = attrs.y,
          padding = attrs.z, blend = attrs.w, _innerpad = mix(0., attrs.x/2.0, style);
    vec2 _rsize = .5 * (size/_min - 1.);

    vec2 uv = (qt_TexCoord0 - 0.5) * size/_min;

    radius.xy = mix(radius.xw, radius.yz, step(uv.x, 1.0));
    float rad = mix(radius.x, radius.y, step(uv.y, 1.0));

    float _cblend = dot(uv, normalize(vec2(sin(angle), cos(angle)))) / blend + 0.5;
    spread = clamp(spread, 1./_min, 1.0);
    rad = min((1.0 - spread - padding)/2.0, rad);

    float rdist = length(max(abs(uv) - 0.5 + rad + spread/2. + padding/2. - _rsize, 0.)) - rad;

    vec4 glow = mix(mix(dark, light, clamp(_cblend, 0., 1.)), color, ss(vec2(0., 4./_min), rdist - _innerpad));
    gl_FragColor = glow * ss(vec2(0., spread), rdist + _innerpad/2.) * qt_Opacity;
}
