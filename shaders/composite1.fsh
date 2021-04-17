#version 130

uniform sampler2D colortex1;
uniform sampler2D colortex2;

const int RGBA32F = 0;
const int gaux1Format = RGBA32F;
/* RENDERTARGETS: 2, 4 */

uniform float viewWidth;
uniform float viewHeight;
in vec2 texCoord;
vec2 Resolution = vec2(viewWidth, viewHeight);
vec2 fragCoord = texCoord * Resolution;
const ivec2 CharSize = ivec2(8, 16);
const ivec2 CharArrange = ivec2(16, 16);
ivec2 TextMode = ivec2(Resolution) / CharSize;
ivec2 BlockDim = ivec2(Resolution) / TextMode;
ivec2 BlockId2 = ivec2(fragCoord) / TextMode;
int BlockId = BlockId2.x + BlockId2.y * BlockDim.x;
int BlockCount = BlockDim.x * BlockDim.y;
int CharCount = 256 / BlockCount;
ivec2 CharPos = ivec2(mod(fragCoord, vec2(TextMode)));
float CharArea = float(CharSize.x * CharSize.y);

#define MIN_CHAR 0
#define MAX_CHAR 255

void main()
{
	float ConvMaxScore = -10000.0;
	int MaxScoreChar = 0;
	bool MaxIsInverted = false;
	if(CharCount == 0)
	{
		if(BlockId + MIN_CHAR <= MAX_CHAR)
			CharCount = 1;
	}
	for(int i = 0; i < CharCount; i++)
	{
		int CharCode = i * BlockCount + BlockId + MIN_CHAR;
		if(CharCode > MAX_CHAR) break;
		ivec2 CharOrigin = ivec2(CharCode % CharArrange.x, CharCode / CharArrange.x) * CharSize;
		float ConvScore = 0.0;
		float CharScore = 0.0;
		for(int y = 0; y < CharSize.y; y ++)
		{
			for(int x = 0; x < CharSize.x; x ++)
			{
				ivec2 xy = ivec2(x, y);
				ivec2 CharTexCoord = CharOrigin + ivec2(x, CharSize.y - 1 - y);
				ivec2 SceneTexCoord = CharPos * CharSize + xy;
				vec4 SceneSample = texelFetch(colortex1, SceneTexCoord, 0);
                float Gray = SceneSample.r - 0.5;
				float CharSample = texelFetch(colortex2, CharTexCoord, 0).r - 0.5;
				CharScore += CharSample * CharSample;
				ConvScore += CharSample * Gray;
			}
		}

		if(int(CharScore) != int(CharArea))
		{
			ConvScore /= sqrt(CharScore);
	        if (ConvScore >= ConvMaxScore)
	        {
	            ConvMaxScore = ConvScore;
	            MaxScoreChar = CharCode;
	        }
	    }
	}

	gl_FragData[2] = texture2D(colortex2, texCoord);
	gl_FragData[4] = vec4(float(MaxScoreChar), ConvMaxScore, 0.0, 0.0);
}
