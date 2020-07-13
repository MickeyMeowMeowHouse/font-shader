# Text Mode Renderer

This is a **[Minecraft](https://minecraft.net/) shader pack** which uses fonts to render the game scene. You need [optifine](https://optifine.net/home) to enable this shader.

Try it for fun, be careful of your eyes, **don't vomit if there's no toilets near you**.

# How to change font
Goto `shaders/textures` folder, add your font file into your downloaded shader folder.

Your font file format should be PNG or JPG image file, every glyphs should be arranged like a matrix (like the existing font image).

After added your font file, edit `shaders/shaders.properties`, change the value of `texture.composite.gaux1` equals to your font file path and name.

Then, if your font file have different size or glyph count, you need to edit the code.

Edit both `shaders/composite1.fsh` and `shaders/final.fsh`, change `const ivec2 CharSize = ivec2(8, 16);` to your font file glyph size, edit `const ivec2 CharArrange = ivec2(16, 16);` to your font file's rows and columns. Make sure both of the file were changed. That's all.

# Example of this shader

![Demo 1](https://github.com/0xAA55/font-shader-1.0.0/blob/master/Demo/1.png?raw=true)

![Demo 2](https://github.com/0xAA55/font-shader-1.0.0/blob/master/Demo/2.png?raw=true)

## Also check this:
https://www.shadertoy.com/view/tlfXzX

# How to install this shader pack
Make sure you had optifine installed, then goto your Minecraft folder (which often is "C:\Users\yourname\AppData\Roaming\.minecraft"), you can see there's a folder named **shaderpacks**. Open this folder, create a new subfolder named "font-shader-1.0.0", then put **"shaders"** folder and **"LICENSE"** file inside this subfolder. Be sure you had read the LICENSE file and agree with it.

# How to install optifine
You need [install Java](https://www.java.com/) first. Then goto [optifine](https://optifine.net/home) official website to download and install optifine for minecraft.

When you finished installing Java, you can just double-click optifine.jar to install optifine.
