Shader "Custom/Waves"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Wave1("Wave 1 (dir, steepness, wavelength)", Vector) = (1,1,0.25,60)
    	_Wave2("Wave 2", Vector) = (1,0.6,0.25,30)
    	_Wave3("Wave 3", Vector) = (1,1.2,0.25,15)
    	_Wave4("Wave 4", Vector) = (1,1.8,0.25,7.5)
    	_Wave5("Wave 5", Vector) = (1,2.4,0.25,3.75)
    	_Scale("Scale", float) = 1
        _Speed("Speed", float) = 1
        _Frequenzy("Frequenzy", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        //Surface Shader also uses vertex function
        #pragma surface surf Standard fullforwardshadows vertex:vert addshadow

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float4 _Wave1, _Wave2, _Wave3, _Wave4, _Wave5;
        float _Scale, _Speed, _Frequenzy;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        float3 GerstnerWave(float4 wave, float3 p, inout float3 tangent, inout float3 binormal)
        {
            float steepness = wave.z;
            float wavelength = wave.w;
            float k = 2 * UNITY_PI / wavelength; //k =  wavenumber
            float c = sqrt(9.8 / k);
            float2 d = normalize(wave.xy);
			float f = k * (dot(d, p.xz) - c * _Time.y);//for tangent Vector Calculations
            float a = steepness / k;

            // normalize Tangent Vector (x Dimension)
            tangent += float3(
				-d.x * d.x * (steepness * sin(f)),
				d.x * (steepness * cos(f)),
				-d.x * d.y * (steepness * sin(f))
			);
            //normalize Binormal Vector (z Dimension)
			binormal += float3(
				-d.x * d.y * (steepness * sin(f)),
				d.y * (steepness * cos(f)),
				-d.y * d.y * (steepness * sin(f))
			);
            return float3(
				d.x * (a * cos(f)),
				a * sin(f),
				d.y * (a * cos(f))
			);
        }
        
        //Function for Adjusting the Vertex Data
        //one parameter for in and output and "appdata_full" is Unity default vertex data structure
        void vert(inout appdata_full vertexData)
        {
            float3 gridPoint = vertexData.vertex.xyz; //Original Position of the Vertex
        	float3 tangent = float3(1,0,0);
        	float3 binormal = float3(0,0,1);
        	float3 p = gridPoint;
        	p += GerstnerWave(_Wave1, gridPoint, tangent, binormal);
        	p += GerstnerWave(_Wave2, gridPoint, tangent, binormal);
        	p += GerstnerWave(_Wave3, gridPoint, tangent, binormal);
        	p += GerstnerWave(_Wave4, gridPoint, tangent, binormal);
        	p += GerstnerWave(_Wave5, gridPoint, tangent, binormal);
            
            //Cross Product for propper normal Calculation
			float3 normal = normalize(cross(binormal, tangent)); // Normal Vector
        	
        	
            vertexData.vertex.xyz = p;
            vertexData.normal = normal;


        	//Ripple Effects
        	half offsetVert = ((vertexData.vertex.x * vertexData.vertex.x) + (vertexData.vertex.z * vertexData.vertex.z)); //Direction of Wave

            half value = _Scale * sin(_Time.w * _Speed + offsetVert * _Frequenzy); //Wave Movemnet over Time and Wave Values

        	vertexData.vertex.y += value;
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
