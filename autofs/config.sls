{% from 'autofs/map.jinja' import autofs with context %}

config-autofs-master:
  file.managed:
    - name: /etc/auto.master
    - source: salt://autofs/templates/auto.master.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja

include:
{% if 'nfs' in autofs %}
  - autofs.nfs
{% endif %}
