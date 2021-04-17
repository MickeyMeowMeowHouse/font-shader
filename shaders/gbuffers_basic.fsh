#version 130

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec4 entityColor;

/* RENDERTARGETS: 0 */

in vec2 texCoord;
in vec2 lmCoord;
in vec4 color;

void main()
{
	vec4 textureColor = texture2D(texture, texCoord) * color;
	vec4 lmColor = texture2D(lightmap, lmCoord);
	if (length(entityColor) >= 0.1) textureColor = (textureColor + entityColor) * 0.5;
	if(textureColor.w <= 0.001) discard;
	gl_FragColor = textureColor * lmColor;
}
