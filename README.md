# unity-dithered-shaders
1-bit dithered shaders for Unity.

For per-material dithering, see
[DitheredSurfaceShader.shader](https://github.com/garden-nomes/unity-dithered-shaders/blob/main/DitheredSurfaceShader.shader).
You can even use a custom texture/bumpmap, although it'll only influence shading—not the final color.
(This currently only works with a single light source.)

To apply the dithered effect across the whole scene, attach
[DitheredImageEffect.cs](https://github.com/garden-nomes/unity-dithered-shaders/blob/main/Runtime/DitheredImageEffect.cs)
to your camera.
