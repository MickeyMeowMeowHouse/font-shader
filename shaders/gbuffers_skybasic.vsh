#version 130

out vec4 texCoord;
out vec4 color;

void main()
{
	color = gl_Color;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	texCoord = gl_MultiTexCoord0;
}
