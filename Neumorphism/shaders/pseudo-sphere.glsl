// https://www.shadertoy.com/view/XdXXRj

#ifdef GL_ES
    precision mediump float;
#endif

uniform highp float qt_Opacity;
varying highp vec2 qt_TexCoord0;
uniform highp vec2 size;

uniform highp vec4 dark;
uniform highp vec4 light;
uniform highp float angle;
uniform highp float dist;

void main() {
    vec2 uv = (2.0 * qt_TexCoord0 - 1.0) * size / min(size.x, size.y);
    uv.y = -uv.y;
    float circle = smoothstep(0.01, 0.0, length(uv) - 0.8);
    float shadow = smoothstep(0.0, 0.8, length(uv - vec2(sin(angle), cos(angle))/dist) - 0.608);
    vec4 _color = mix(light, dark, shadow);
    gl_FragColor = vec4(1.0) * circle * _color;
}
