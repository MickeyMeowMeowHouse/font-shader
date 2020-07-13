
varying vec4 texCoord;
varying vec4 color;

void main()
{
	color = gl_Color;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	texCoord = gl_MultiTexCoord0;
}
