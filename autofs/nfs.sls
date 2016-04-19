{% from 'autofs/map.jinja' import autofs with context %}

{% for map in autofs.nfs %}
  {% if map.key != "/-" %}
create-key-mountpath-{{ map.key }}:
  file.directory:
    - name: {{ map.key }}
    - makedirs: True
  {% endif %}

config-autofs-nfs-{{ map.key }}:
  file.managed:
    - name: {{ map.file }}
    - source: salt://autofs/templates/auto.nfs.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        map: {{ map.map }}

{% endfor %}
