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


*"The best way to understand a rendering algorithm is to implement it yourself."*

[Read more about this blog →](/about/)
