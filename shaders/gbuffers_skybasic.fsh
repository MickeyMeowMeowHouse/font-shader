
uniform sampler2D texture;

varying vec4 texCoord;
varying vec4 color;

void main()
{
	gl_FragData[0] = color;// * texture2D(texture, texCoord);
}
