---
layout: page
title: Categories
permalink: /categories/
---

{% assign grouped = site.posts | group_by_exp: "post", "post.categories[0]" %}
{% assign sorted_groups = grouped | sort: "name" %}
{% for group in sorted_groups %}
  <h2>{{ group.name }}</h2>
  <ul>
    {% for post in group.items %}
      <li><a href="{{ post.url }}">{{ post.title }}</a> - {{ post.date | date: "%b %d, %Y" }}</li>
    {% endfor %}
  </ul>
{% endfor %}
