using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

[RequireComponent(typeof(Camera))]
public class DitheredImageEffect : MonoBehaviour
{
    public Color lightColor;
    public Color darkColor;

    [SerializeField, HideInInspector] private Shader shader;
    private Material material;

    void Start()
    {
        material = new Material(shader);
    }

    void OnRenderImage(RenderTexture source, RenderTexture dest)
    {
        material.SetColor("_Light", lightColor);
        material.SetColor("_Dark", darkColor);
        Graphics.Blit(source, dest, material);
    }
}
