#version 130

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
ivec2 TextScreenPos = ivec2(fragCoord) / CharSize;

vec4 SampleChar(sampler2D Channel, int Char, ivec2 TexCrd)
{
    ivec2 CharOrigin = ivec2(Char % CharArrange.x, Char / CharArrange.x);
    return texelFetch(Channel, CharOrigin * CharSize + ivec2(TexCrd.x, CharSize.y - 1 - TexCrd.y), 0).rrrr;
}

vec4 GetOrigColor()
{
	ivec2 OrigUV = (ivec2(fragCoord) / CharSize) * CharSize + CharSize / 2;
	return texelFetch(colortex0, OrigUV, 0);
}

vec4 LimitColor(vec4 Color, int Depth)
{
	vec4 Curved = pow(Color, vec4(0.75));
    return clamp(vec4(ivec4(Curved * (float(Depth) + 0.5))) / vec4(Depth), 0.0, 1.0);
}

void main()
{
	bool IsInverted = false;
    int CharCode = 0;
    float CharScore = -10000.0;
    for(int i = 0; i < BlockCount; i++)
    {
        ivec2 BlockPos = ivec2(i % BlockDim.x, i / BlockDim.x);
        vec4 BlockData = texelFetch(colortex1, ivec2(BlockPos * TextMode + TextScreenPos), 0);
        if(BlockData.y > CharScore)
        {
            CharScore = BlockData.y;
            CharCode = int(BlockData.x * (BlockData.z * 255.0));
            IsInverted = (int(BlockData.w) != 0);
        }
    }
    
    ivec2 CharTexCoord = ivec2(fragCoord) % CharSize;
    vec4 CharSample = SampleChar(colortex2, CharCode, CharTexCoord);
    if(IsInverted)
    {
    	CharSample = vec4(1) - CharSample;
    }
    gl_FragColor = CharSample * LimitColor(GetOrigColor(), 4);

    // gl_FragColor = texelFetch(colortex0, ivec2(fragCoord), 0);
}
