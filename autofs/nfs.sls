{% from 'autofs/map.jinja' import autofs with context %}

{% if autofs.nfs.key != "/-" %}
create-key-mountpath-{{ autofs.nfs.key }}:
  file.directory:
    - name: {{ autofs.nfs.key }}
  {% endif %}

config-autofs-nfs:
  file.managed:
    - name: {{ autofs.nfs.file }}
    - source: salt://autofs/templates/auto.nfs.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        map: {{ autofs.nfs.map }}
