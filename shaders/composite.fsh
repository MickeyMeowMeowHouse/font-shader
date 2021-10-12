#version 130

uniform sampler2D colortex0;
uniform sampler2D colortex4;

/* RENDERTARGETS: 0, 1, 2 */

uniform float viewWidth;
uniform float viewHeight;
in vec2 texCoord;
vec2 Resolution = vec2(viewWidth, viewHeight);
vec2 fragCoord = texCoord * Resolution;

void main()
{
	vec4 color = texture(colortex0, texCoord);
	float gray = pow(length(color.rgb), 0.8) * 0.7 + 0.3;
	gl_FragData[0] = color;
	gl_FragData[1] = vec4(gray);
	gl_FragData[2] = vec4(texelFetch(colortex4, ivec2(fragCoord), 0).rgb, 1.0);
}

