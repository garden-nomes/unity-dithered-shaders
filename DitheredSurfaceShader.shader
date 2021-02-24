Shader "Custom/DitheredSurfaceShader"
{
    Properties
    {
        [Toggle(ENABLE_DITHERING)]
        _Toggle ("Enable Dithering", Float) = 1.0

        _Color ("Color (light)", Color) = (1,1,1,1)
        _ShadowColor ("Color (dark)", Color) = (0,0,0,1)
        _Range ("Shading Range", Range(0.0001, 1.0)) = 0.5
        _Shift ("Shading Shift", Range(0.0, 1.0)) = 0.5

        [KeywordEnum(Bayer2x2, Bayer4x4, Bayer8x8, BlueNoise)]
        _Pattern ("Dither Pattern", Float) = 0

        _BlueNoiseTex ("Blue Noise", 2D) = "white" {}

        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("Bump Map", 2D) = "bump" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Upgrade NOTE: excluded shader from DX11, OpenGL ES 2.0 because it uses unsized arrays
        #pragma exclude_renderers d3d11 gles
        // Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
        #pragma exclude_renderers d3d11

        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows finalcolor:finalColor

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        #pragma shader_feature_local _PATTERN_BAYER2X2 _PATTERN_BAYER4X4 _PATTERN_BAYER8X8 _PATTERN_BLUENOISE

        #include "./Dithering.cginc"

        sampler2D _MainTex;
        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float4 screenPos;
        };

        half _Glossiness;
        half _Metallic;
        half _PixelSize;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void finalColor(Input IN, SurfaceOutputStandard o, inout float4 color)
        {
            float2 pixel = floor(IN.screenPos * _ScreenParams / IN.screenPos.w);
            float lum = luminance(color);
            lum = saturate(lum / _Range - _Shift / _Range + _Shift);
            color = lerp(_ShadowColor, _Color, dither(pixel, lum));
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
