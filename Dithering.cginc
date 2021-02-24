#ifdef _PATTERN_BAYER2X2
static float ditherMatrix[4] = {
    0.0, 3.0,
    2.0, 1.0
};

static float sideLength = 2.0;
#elif _PATTERN_BAYER4X4
static float ditherMatrix[16] = {
    0.0, 8.0, 2.0, 10.0,
    12.0, 4.0, 14.0, 6.0,
    3.0, 11.0, 1.0, 9.0,
    15.0, 7.0, 13.0, 5.0
};

static float sideLength = 4.0;
#elif _PATTERN_BAYER8X8
static float ditherMatrix[64] = {
    0, 32,  8, 40,  2, 34, 10, 42,
    48, 16, 56, 24, 50, 18, 58, 26,
    12, 44,  4, 36, 14, 46,  6, 38,
    60, 28, 52, 20, 62, 30, 54, 22,
    3, 35, 11, 43,  1, 33,  9, 41,
    51, 19, 59, 27, 49, 17, 57, 25,
    15, 47,  7, 39, 13, 45,  5, 37,
    63, 31, 55, 23, 61, 29, 53, 21
};

static float sideLength = 8.0;
#endif

half _Range;
half _Shift;
float4 _Color;
float4 _ShadowColor;

#ifdef _PATTERN_BLUENOISE
sampler2D _BlueNoiseTex;
float2 _BlueNoiseTex_TexelSize;
#endif

float dither(float2 pixel, float value)
{
#ifdef _PATTERN_BLUENOISE
    float2 uv = pixel * _BlueNoiseTex_TexelSize;
    float threshold = tex2D(_BlueNoiseTex, uv).r;
#else
    float index = fmod(pixel.y, sideLength) * sideLength + fmod(pixel.x, sideLength);
    float threshold = ditherMatrix[index];
    float n = sideLength * sideLength + 1.0;
    threshold = threshold / n + 1.0 / n;
#endif

    return step(1.0 - value, threshold);
}

float luminance(float4 color) {
    return dot(color, float3(0.299f, 0.587f, 0.114f));
}
