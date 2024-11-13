Shader "Custom/Diffuse"
{
 Properties
	{
	_Color("Color", Color) = (1.0,1.0,1.0)
	_Hits("Amount of Hits", Range(0.0,0.8)) = 0.8
	

        _Amount("Extrude", Range(-1,2)) = 0.01
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline Width", Range (0.02,1)) = .005

	}
SubShader{
   Tags {"LightMode" = "ForwardBase"}

	Pass{
	CGPROGRAM

	#pragma vertex vert
	#pragma fragment frag
	// user defined variables
	uniform float4 _Color;
	uniform float _Hits;
	uniform float4 _LightColor0;
	// base input structs
	struct vertexInput {
	
	float4 vertex: POSITION;
	float3 normal: NORMAL;

	};

		struct vertexOutput 
		{
		float4 pos: SV_POSITION;
		float4 col: COLOR;
		};
	// vertex functions
	  vertexOutput vert(vertexInput v) 
		{
		vertexOutput o;
		
		float3 normalDirection = normalize(mul(float4(v.normal,0.0),unity_WorldToObject).xyz);
		float3 lightDirection;
		float atten = 1.0;
		lightDirection = normalize(_WorldSpaceLightPos0.xyz);
		float3 diffuseReflection = atten*_LightColor0.xyz*_Color.rgb*max(_Hits,dot(normalDirection, lightDirection));
		o.col = float4(diffuseReflection, 0.5);
		o.pos = UnityObjectToClipPos(v.vertex);
		return o;
		}


	// fragment function
	float4 frag(vertexOutput i) : COLOR
	{
	return i.col;
	}
	ENDCG
	}
	 Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                };

            struct v2f {
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;

                };

            float _Outline;
            float4 _OutlineColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                float3 norm =  normalize(mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                float2 offset = TransformViewToProjection(norm.xy);

                o.pos.xy += offset * o.pos.z * _Outline;
                o.color = _OutlineColor;
                return o;
                }

                fixed4 frag(v2f i): SV_Target{
                    return i.color;
                    }
                    ENDCG
         }
	
}
}
