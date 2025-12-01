---
layout: post
title: "2D Signed Distance Fields"
date: 2025-12-02 10:00:00 -0000
tags: [ray-tracing, rendering, mathematics, computer-graphics]
author: "Jaiden Ortiz aka JellyBoonz"
---

## Introduction

During Thanksgiving eve, while my daughters ran around the house playing with their cousin, I spent the day learning about SDFs (I owe you, Becca). Signed Distance Fields (SDFs) represent geometry by answering a simple question: *How far is any point from a given shape?* Unlike defining a circle by its center and radius, or a square by its corners, SDFs provide a unified mathematical function that works for any shape. 

For each point in space, an SDF returns the shortest distance to the shape's surface—positive if outside, negative if inside, zero on the boundary. This elegant abstraction makes it trivial to combine shapes, create smooth blends, or render them efficiently.

## Making a circle

Let's start with a simple example: the SDF for a circle. Given a point $\mathbf{p}$, circle center $\mathbf{c}$, and radius $r$.

We compute the distance from the point to the circle's center, then subtract the radius:

$$f(\mathbf{p}) = |\mathbf{p} - \mathbf{c}| - r$$

Here's the implementation in code:

```wgsl
fn sdCircle(p: vec2<f32>, c: vec2<f32>, r: f32) -> f32 {
    return length(p - c) - r;
}
```

This gives us the signed distance: positive values mean the point is outside the circle, negative means inside, and zero means exactly on the boundary. The sign is what makes SDFs powerful—it automatically tells us whether we're inside or outside the shape.

![Calculate distance-to-shape per pixel](/assets/images/sdf/distance-to-point.png)

For each pixel on the screen, we calculate its distance to the shape. The SDF function tells us how far away that pixel is from the nearest point on the shape's surface.

## Rendering with SDFs

Once we have the signed distance for each pixel, we can use it to determine what to render. The sign of the distance value tells us everything we need to know.

![Color pixels within (-) the circle](/assets/images/sdf/color-pixels.png)

Pixels with negative distances are inside the shape. These are the pixels we want to color. This is the utility of the 'sign' part. The signs automatically tell us what to color. No hit tests or geometric checks.

![Pixels outside (+) remain uncolored](/assets/images/sdf/uncolored-pixels.png)

Pixels with positive distances are outside the shape, so we leave them uncolored. When the distance is exactly zero, the pixel lies precisely on the boundary of the shape.

This is the beauty of SDFs: a single mathematical function gives us both the distance and the inside/outside information we need for rendering.

## Combining Multiple Shapes

SDFs really shine when you want to combine multiple shapes. Instead of dealing with complex geometric intersections, you can simply combine the distance functions.

![Add more shapes!](/assets/images/sdf/add-shapes.png)

Each shape has its own SDF function. Here's an example of another common primitive, a box:

```wgsl
fn sdBox(p: vec2<f32>, c: vec2<f32>, size: f32) -> f32 {
    let d = abs(p - c) - vec2<f32>(size, size);
    return length(max(d, vec2<f32>(0.0))) + min(max(d.x, d.y), 0.0);
}
```

To combine shapes, you can use operations like:
- **Union**: Take the minimum of the two distances
- **Intersection**: Take the maximum of the two distances
- **Subtraction**: Combine with negation

These operations work on the distance values themselves, making it trivial to create complex scenes from simple primitives.

## Smooth Blending

In my opinion, one of the most interesting features of SDFs is the ability to smoothly blend shapes together, creating organic, fluid forms that would be difficult to achieve with traditional polygon-based approaches. Now we're sculpting with math (and a rendering pipeline, but we'll leave that off to the side for the moment).

![Morph them together with a smoothing function](/assets/images/sdf/morph.png)

Instead of using a hard minimum or maximum to combine shapes, you can use smooth blending functions. These functions create gradual transitions between shapes, resulting in smooth, blob-like morphing effects.

The smooth minimum (or "smooth union") function interpolates between the two distance values based on how close they are, creating a smooth transition zone. This is what allows SDFs to create those fluid, organic shapes you see in modern graphics. The implementation below is by [Inigo Quilez](https://iquilezles.org/articles/smin/):

```wgsl
// Author: Inigo Quilez
fn smoothMin(a: f32, b: f32, k: f32) -> f32 {
    let h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0);
    return mix(b, a, h) - k * h * (1.0 - h);
}
```

The `k` parameter controls the smoothness of the blend—larger values create wider, more gradual transitions between shapes.

## Result

When putting it all together (along with a bunch of WebGPU pipeline setup) I got the following result:

![Final rendered result](/assets/images/sdf/final-rendered-result.png)

As always, I hope you find this information useful or interesting. If you'd like to keep up on the latest, consider subscribing. Until next time!