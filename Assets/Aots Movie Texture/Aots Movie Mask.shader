Shader "Custom/Aots Movie Mask" {
    Properties
    {
        _MainTex("Base Texture", 2D) = "" {}
        _Color("Mask Color", Color) = (1, 1, 1, 1)
    }

    CGINCLUDE

#include "UnityCG.cginc"

sampler2D _MainTex;
half4 _Color;

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
    float2 uv = i.texcoord;

    uv.x *= 0.5f;
    uv.x += 0.5f;

    half4 mask = tex2D(_MainTex, uv);

    half4 color = _Color;
    color.a *= mask.r;

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
