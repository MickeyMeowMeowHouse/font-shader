
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
varying vec2 texCoord;
vec2 Resolution = vec2(viewWidth, viewHeight);
vec2 fragCoord = texCoord * Resolution;
const ivec2 CharSize = ivec2(8, 8);
ivec2 TextMode = ivec2(Resolution) / CharSize;
ivec2 BlockDim = ivec2(Resolution) / TextMode;
ivec2 BlockId2 = ivec2(fragCoord) / TextMode;
int BlockId = BlockId2.x + BlockId2.y * BlockDim.x;
int BlockCount = BlockDim.x * BlockDim.y;
ivec2 TextScreenPos = ivec2(fragCoord) * TextMode / ivec2(Resolution);

#define MAX_CHAR 192

vec4 SampleChar(sampler2D Channel, int Char, ivec2 TexCrd)
{
    ivec2 CharOrigin = ivec2(Char % 16, Char / 16);
    return texelFetch(Channel, CharOrigin * CharSize + TexCrd, 0).rrrr;
}

vec4 GetOrigColor()
{
	vec2 OrigUV = vec2((ivec2(fragCoord) / CharSize) * CharSize + CharSize / 2) / Resolution;
	return texture2D(colortex0, OrigUV);
}

vec4 LevelColor(vec4 Color, float level)
{
    return clamp(floor(Color * level) / level, 0.0, 1.0);
}

void main()
{

    int CharCode = 0;
    float CharScore = -10000.0;
    for(int i = 0; i < BlockCount; i++)
    {
        ivec2 BlockPos = ivec2(int(mod(float(i), float(BlockDim.x))), i / BlockDim.x);
        vec4 BlockData = texelFetch(colortex1, ivec2(BlockPos * TextMode + TextScreenPos), 0);
        if(BlockData.y > CharScore)
        {
            CharScore = BlockData.y;
            CharCode = int(BlockData.x * float(MAX_CHAR));
        }
    }
    
    ivec2 CharTexCoord = ivec2(mod(fragCoord, vec2(CharSize)));
    gl_FragColor = vec4(SampleChar(colortex2, CharCode, CharTexCoord)) * LevelColor(GetOrigColor(), 3.0);
}
