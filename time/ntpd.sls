{% from "time/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('time:lookup')) %}

ntpd:
  pkg:
    - installed
    - pkgs:
{% for p in datamap['ntpd']['pkgs'] %}
      - {{ p }}
{% endfor %}
  service:
    - {{ datamap['ntpd']['ensure'] }}
    - name: {{ datamap['ntpd']['servicename'] }}
    - enable: {{ datamap['ntpd']['service_enable'] }}
    - require:
      - pkg: ntpd
{% if datamap['ntpd']['configure'] %}
      - file: ntpd
  file:
    - managed
    - name: {{ datamap['ntpd']['path'] }}
    - source: {{ datamap['ntpd']['template_path'] }}
    - mode: '0644'
    - user: root
    - group: root
    - template: jinja
{% endif %}
