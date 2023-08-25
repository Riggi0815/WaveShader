Shader "Custom/RippleShader"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_Color ("Color", Color) = (1,1,1,1)
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Scale ("Scale", float) = 1
		_Speed ("Speed", float) = 1
		_Frequency ("Frequency", float) = 1
	    [HideInInspector]_WaveAmplitude1 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude2 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude3 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude4 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude5 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude6 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude7 ("WaveAmplitude1", float) = 0
		[HideInInspector]_WaveAmplitude8 ("WaveAmplitude1", float) = 0
		[HideInInspector]_xImpact1 ("x Impact 1", float) = 0
		[HideInInspector]_zImpact1 ("z Impact 1", float) = 0
		[HideInInspector]_xImpact2 ("x Impact 2", float) = 0
		[HideInInspector]_zImpact2 ("z Impact 2", float) = 0
		[HideInInspector]_xImpact3 ("x Impact 3", float) = 0
		[HideInInspector]_zImpact3 ("z Impact 3", float) = 0
		[HideInInspector]_xImpact4 ("x Impact 4", float) = 0
		[HideInInspector]_zImpact4 ("z Impact 4", float) = 0
		[HideInInspector]_xImpact5 ("x Impact 5", float) = 0
		[HideInInspector]_zImpact5 ("z Impact 5", float) = 0
		[HideInInspector]_xImpact6 ("x Impact 6", float) = 0
		[HideInInspector]_zImpact6 ("z Impact 6", float) = 0
		[HideInInspector]_xImpact7 ("x Impact 7", float) = 0
		[HideInInspector]_zImpact7 ("z Impact 7", float) = 0
		[HideInInspector]_xImpact8 ("x Impact 8", float) = 0
		[HideInInspector]_zImpact8 ("z Impact 8", float) = 0
  
		[HideInInspector]_Distance1 ("Distance1", float) = 0
		[HideInInspector]_Distance2 ("Distance2", float) = 0
		[HideInInspector]_Distance3 ("Distance3", float) = 0
		[HideInInspector]_Distance4 ("Distance4", float) = 0
		[HideInInspector]_Distance5 ("Distance5", float) = 0
		[HideInInspector]_Distance6 ("Distance6", float) = 0
		[HideInInspector]_Distance7 ("Distance7", float) = 0
		[HideInInspector]_Distance8 ("Distance8", float) = 0
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _Scale, _Speed, _Frequenzy;
        float _WaveAmplitude1, _WaveAmplitude2, _WaveAmplitude3, _WaveAmplitude4, _WaveAmplitude5, _WaveAmplitude6, _WaveAmplitude7, _WaveAmplitude8;
        float _OffsetX1, _OffsetZ1, _OffsetX2, _OffsetZ2, _OffsetX3, _OffsetZ3, _OffsetX4, _OffsetZ4, _OffsetX5, _OffsetZ5, _OffsetX6, _OffsetZ6,
              _OffsetX7, _OffsetZ7, _OffsetX8, _OffsetZ8;
        float _Distance1, _Distance2 , _Distance3, _Distance4, _Distance5, _Distance6, _Distance7, _Distance8;
        float _xImpact1, _zImpact1, _xImpact2, _zImpact2,_xImpact3, _zImpact3,_xImpact4, _zImpact4,_xImpact5, _zImpact5,_xImpact6, _zImpact6,
		      _xImpact7, _zImpact7,_xImpact8, _zImpact8;
        struct Input
        {
            float2 uv_MainTex;
        	float3 customValue;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
        // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full vertexData, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
		half offsetvert = ((vertexData.vertex.x * vertexData.vertex.x) + (vertexData.vertex.z * vertexData.vertex.z));
		//half offsetvert2 = vertexData.vertex.x + vertexData.vertex.z; //diagonal waves
		//half offsetvert2 = v.vertex.x; //horizontal waves
		
		//half value0 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert2 );
		
		half value1 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX1) + (vertexData.vertex.z * _OffsetZ1)  );
		half value2 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX2) + (vertexData.vertex.z * _OffsetZ2)  );
		half value3 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX3) + (vertexData.vertex.z * _OffsetZ3)  );
		half value4 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX4) + (vertexData.vertex.z * _OffsetZ4)  );
		half value5 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX5) + (vertexData.vertex.z * _OffsetZ5)  );
		half value6 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX6) + (vertexData.vertex.z * _OffsetZ6)  );
		half value7 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX7) + (vertexData.vertex.z * _OffsetZ7)  );
		half value8 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetvert + (vertexData.vertex.x * _OffsetX8) + (vertexData.vertex.z * _OffsetZ8)  );
		
		float3 worldPos = mul(unity_ObjectToWorld, vertexData.vertex).xyz;
		
		
		//vertexData.vertex.y += value0; //remove for no waves
		//vertexData.normal.y += value0; //remove for no waves
		//o.customValue += value0  ;

		
		if (sqrt(pow(worldPos.x - _xImpact1, 2) + pow(worldPos.z - _zImpact1, 2)) < _Distance1)
		{
		vertexData.vertex.y += value1 * _WaveAmplitude1;
		vertexData.normal.y += value1 * _WaveAmplitude1;	
		o.customValue += value1 * _WaveAmplitude1;	

		}
		if (sqrt(pow(worldPos.x - _xImpact2, 2) + pow(worldPos.z - _zImpact2, 2)) < _Distance2)
		{
		vertexData.vertex.y += value2 * _WaveAmplitude2;
		vertexData.normal.y += value2 * _WaveAmplitude2;
		o.customValue +=  value2 * _WaveAmplitude2;
		}
		if (sqrt(pow(worldPos.x - _xImpact3, 2) + pow(worldPos.z - _zImpact3, 2)) < _Distance3)
		{
		vertexData.vertex.y += value3 * _WaveAmplitude3;
		vertexData.normal.y += value3 * _WaveAmplitude3;
		o.customValue += value3 * _WaveAmplitude3;
		}
		if (sqrt(pow(worldPos.x - _xImpact4, 2) + pow(worldPos.z - _zImpact4, 2)) < _Distance4)
		{
		vertexData.vertex.y += value4 * _WaveAmplitude4;
		vertexData.normal.y += value4 * _WaveAmplitude4;
		o.customValue += value4 * _WaveAmplitude4;
		}
		if (sqrt(pow(worldPos.x - _xImpact5, 2) + pow(worldPos.z - _zImpact5, 2)) < _Distance5)
		{
		vertexData.vertex.y += value5 * _WaveAmplitude5;
		vertexData.normal.y += value5 * _WaveAmplitude5;
		o.customValue += value5 * _WaveAmplitude5;
		}
		if (sqrt(pow(worldPos.x - _xImpact6, 2) + pow(worldPos.z - _zImpact6, 2)) < _Distance6)
		{
		vertexData.vertex.y += value6 * _WaveAmplitude6;
		vertexData.normal.y += value6 * _WaveAmplitude6;
		o.customValue += value6 * _WaveAmplitude6;
		}
		if (sqrt(pow(worldPos.x - _xImpact7, 2) + pow(worldPos.z - _zImpact7, 2)) < _Distance7)
		{
		vertexData.vertex.y += value7 * _WaveAmplitude7;
		vertexData.normal.y += value7 * _WaveAmplitude7;
		o.customValue += value7 * _WaveAmplitude7;
		}
		if (sqrt(pow(worldPos.x - _xImpact8, 2) + pow(worldPos.z - _zImpact8, 2)) < _Distance8)
		{
		vertexData.vertex.y += value8 * _WaveAmplitude8;
		vertexData.normal.y += value8 * _WaveAmplitude8;
		o.customValue += value8 * _WaveAmplitude8;
		}
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
