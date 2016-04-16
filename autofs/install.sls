{% from 'autofs/map.jinja' import packages with context %}

install-autofs:
  pkg.installed:
    - name: autofs

{% for pkg_list in packages %}
  {% for pkg in pkg_list %}
install-autofs-prereq-{{ pkg }}:
  pkg.installed:
    - name: {{ pkg }}
  {% endfor %}
{% endfor %}
