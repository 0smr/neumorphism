
#ifdef GL_ES
    precision mediump float;
#endif

uniform highp float qt_Opacity;
varying highp vec2 qt_TexCoord0;
uniform highp vec2 size;
uniform highp vec4 color;
uniform highp vec4 dark;
uniform highp vec4 light;
uniform highp vec4 attrs;
uniform highp float seed;

void main() {
    float spread = attrs.x, angle = attrs.y, thickness = attrs.z,
          _min = min(size.x, size.y), blend = attrs.w * 5.0/_min;
    vec2 uv = (qt_TexCoord0 - 0.5) * size/_min;
    float len = fract(length(uv * attrs.w) - seed);

    thickness *= spread *= max(sin(length(uv) * 6.28), 0.0);

    float dist = dot(uv, normalize(vec2(sin(angle), cos(angle)))) / 0.5 + 0.5;
    dist = clamp(dist, 0.0, 1.0);
    float cswitch = smoothstep(blend, 0.0, len - spread - thickness + blend/2.0);
    float wave = smoothstep(spread, 0.0, abs(len - spread - thickness) - thickness);

    gl_FragColor = mix(dark, light, mix(dist, 1.0 - dist, cswitch)) * wave * qt_Opacity;
}
