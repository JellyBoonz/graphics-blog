---
layout: post
title: "Introduction to Ray Tracing"
date: 2025-01-01 10:00:00 -0000
categories: [Graphics, Ray Tracing]
tags: [ray-tracing, rendering, mathematics, computer-graphics]
author: "Your Name"
---

Ray tracing is a rendering technique that simulates the path of light as it bounces around a scene. Unlike rasterization, which projects 3D objects onto a 2D screen, ray tracing follows individual rays of light to create photorealistic images with accurate reflections, refractions, and shadows.

## The Basic Algorithm

At its core, ray tracing follows a simple principle: for each pixel on the screen, cast a ray from the camera through that pixel into the scene, and see what it hits.

### Ray-Sphere Intersection

One of the fundamental operations in ray tracing is determining if a ray intersects with a sphere. Given a ray with origin $\mathbf{O}$ and direction $\mathbf{D}$, and a sphere with center $\mathbf{C}$ and radius $r$, we can solve for the intersection using the quadratic formula.

The ray equation is:
$$\mathbf{P}(t) = \mathbf{O} + t\mathbf{D}$$

For a sphere, we need to find where:
$$|\mathbf{P}(t) - \mathbf{C}|^2 = r^2$$

Substituting and expanding:
$$(\mathbf{O} + t\mathbf{D} - \mathbf{C}) \cdot (\mathbf{O} + t\mathbf{D} - \mathbf{C}) = r^2$$

Let $\mathbf{L} = \mathbf{O} - \mathbf{C}$, then:
$$(\mathbf{L} + t\mathbf{D}) \cdot (\mathbf{L} + t\mathbf{D}) = r^2$$

Expanding the dot product:
$$|\mathbf{L}|^2 + 2t(\mathbf{L} \cdot \mathbf{D}) + t^2|\mathbf{D}|^2 = r^2$$

Rearranging into standard quadratic form:
$$t^2|\mathbf{D}|^2 + 2t(\mathbf{L} \cdot \mathbf{D}) + (|\mathbf{L}|^2 - r^2) = 0$$

Since $\mathbf{D}$ is typically normalized ($|\mathbf{D}| = 1$), this simplifies to:
$$t^2 + 2t(\mathbf{L} \cdot \mathbf{D}) + (|\mathbf{L}|^2 - r^2) = 0$$

## Implementation Example

Here's a simple C++ implementation of ray-sphere intersection:

```cpp
struct Ray {
    Vec3 origin;
    Vec3 direction;
    
    Ray(const Vec3& o, const Vec3& d) : origin(o), direction(d) {}
    
    Vec3 at(float t) const {
        return origin + t * direction;
    }
};

struct Sphere {
    Vec3 center;
    float radius;
    
    Sphere(const Vec3& c, float r) : center(c), radius(r) {}
};

bool intersect(const Ray& ray, const Sphere& sphere, float& t) {
    Vec3 L = ray.origin - sphere.center;
    float a = dot(ray.direction, ray.direction);  // Should be 1.0 if normalized
    float b = 2.0f * dot(L, ray.direction);
    float c = dot(L, L) - sphere.radius * sphere.radius;
    
    float discriminant = b * b - 4 * a * c;
    
    if (discriminant < 0) {
        return false;  // No intersection
    }
    
    float t1 = (-b - sqrt(discriminant)) / (2 * a);
    float t2 = (-b + sqrt(discriminant)) / (2 * a);
    
    // Return the closest positive intersection
    if (t1 > 0) {
        t = t1;
        return true;
    } else if (t2 > 0) {
        t = t2;
        return true;
    }
    
    return false;  // Intersection behind the ray origin
}
```

## Surface Normals and Lighting

Once we find an intersection, we need to calculate the surface normal for lighting calculations. For a sphere, the normal at any point on the surface is simply the vector from the sphere center to that point, normalized:

```cpp
Vec3 calculateNormal(const Vec3& point, const Sphere& sphere) {
    return normalize(point - sphere.center);
}
```

## Basic Phong Lighting Model

The Phong lighting model combines three components:

1. **Ambient**: Constant lighting to simulate global illumination
2. **Diffuse**: Lambertian reflection based on the surface normal and light direction
3. **Specular**: Mirror-like reflection for shiny surfaces

The combined lighting equation is:
$$I = I_a k_a + I_d k_d (\mathbf{N} \cdot \mathbf{L}) + I_s k_s (\mathbf{R} \cdot \mathbf{V})^n$$

Where:
- $I_a, I_d, I_s$ are ambient, diffuse, and specular light intensities
- $k_a, k_d, k_s$ are ambient, diffuse, and specular material coefficients
- $\mathbf{N}$ is the surface normal
- $\mathbf{L}$ is the light direction
- $\mathbf{R}$ is the reflection vector
- $\mathbf{V}$ is the view direction
- $n$ is the shininess exponent

## Reflection and Refraction

Ray tracing excels at handling reflection and refraction through recursive ray casting:

```cpp
Color trace(const Ray& ray, const Scene& scene, int depth) {
    if (depth <= 0) return Color::black();
    
    HitInfo hit;
    if (scene.intersect(ray, hit)) {
        Color color = hit.material.ambient * scene.ambientLight;
        
        // Add lighting from all light sources
        for (const auto& light : scene.lights) {
            Vec3 lightDir = normalize(light.position - hit.point);
            float distance = length(light.position - hit.point);
            
            // Shadow ray
            Ray shadowRay(hit.point + hit.normal * 0.001f, lightDir);
            if (!scene.intersect(shadowRay, distance)) {
                // Diffuse lighting
                float diffuse = max(0.0f, dot(hit.normal, lightDir));
                color += hit.material.diffuse * light.color * diffuse;
                
                // Specular lighting
                Vec3 reflectDir = reflect(-lightDir, hit.normal);
                Vec3 viewDir = normalize(-ray.direction);
                float specular = pow(max(0.0f, dot(reflectDir, viewDir)), 
                                   hit.material.shininess);
                color += hit.material.specular * light.color * specular;
            }
        }
        
        // Reflection
        if (hit.material.reflectivity > 0) {
            Vec3 reflectDir = reflect(ray.direction, hit.normal);
            Ray reflectRay(hit.point + hit.normal * 0.001f, reflectDir);
            Color reflectColor = trace(reflectRay, scene, depth - 1);
            color += reflectColor * hit.material.reflectivity;
        }
        
        return color;
    }
    
    return scene.backgroundColor;
}
```

## Performance Considerations

Ray tracing is computationally expensive because:

1. **Ray-object intersections**: Each ray must be tested against every object in the scene
2. **Recursive rays**: Reflections and refractions create additional rays
3. **Sampling**: Anti-aliasing requires multiple rays per pixel

Common optimizations include:

- **Bounding Volume Hierarchies (BVH)**: Spatial data structures to reduce intersection tests
- **Early ray termination**: Stop tracing when contributions become negligible
- **Importance sampling**: Focus computational resources on the most important rays

## Conclusion

Ray tracing provides a physically-based approach to rendering that naturally handles complex lighting phenomena. While computationally intensive, modern hardware acceleration and algorithmic improvements have made real-time ray tracing feasible for many applications.

The mathematical foundations are elegant and intuitive, making ray tracing an excellent starting point for understanding computer graphics and rendering algorithms.

![Ray tracing diagram showing camera, rays, and sphere intersection](/assets/images/ray-tracing-diagram.png)
*Figure 1: Basic ray tracing setup showing camera rays intersecting with a sphere*

## Further Reading

- "Physically Based Rendering" by Pharr, Jakob, and Humphreys
- "Real-Time Rendering" by Akenine-Möller, Haines, and Hoffman
- The original ray tracing paper by Turner Whitted (1980)
