Shader "Custom/Aots Movie Texture" {
    Properties
    {
        _MainTex("Base Texture", 2D) = "" {}
        _ColorTint("Color Tint", Color) = (0.5, 0.5, 0.5, 1)
    }

    CGINCLUDE

#include "UnityCG.cginc"

sampler2D _MainTex;
half4 _ColorTint;

struct v2f
{
    float4 position : SV_POSITION;
    float2 texcoord : TEXCOORD0;
};

v2f vert(appdata_base v)
{
    v2f o;
    o.position = mul(UNITY_MATRIX_MVP, v.vertex);
    o.texcoord = v.texcoord;
    return o;
}

float4 frag(v2f i) : SV_Target 
{
    float2 uv1 = i.texcoord;
    float2 uv2 = i.texcoord;

    uv1.x *= 0.5f;
    uv2.x *= 0.5f;
    uv2.x += 0.5f;

    half4 color = tex2D(_MainTex, uv1);
    half4 mask = tex2D(_MainTex, uv2);

    color.rgb *= _ColorTint.rgb * 2;
    color.a = mask.r * _ColorTint.a;

    return color;
}

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        Pass
        {
            ZTest Always Cull Off ZWrite Off
            Fog { Mode off }
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
}
