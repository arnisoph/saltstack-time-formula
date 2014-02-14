{% from "time/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('time:lookup')) %}

ntpdate:
  pkg:
    - installed
    - pkgs:
{% for p in datamap['ntpdate']['pkgs'] %}
      - {{ p }}
{% endfor %}
