{% from 'autofs/map.jinja' import autofs %}

{% if salt['test.provider']('service') == 'systemd' %}

autofs-systemd-unit-helper:
  module.wait:
    - name: service.systemctl_reload


autofs-systemd-enable-service:
  service.running:
    - name: autofs.service
    - reload: true
    - enable: true
    - require:
      - pkg: autofs
    - watch:
{% for key, value in autofs.iteritems() %}
  {% for map in value %}
      - file: {{ map.file }}
  {% endfor %}
{% endfor %}

{% else %}

autofs-enable-service:
  service.running:
    - name: autofs
    - reload: true
    - enable: true
    - require:
      - pkg: autofs
    - watch:
{% for key, value in autofs.iteritems() %}
  {% for map in value %}
      - file: {{ map.file }}
  {% endfor %}
{% endfor %}

{% endif %}
