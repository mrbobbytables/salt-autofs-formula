{% from 'autofs/map.jinja' import autofs %}

{% if salt['test.provider']('service') == 'systemd' %}

autofs-systemd-unit-helper:
  module.wait:
    - name: service.systemctl_reload


autofs-systemd-enable-service:
  service.running:
    - name: autofs.service
    - enable: true
    - require:
      - pkg: autofs

{% else %}

autofs-enable-service:
  service.running:
    - name: autofs
    - enable: true
    - require:
      - pkg: autofs

{% endif %}
