#version 130

uniform sampler2D texture;

in vec4 texCoord;
in vec4 color;

void main()
{
	gl_FragColor = color;// * texture2D(texture, texCoord);
}
