
uniform sampler2D texture;
uniform sampler2D lightmap;
uniform vec4 entityColor;

varying vec2 texCoord;
varying vec2 lmCoord;
varying vec4 color;

void main()
{
	vec4 textureColor = texture2D(texture, texCoord) * color;
	if (length(entityColor) >= 0.1) textureColor = (textureColor + entityColor) * 0.5;
	if(textureColor.w <= 0.001) discard;
	gl_FragData[0] = textureColor * vec4(clamp(lmCoord.x + lmCoord.y, 0.0, 1.0));
}
