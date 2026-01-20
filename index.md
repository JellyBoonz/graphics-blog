---
layout: default
title: "Jelly Renders"
---

# Welcome to Jelly Renders

A blog documenting my journey through graphics programming, rendering, and related mathematics. Here you'll find explorations of computer graphics algorithms, mathematical concepts, and practical implementations.

## Recent Posts
---
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
    
    {% if post.content %}
      {% assign all_paragraphs = post.content | split: '<p>' %}
      {% assign first_paragraph_content = '' %}
      {% for paragraph in all_paragraphs %}
        {% if paragraph contains '</p>' %}
          {% assign para_text = paragraph | split: '</p>' | first | strip_html | strip %}
          {% unless para_text == '' %}
            {% unless para_text contains '<h1' or para_text contains '<h2' or para_text contains '<h3' or para_text contains '<h4' or para_text contains '<h5' or para_text contains '<h6' %}
              {% if first_paragraph_content == '' %}
                {% assign first_paragraph_content = para_text %}
                {% break %}
              {% endif %}
            {% endunless %}
          {% endunless %}
        {% endif %}
      {% endfor %}
      {% if first_paragraph_content != '' %}
        <p class="post-excerpt">{{ first_paragraph_content | truncatewords: 50 }}</p>
      {% else %}
        {% assign fallback = post.content | strip_html | strip | truncatewords: 50 %}
        {% if fallback != '' %}
          <p class="post-excerpt">{{ fallback }}</p>
        {% endif %}
      {% endif %}
    {% endif %}
  </article>
{% endfor %}


*“May you live every day of your life.”  -- Johnathan Swift*

[Read more about this blog →]({{ '/about/' | relative_url }})