# 「文本模式」渲染器

这是一个《我的世界》 Java 版光影包，使用 **字体** 渲染游戏场景。需安装 optifine 才能启用。

温馨提示：本光影包仅作娱乐，注意保护眼睛， **若周边无洗手间请谨慎尝试，防止呕吐** 。

## 如何修改字体

进入 `shaders/textures` 文件夹，将字体放入这个文件夹。

字体文件须为PNG或JPG格式，所有字形应像现有字体图般矩阵式排列。

添加字体文件后，编辑 `shaders/shaders.properties`，将 `texture.composite.gaux1` 值改为字体文件路径及名称。

若字体尺寸/字形数量不同，需修改代码：

同步编辑 `shaders/composite1.fsh` 和 `shaders/final.fsh`，将 `const ivec2 CharSize = ivec2(8, 16);` 替换为实际字形尺寸；将 `const ivec2 CharArrange = ivec2(16, 16);` 改为实际行列数

## 效果示例

![演示视频](https://youtu.be/dGv6yr2_Cm0)

## 截图展示

![Demo 1](Demo/1.png?raw=true)

![Demo 2](Demo/2.png?raw=true)

![Demo 3](Demo/3.png?raw=true)

## 延伸参考

https://www.shadertoy.com/view/tlfXzX

# 如何安装

确保已安装 optifine，然后打开 Minecraft 根目录（通常位于 `C:\Users\你的用户名\AppData\Roaming.minecraft`）。进入 `shaderpacks` 文件夹（如果没有，则需要手动创建），新建名为 `font-shader-1.0.0` 的子文件夹，将 `shaders` 文件夹及 `LICENSE` 文件拷贝进去。请务必阅读 `LICENSE` 文件。

# Optifine 安装说明

需先安装 [Java](https://www.java.com/)。
前往 [optifine 官网](https://optifine.net/home)下载对应的《我的世界》的 optifine 版本。

安装Java后，双击 `optifine.jar` 文件即可完成安装。
