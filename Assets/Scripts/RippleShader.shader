Shader "Custom/RippleShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
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
        #pragma surface surf Standard fullforwardshadows vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        float _Scale, _Speed, _Frequenzy;
        float _WaveAmplitude1, _WaveAmplitude2, _WaveAmplitude3, _WaveAmplitude4, _WaveAmplitude5, _WaveAmplitude6, _WaveAmplitude7, _WaveAmplitude8;
        float _OffsetX1, _OffsetZ1, _OffsetX2, _OffsetZ2, _OffsetX3, _OffsetZ3, _OffsetX4, _OffsetZ4, _OffsetX5, _OffsetZ5, _OffsetX6, _OffsetZ6,
                _OffsetX7, _OffsetZ7, _OffsetX8, _OffsetZ8;
        struct Input
        {
            float2 uv_MainTex;
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

        void vert(inout appdata_full vertexData)
        {
            half offsetVertex = vertexData.vertex.x * vertexData.vertex.x + vertexData.vertex.z * vertexData.vertex.z; //Direction of Wave

            //Wave Movemnet over Time and Wave Values
            half value1 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX1) + (vertexData.vertex.z * _OffsetZ1));
            half value2 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX2) + (vertexData.vertex.z * _OffsetZ2));
            half value3 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX3) + (vertexData.vertex.z * _OffsetZ3));
            half value4 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX4) + (vertexData.vertex.z * _OffsetZ4));
            half value5 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX5) + (vertexData.vertex.z * _OffsetZ5));
            half value6 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX6) + (vertexData.vertex.z * _OffsetZ6));
            half value7 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX7) + (vertexData.vertex.z * _OffsetZ7));
            half value8 = _Scale * sin(_Time.w * _Speed * _Frequenzy + offsetVertex + (vertexData.vertex.x * _OffsetX8) + (vertexData.vertex.z * _OffsetZ8));
            
            vertexData.vertex.y += value1 *_WaveAmplitude1;
            vertexData.normal.y += value1 * _WaveAmplitude1;
            
            vertexData.vertex.y += value2 *_WaveAmplitude2;
            vertexData.normal.y += value2 * _WaveAmplitude2;
            
            vertexData.vertex.y += value3 *_WaveAmplitude3;
            vertexData.normal.y += value3 * _WaveAmplitude3;
            
            vertexData.vertex.y += value4 *_WaveAmplitude4;
            vertexData.normal.y += value4 * _WaveAmplitude4;
            
            vertexData.vertex.y += value5 *_WaveAmplitude5;
            vertexData.normal.y += value5 * _WaveAmplitude5;
            
            vertexData.vertex.y += value6 *_WaveAmplitude6;
            vertexData.normal.y += value6 * _WaveAmplitude6;
            
            vertexData.vertex.y += value7 *_WaveAmplitude7;
            vertexData.normal.y += value7 * _WaveAmplitude7;
            
            vertexData.vertex.y += value8 *_WaveAmplitude8;
            vertexData.normal.y += value8 * _WaveAmplitude8;
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
