---
layout: post
title: "So what even is Ray Tracing? An intuitive look."
date: 2025-01-01 10:00:00 -0000
categories: [Graphics, Ray Tracing]
tags: [ray-tracing, rendering, mathematics, computer-graphics]
author: "Jaiden Ortiz aka JellyBoonz"
---
## What is Ray Tracing?

Ray tracing is a rendering technique that simulates the path of light as it bounces around a scene. As opposed to rasterization, which projects 3D objects onto a 2D screen, ray tracing follows individual rays of light to create photorealistic images with accurate reflections, refractions, and shadows. For a good intro to ray tracing, I'd recommend you read through the Basic Raytracing chapter in Gabriel Gambetta's [book](https://gabrielgambetta.com/computer-graphics-from-scratch/02-basic-raytracing.html) Computer Graphics from Scratch. Instead of diving too deep into the nitty gritty implementation details, I thought it might be helpful to give an intuitive explanation for *why* ray tracing is such a useful tool for rendering realistic images on the screen.

## Setting the 'scene'

Imagine you're standing in a room with a single light bulb hanging from the ceiling, surrounded by different objects -- perhaps furniture, plants, or a bunch of colorful spheres. So far so good. Looking around you may notice how the light bounces off the walls, creates soft shadows in the corners, and perhaps reflects off of the different objects in the room. The way light behaves in this room isn't random; it follows the laws of physics, bouncing and scattering in predictable patterns that your brain has learned to interpret as "real".

For decades, computer graphics struggled to capture this dance of light. Early renderers could only paint flat polygons with simple shading. Think of the blocky, angular worlds of 1980s video games (Similar to Figure 1), where surfaces looked like they were made of flat material. Even as graphics improved with techniques like Gouraud and Phong shading, the results still felt artificial. Objects had highlights and shadows, but they existed in isolation, as if each surface was lit independently of everything else around it.

![Early computer graphics from Tron (1982) showing flat, stylized rendering without ray tracing](/graphics-blog/assets/images/tron-early-graphics.jpg)

*Figure 1: The iconic Light Cycles from Tron (1982) showcase the flat, stylized aesthetic of early computer graphics—objects glow rather than being illuminated by realistic light sources*

The breakthrough came when computer scientists realized they were approaching the problem backwards. Instead of asking "how do we paint this surface?" they began asking "how does light actually travel to get here?" This shift in perspective—from painting surfaces to tracing light—marked the birth of ray tracing, and it represents perhaps the most elegant solution in all of computer graphics.

Though the mathematics for tracing rays of light goes back centuries, the earliest *computational* version of ray tracing was introduced by Arthur Appel in his 1968 paper "*Some Techniques for Shading Machine Renderings of Solids*". A little over 10 years later in 1979 Turner Whitted discovered the modern form of recursive ray tracing, illustrated in his paper *An Improved Illumination Model for Shaded Display*. Quite a departure from the earlier renders, this new technique broke new ground for those who sought to simulate realistic lighting through computation.

![Image of Ray Traced Spheres](/graphics-blog/assets/images/Recursive_raytrace_of_a_sphere.png)

*Figure 2: Ray Traced Sphere example. Image credit: [Wikipedia - Ray tracing (graphics)](https://en.wikipedia.org/wiki/Ray_tracing_%28graphics%29)*

Ray tracing works by following individual photons of light as they journey through a virtual world, bouncing off surfaces, refracting through glass, and scattering in the atmosphere. Each pixel on your screen becomes a window into this simulated reality, where we cast a ray from your virtual eye through that pixel and ask: "What would you see if you looked in this exact direction?" The computer then traces that ray's journey, calculating every bounce, every reflection, every subtle interaction with the materials it encounters (or at least enough to stay effective and computationally efficient).

What makes this approach so powerful is that it mirrors how light actually works in the real world, just in reverse. When you see a reflection in a puddle, it's because light from the sky bounced off the water and into your eye. When you see a soft shadow, it's because light from the sun was blocked by an object, but some light still found its way around the edges. Ray tracing captures these phenomena naturally, not through clever tricks or approximations, but by literally simulating the physics of light itself.

The result is a rendering technique that doesn't just look more realistic—it *thinks* more like we do. For the first time in the history of computer graphics, machines began to see the world the way humans do: not as a collection of surfaces to be painted, but as a complex web of light interactions that our brains have evolved to understand. This isn't just a technical achievement; it's a conceptual revolution that bridges the gap between the abstract mathematics of computer graphics and the intuitive understanding of light that we carry with us every day.

## The Elegant Simplicity of Ray Tracing

At its heart, ray tracing is a *simple* (not to be confused with easy) solution to rendering realistic images. Think of it like this: imagine you're looking through a window at a scene outside. For every tiny square of glass in that window (each pixel on your screen), you want to know what color you'd see if you looked through that exact spot.

The ray tracing algorithm does exactly this. It takes a ray—we'll flesh that out more in just a moment—and follows it into the scene. Where does it go? What does it hit? How does the light behave when it encounters different materials?

This is where the magic happens. Unlike traditional rendering, which tries to approximate how surfaces should look, ray tracing asks the fundamental question: "What would actually happen if light traveled this path?" It's the difference between painting a picture of a sunset and actually understanding why sunsets look the way they do at a physical level.

> **Note:** I'm embellishing a little when I stress the "physical" part of ray tracing. Despite its effectivenes this is, after all, a simulation.

## What is a Ray?

The mathematical foundation of ray tracing is worth noting here. A ray is simply a line in 3D space, defined by a starting point and a direction. We can express any point along this ray with the equation:

$$
\mathbf{P}(t) = \mathbf{O} + t\mathbf{D}

$$

Here, $\mathbf{O}$ is the origin (where the ray starts), $\mathbf{D}$ is the direction (where it's pointing), and $t$ tells us how far along the ray we've traveled. When $t = 0$, we're at the starting point. When $t = 1$, we've moved one unit in the direction of $\mathbf{D}$. Imagine a tight piece of string threaded through a little ball and extending from your virtual 'eye' to some object in front of you. $\mathbf{O}$ is the starting point of the string (the position of your eye). $\mathbf{D}$ is the string and where it points toward. $t$ tells us where the ball is at along the string. As we increase $t$, the ball moves forward. Decreasing $t$ moves the ball closer to our eye. Thus, the distance that the tip of the ray extends is dependent on the position of the ball.

Now that we have a way to mathematically describe any point along our ray, we can answer the fundamental question: what does our ray actually hit? This is where the elegance of ray tracing becomes apparent—instead of trying to approximate how surfaces should look based on some set of rules, we simply follow the path of light and see what it encounters.

## Intersecting with the World

Now comes the challenging part: how do we find out what our ray hits? Let's keep it simple

Consider a sphere. In the real world, if you shine a flashlight at a ball, the light either hits it or misses it. Now, how do we tell the computer when the light has hit the ball? We want to find where our ray intersects with the sphere's surface. Following our illustration of the string and the ball, we want to find the distance along the string that the ball has to travel in order to touch the surface of our sphere.

To do this, we need a way to describe what points belong to the sphere. The key insight is that every point on a sphere is exactly the same distance from its center. If we call the center $\mathbf{C}$ and the radius $r$, then any point $\mathbf{P}$ on the sphere satisfies:

$$
|\mathbf{P} - \mathbf{C}|^2 = r^2

$$

We think of $|\mathbf{P} - \mathbf{C}|$ as another ray, whose squared distance is equal to the squared radius of the sphere.

Now, here's where the magic happens. We want to find the point on our ray that also lies on the sphere's surface. In other words, we want to find the value of $t$ (*remember:* the distance that the ball has traveled along the string) where the point $\mathbf{P}(t) = \mathbf{O} + t\mathbf{D}$ satisfies the sphere equation. We want to find where the point along the ray meets the point along the sphere. If the both meet, then the points are the exact same! Given that, we can substitute our ray equation into the sphere equation:

$$
|\mathbf{O} + t\mathbf{D} - \mathbf{C}|^2 = r^2

$$

This looks complicated, but it's actually just asking: "At what distance $t$ along our ray are we exactly $r$ units away from the sphere's center?" or "How far along the string do we need to move the ball before it touches the surface of the sphere?"

With a bit of algebraic manipulation, this becomes a quadratic equation—the same type of equation you learned in high school algebra. We solve this equation to find the discriminant which tells us everything we need to know: if it's positive, the ray hits the sphere and we get two solutions (Why two? one for each side of the sphere. Because its not a physical sphere, the ray can just pass right through. Again. Simulation.). If it's zero, the ray just grazes the sphere at a single point. If it's negative, the ray misses entirely.

> The discriminant is given by:
>
> $$
> \Delta = b^2 - 4ac
>
> $$
>
> Where for our ray-sphere intersection:
>
> - $a = |\mathbf{D}|^2$ (usually 1 if the ray direction is normalized)
> - $b = 2(\mathbf{L} \cdot \mathbf{D})$ where $\mathbf{L} = \mathbf{O} - \mathbf{C}$
> - $c = |\mathbf{L}|^2 - r^2$

What's beautiful about this is that the mathematics directly corresponds to our visual intuition. The quadratic equation isn't just a mathematical trick—it's the natural language for describing how rays interact with spheres.

## The Dance of Light and Materials

So we now when our ray hits. Now what? How does the light behave when it encounters different materials? This is where ray tracing truly shines (in a figurative **and** literal sense now that I think about it. Cool. Sometimes I surprise myself), because it can simulate the full complexity of light-matter interactions.

Think about the difference between a mirror and a piece of paper. When light hits a mirror, it bounces off in a predictable direction—like a ball bouncing off a wall. When light hits paper, it scatters in all directions, creating the soft, diffuse appearance we associate with matte surfaces.

Ray tracing captures this by following the light's journey after it hits a surface. For a mirror, we calculate the reflection direction using the law of reflection (angle of incidence equals angle of reflection). For a glass surface, we use Snell's law to calculate how the light bends as it enters and exits the material.

And here's the kicker: it can follow multiple paths simultaneously. When light hits a partially reflective surface (like water or glass), some of it reflects and some of it refracts. Thankfully, we can handle this by casting multiple rays—one for reflection, one for refraction—and combining their contributions.

## The Recursive Beauty of Light

This is where ray tracing reveals its most elegant aspect: recursion. When a ray hits a reflective surface, we don't just calculate a simple reflection. We cast a *new ray* in the reflection direction and ask: "What would this reflected ray see?" This new ray might hit another surface, which might be reflective too, creating a chain of reflections that can go on indefinitely.

It's like looking into a hall of mirrors—each reflection shows you what the mirror "sees," which might be another mirror, which shows you what *that* mirror sees, and so on. The mathematics handles this recursion naturally, with each level of reflection adding to the final image.

This recursive approach is integral (no. Not *that* integral) for creating realistic images. It's not just simulating light—it's simulating the entire web of light interactions that create the rich, complex appearance of the real world.

## The Computational Challenge

Of course, this elegance comes at a cost. Following every possible path of light through a complex scene is computationally expensive. Each pixel may require hundreds or thousands of ray calculations, and each ray might spawn multiple child rays through reflections and refractions.

![A ray-traced interior scene showing realistic lighting, reflections, and shadows](/graphics-blog/assets/images/ray_traced_room.png)
*Figure 3: A modern ray-traced scene demonstrating the photorealistic results achievable despite computational complexity. Image credit: [NVIDIA Developer Blog](https://developer.nvidia.com/blog/wp-content/uploads/2018/06/ray_traced_room.png)*

But this computational challenge has led to some pretty remarkable algorithms in computer graphics. Spatial data structures like bounding volume hierarchies help us quickly determine which objects a ray might intersect. Importance sampling techniques help us focus computational resources on the most visually significant light paths. And modern hardware acceleration makes real-time ray tracing possible for the first time in history.

## The Conceptual Revolution

What makes ray tracing so revolutionary isn't just its technical achievements—it's the conceptual shift it represents. For the first time, computer graphics stopped trying to approximate reality and started simulating the actual physics of light.

This shift has profound implications. It means that the same mathematical principles that govern light in the real world can be used to create virtual worlds. It means that the techniques we develop for computer graphics can inform our understanding of optics and vision. And it means that the boundary between simulation and reality becomes increasingly blurred.

This is why ray tracing feels so natural and convincing. It's not trying to fool us into thinking we're seeing reality—it's actually using the same principles that are observed in our reality to create light and shadow, reflection and refraction, the subtle interplay of materials and illumination that our brains have evolved to understand.

The light that illuminates our virtual worlds is in some ways the same light that illuminates our real ones. Kinda cool.

---

*For those interested in diving deeper into the mathematical foundations, I recommend Gabriel Gambetta's excellent [Computer Graphics from Scratch](https://gabrielgambetta.com/computer-graphics-from-scratch/02-basic-raytracing.html), which provides a gentle introduction to the implementation details of ray tracing.*

## Further Reading

- Appel, A. (1968). *Some Techniques for Shading Machine Renderings of Solids.*
  Proceedings of the AFIPS Spring Joint Computer Conference (Vol. 32, pp. 37–45).
- Whitted, T. (1980).*An Improved Illumination Model for Shaded Display.*
  Communications of the ACM, 23(6), 343–349.
