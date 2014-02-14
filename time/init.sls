{% from "time/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('time:lookup')) %}

{% if datamap['general']['set_timezone'] %}
systimezone:
  timezone:
    - system
    - name: {{ datamap['general']['timezone'] }}
    - utc: {{ datamap['general']['utc'] }}
{% endif %}
