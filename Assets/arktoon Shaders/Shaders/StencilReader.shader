// Copyright (c) 2018 synqark
//
// This code and repos（https://github.com/synqark/Arktoon-Shader) is under MIT licence, see LICENSE
//
// 本コードおよびリポジトリ（https://github.com/synqark/Arktoon-Shader) は MIT License を使用して公開しています。
// 詳細はLICENSEか、https://opensource.org/licenses/mit-license.php を参照してください。
Shader "arktoon/Stencil/Reader" {
    Properties {
        // Culling
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("[Advanced] Cull", Float) = 2 // Back
        // Common
        _MainTex ("[Common] Base Texture", 2D) = "white" {}
        _Color ("[Common] Base Color", Color) = (1,1,1,1)
        _BumpMap ("[Common] Normal map", 2D) = "bump" {}
        _BumpScale ("[Common] Normal scale", Range(0,2)) = 1
        _EmissionMap ("[Common] Emission map", 2D) = "white" {}
        _EmissionColor ("[Common] Emission Color", Color) = (0,0,0,1)
        // Shadow (received from DirectionalLight, other Indirect(baked) Lights, including SH)
        _Shadowborder ("[Shadow] border ", Range(0, 1)) = 0.6
        _ShadowborderBlur ("[Shadow] border Blur", Range(0, 1)) = 0.05
        _ShadowStrength ("[Shadow] Strength", Range(0, 1)) = 0.5
        _ShadowStrengthMask ("[Shadow] Strength Mask", 2D) = "white" {}
        // Shadow steps
        [Toggle(USE_SHADOW_STEPS)]_ShadowUseStep ("[Shadow] use step", Float ) = 0
        _ShadowSteps("[Shadow] steps between borders", Range(2, 10)) = 4
        // PointShadow (received from Point/Spot Lights as Pixel/Vertex Lights)
        _PointShadowStrength ("[PointShadow] Strength", Range(0, 1)) = 0.5
        _PointShadowborder ("[PointShadow] border ", Range(0, 1)) = 0
        _PointShadowborderBlur ("[PointShadow] border Blur", Range(0, 1)) = 0.05
        // Plan B
        [Toggle(USE_SHADE_TEXTURE)]_ShadowPlanBUsePlanB ("[Plan B] Use Plan B", Float ) = 0
        _ShadowPlanBDefaultShadowMix ("[Plan B] Shadow mix", Range(0, 1)) = 1
        [Toggle(USE_CUSTOM_SHADOW_TEXTURE)] _ShadowPlanBUseCustomShadowTexture ("[Plan B] Use Custom Shadow Texture", Float ) = 0
        _ShadowPlanBHueShiftFromBase ("[Plan B] Hue Shift From Base", Range(-1, 1)) = 0
        _ShadowPlanBSaturationFromBase ("[Plan B] Saturation From Base", Range(0, 2)) = 1
        _ShadowPlanBValueFromBase ("[Plan B] Value From Base", Range(0, 2)) = 1
        _ShadowPlanBCustomShadowTexture ("[Plan B] Custom Shadow Texture", 2D) = "black" {}
        _ShadowPlanBCustomShadowTextureRGB ("[Plan B] Custom Shadow Texture RGB", Color) = (1,1,1,1)
        // ShadowPlanB-2
        [Toggle(USE_CUSTOM_SHADOW_2ND)]_CustomShadow2nd ("[Plan B-2] CustomShadow2nd", Float ) = 0
        _ShadowPlanB2border ("[Plan B-2] border ", Range(0, 1)) = 0.55
        _ShadowPlanB2borderBlur ("[Plan B-2] border Blur", Range(0, 1)) = 0.55
        [Toggle(USE_CUSTOM_SHADOW_TEXTURE_2ND)] _ShadowPlanB2UseCustomShadowTexture ("[Plan B-2] Use Custom Shadow Texture", Float ) = 0
        _ShadowPlanB2HueShiftFromBase ("[Plan B-2] Hue Shift From Base", Range(-1, 1)) = 0
        _ShadowPlanB2SaturationFromBase ("[Plan B-2] Saturation From Base", Range(0, 2)) = 1
        _ShadowPlanB2ValueFromBase ("[Plan B-2] Value From Base", Range(0, 2)) = 1
        _ShadowPlanB2CustomShadowTexture ("[Plan B-2] Custom Shadow Texture", 2D) = "black" {}
        _ShadowPlanB2CustomShadowTextureRGB ("[Plan B-2] Custom Shadow Texture RGB", Color) = (1,1,1,1)

        // Gloss
        [Toggle(USE_GLOSS)]_UseGloss ("[Gloss] Enabled", Float) = 0
        _GlossBlend ("[Gloss] Blend", Range(0, 1)) = 1
        _GlossBlendMask ("[Gloss] Blend Mask", 2D) = "white" {}
        _GlossPower ("[Gloss] Power", Range(0, 1)) = 0.5
        _GlossColor ("[Gloss] Color", Color) = (1,1,1,1)
        // Outline
        [Toggle(USE_OUTLINE)]_UseOutline ("[Outline] Enabled", Float) = 0
        _OutlineWidth ("[Outline] Width", Range(0, 0.03)) = 0.0005
        _OutlineWidthMask ("[Outline] Width Mask", 2D) = "white" {}
        _OutlineColor ("[Outline] Color", Color) = (0,0,0,1)
        _OutlineTextureColorRate ("[Outline] Texture Color Rate", Range(0, 1)) = 0.05
        // MatCap
        [Toggle(USE_MATCAP)]_UseMatcap ("[MatCap] Enabled", Float) = 0
        [KeywordEnum(Add, Lighten, Screen)] _MatcapBlendMode ("[MatCap] Blend Mode", Float) = 0
        _MatcapBlend ("[MatCap] Blend", Range(0, 3)) = 1
        _MatcapBlendMask ("[MatCap] Blend Mask", 2D) = "white" {}
        _MatcapNormalMix ("[MatCap] Normal map mix", Range(0, 2)) = 1
        _MatcapShadeMix ("[MatCap] Shade Mix", Range(0, 1)) = 0
        _MatcapTexture ("[MatCap] Texture", 2D) = "black" {}
        _MatcapColor ("[MatCap] Color", Color) = (1,1,1,1)
        // Reflection
        [Toggle(USE_REFLECTION)]_UseReflection ("[Reflection] Enabled", Float) = 0
        _ReflectionReflectionPower ("[Reflection] Reflection Power", Range(0, 1)) = 1
        _ReflectionReflectionMask ("[Reflection] Reflection Mask", 2D) = "white" {}
        _ReflectionNormalMix ("[Reflection] Normal Map Mix", Range(0,2)) = 1
        _ReflectionShadeMix ("[Reflection] Shade Mix", Range(0, 1)) = 0
        _ReflectionCubemap ("[Reflection] Cubemap", Cube) = "_Skybox" {}
        _ReflectionRoughness ("[Reflection] Roughness", Range(0, 1)) = 0
        // Rim
        [Toggle(USE_RIM)]_UseRim ("[Rim] Enabled", Float) = 0
        _RimBlend ("[Rim] Blend", Range(0, 3)) = 1
        _RimBlendMask ("[Rim] Blend Mask", 2D) = "white" {}
        _RimShadeMix("[Rim] Shade Mix", Range(0, 1)) = 0
        _RimFresnelPower ("[Rim] Fresnel Power", Range(0, 10)) = 1
        _RimColor ("[Rim] Color", Color) = (1,1,1,1)
        _RimTexture ("[Rim] Texture", 2D) = "white" {}
        [MaterialToggle] _RimUseBaseTexture ("[Rim] Use Base Texture", Float ) = 0
        // ShadowCap
        [Toggle(USE_SHADOWCAP)]_UseShadowCap ("[ShadowCap] Enabled", Float) = 0
        [KeywordEnum(Darken, Multiply)] _ShadowCapBlendMode ("[ShadowCap] Blend Mode", Float) = 0
        _ShadowCapBlend ("[ShadowCap] Blend", Range(0, 3)) = 1
        _ShadowCapBlendMask ("[ShadowCap] Blend Mask", 2D) = "white" {}
        _ShadowCapNormalMix ("[ShadowCap] Normal map mix", Range(0, 2)) = 1
        _ShadowCapTexture ("[ShadowCap] Texture", 2D) = "white" {}
        _ShadowCapColor ("[ShadowCap] Color", Color) = (1,1,1,1)
        // Stencil(Reader)
        _StencilNumber ("[StencilReader] Number", int) = 5
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompareAction ("[StencilReader] Compare Action", int) = 6
        // advanced tweaking
        _OtherShadowAdjust ("[Advanced] Other Mesh Shadow Adjust", Range(-0.2, 0.2)) = -0.1
        _OtherShadowBorderSharpness ("[Advanced] Other Mesh Shadow Border Sharpness", Range(1, 5)) = 3
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull [_Cull]

            Stencil {
                Ref [_StencilNumber]
                Comp [_StencilCompareAction]
            }

            CGPROGRAM
            #pragma shader_feature USE_SHADE_TEXTURE
            #pragma shader_feature USE_GLOSS
            #pragma shader_feature USE_MATCAP
            #pragma shader_feature USE_REFLECTION
            #pragma shader_feature USE_RIM
            #pragma shader_feature USE_SHADOWCAP
            #pragma shader_feature USE_CUSTOM_SHADOW_TEXTURE
            #pragma shader_feature USE_SHADOW_STEPS
            #pragma shader_feature USE_CUSTOM_SHADOW_2ND
            #pragma shader_feature USE_CUSTOM_SHADOW_TEXTURE_2ND

            #pragma multi_compile _MATCAPBLENDMODE_ADD _MATCAPBLENDMODE_LIGHTEN _MATCAPBLENDMODE_SCREEN
            #pragma multi_compile _SHADOWCAPBLENDMODE_DARKEN _SHADOWCAPBLENDMODE_MULTIPLY

            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0

            #include "cginc/arkludeVertOther.cginc"
            #include "cginc/arkludeFrag.cginc"
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Cull [_Cull]
            Blend One One

            Stencil {
                Ref [_StencilNumber]
                Comp [_StencilCompareAction]
            }

            CGPROGRAM
            #pragma shader_feature USE_GLOSS
            #pragma shader_feature USE_SHADOWCAP
            #pragma shader_feature USE_RIM
            #pragma shader_feature USE_MATCAP
            #pragma multi_compile _MATCAPBLENDMODE_LIGHTEN _MATCAPBLENDMODE_ADD _MATCAPBLENDMODE_SCREEN
            #pragma multi_compile _SHADOWCAPBLENDMODE_DARKEN _SHADOWCAPBLENDMODE_MULTIPLY

            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0

            #include "cginc/arkludeAdd.cginc"
            ENDCG
        }

        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front

            Stencil {
                Ref [_StencilNumber]
                Comp [_StencilCompareAction]
            }

            CGPROGRAM
            #pragma shader_feature USE_OUTLINE
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0

            #include "cginc/arkludeOutline.cginc"
            ENDCG
        }

        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull [_Cull]

            Stencil {
                Ref [_StencilNumber]
                Comp [_StencilCompareAction]
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Standard"
    CustomEditor "ArktoonShaders.ArktoonInspector"
}