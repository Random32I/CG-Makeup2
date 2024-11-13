Shader "Custom/Diffuse"
{
     Properties
	{
	_Color("Color", Color) = (1.0,1.0,1.0)
	_Hits("Amount of Hits", Range(0.0,0.8)) = 0.8
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
	
}
}
