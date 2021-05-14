# unity-dithered-shaders
1-bit dithered shaders for Unity.

For per-material dithering, see
[DitheredSurfaceShader.shader](https://github.com/garden-nomes/unity-dithered-shaders/blob/main/DitheredSurfaceShader.shader).
(This currently only works with a single light source.) You can even use a custom texture/bumpmap, although it'll only
influence shading—not the final color.

To apply the dithered effect across the whole scene, attach
[DitheredImageEffect.cs](https://github.com/garden-nomes/unity-dithered-shaders/blob/main/Runtime/DitheredImageEffect.cs)
to your camera.

For crunchier pixels, use in conjunction with the pixel-perfect camera component and tick the "upscale render texture" box.

---

![animated gif showing the dithered effect being used to render a weird, surreal landscape](https://github.com/garden-nomes/unity-dithered-shaders/raw/main/gif_animation_002.gif)

"Both hideous and impressive at the same time" — [1LargeAdult, on Reddit](https://www.reddit.com/r/Unity3D/comments/lym5g8/i_just_love_dithering_so_damn_much_testing_out_a/gptn071?utm_source=share&utm_medium=web2x&context=3)
