#!jinja|yaml

{% from "time/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('time:lookup')) %}

{% if datamap.general.set_timezone|default(True) %}
systimezone:
  timezone:
    - system
    - name: {{ datamap.general.timezone|default('Europe/Berlin') }}
    - utc: {{ datamap.general.utc|default(True) }}
{% endif %}
