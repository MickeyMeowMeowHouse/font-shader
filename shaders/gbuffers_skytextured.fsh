#version 130

uniform sampler2D texture;

in vec2 texCoord;
in vec4 color;

void main()
{
	gl_FragData[0] = color * texture2D(texture, texCoord);
}
