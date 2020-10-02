#version 130

out vec2 texCoord;
out vec2 lmCoord;
out vec4 color;

void main()
{
	vec4 Pos = gl_ModelViewProjectionMatrix * gl_Vertex;
	gl_Position = Pos;
	gl_FogFragCoord = Pos.z;
	texCoord = gl_MultiTexCoord0.xy;
	lmCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	color = gl_Color;
}
