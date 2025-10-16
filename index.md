---
layout: default
title: "Jelly Renders"
---

# Welcome to Jelly Renders

A blog documenting my journey through graphics programming, rendering, and related mathematics. Here you'll find explorations of computer graphics algorithms, mathematical concepts, and practical implementations.

## Recent Posts

{% for post in site.posts limit:5 %}
  <article class="post-list-item">
    <h2 class="post-list-title">
      <a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>
    </h2>
    
    <div class="post-list-meta">
      <time datetime="{{ post.date | date_to_xmlschema }}">
        {{ post.date | date: "%B %d, %Y" }}
      </time>
      {% if post.categories.size > 0 %}
        • 
        {% for category in post.categories %}
          <a href="{{ '/category/' | append: category | relative_url }}">{{ category }}</a>
          {% unless forloop.last %}, {% endunless %}
        {% endfor %}
      {% endif %}
    </div>
    
    {% if post.excerpt %}
      <p class="post-excerpt">{{ post.excerpt | strip_html | truncatewords: 50 }}</p>
    {% endif %}
  </article>
{% endfor %}

## Categories

{% assign categories = site.posts | map: 'categories' | flatten | uniq | sort %}
<ul>
  {% for category in categories %}
    <li><a href="{{ '/category/' | append: category | relative_url }}">{{ category }}</a></li>
  {% endfor %}
</ul>

## About This Blog

This blog explores the fascinating intersection of mathematics, computer science, and visual art. Topics include:

- **Ray Tracing**: From basic algorithms to advanced techniques
- **Mathematical Foundations**: Linear algebra, calculus, and geometry in graphics
- **Rendering Techniques**: Rasterization, global illumination, and real-time graphics
- **Implementation Details**: Code examples and performance considerations

Whether you're a student learning computer graphics, a developer working on rendering engines, or simply curious about how digital images are created, there's something here for you.

---

*"The best way to understand a rendering algorithm is to implement it yourself."*
