
uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D colortex4;
uniform sampler2D colortex5;
uniform sampler2D colortex6;
uniform sampler2D colortex7;

uniform float viewWidth;
uniform float viewHeight;
uniform int frameCounter;
varying vec2 texCoord;
vec2 Resolution = vec2(viewWidth, viewHeight);
vec2 fragCoord = texCoord * Resolution;
const ivec2 CharSize = ivec2(8, 8);
ivec2 TextMode = ivec2(Resolution) / CharSize;
ivec2 BlockDim = ivec2(Resolution) / TextMode;
ivec2 BlockId2 = ivec2(fragCoord) / TextMode;
int BlockId = BlockId2.x + BlockId2.y * BlockDim.x;
int BlockCount = BlockDim.x * BlockDim.y;
int CharCount = 256 / BlockCount;
ivec2 CharPos = ivec2(mod(fragCoord, vec2(TextMode)));
float CharArea = float(CharSize.x * CharSize.y);

#define MIN_CHAR 33
#define MAX_CHAR 192

void main()
{
	float ConvMaxScore = -10000.0;
	int MaxScoreChar = 0;
	if(CharCount == 0) CharCount = 1;
	for(int i = 0; i < CharCount; i++)
	{
		int CharCode = i * BlockCount + BlockId + MIN_CHAR;
		if(CharCode > MAX_CHAR) break;
		// CharCode = (CharCode + frameCounter) % (MAX_CHAR - MIN_CHAR) + MIN_CHAR;
		ivec2 CharOrigin = ivec2(CharCode % 16, CharCode / 16) * CharSize;
		float ConvScore = 0.0;
		for(int y = 0; y < CharSize.y; y ++)
		{
			for(int x = 0; x < CharSize.x; x ++)
			{
				ivec2 xy = ivec2(x, y);
				ivec2 CharTexCoord = CharOrigin + xy;
				ivec2 SceneTexCoord = CharPos * CharSize + xy;
                float SceneSample = texelFetch(colortex1, SceneTexCoord, 0).r - 0.5;
				float CharSample = texelFetch(colortex2, CharTexCoord, 0).r - 0.5;
				ConvScore += CharSample * SceneSample;
			}
		}

        if (ConvScore >= ConvMaxScore)
        {
            ConvMaxScore = ConvScore;
            MaxScoreChar = CharCode;
        }
	}

	gl_FragData[0] = texture2D(colortex0, texCoord);
	gl_FragData[1] = vec4(float(MaxScoreChar) / float(MAX_CHAR), ConvMaxScore / CharArea, 0.0, 1.0);
	gl_FragData[2] = texelFetch(colortex2, ivec2(fragCoord), 0);
}
