#!jinja|yaml

{% from "time/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('time:lookup')) %}

ntpd:
  pkg:
    - installed
    - pkgs:
{% for p in datamap.ntpd.pkgs %}
      - {{ p }}
{% endfor %}
  service:
    - {{ datamap.ntpd.ensure|default('running') }}
    - name: {{ datamap.ntpd.service.name }}
    - enable: {{ datamap.ntpd.service.enable|default(True) }}
    - require:
      - pkg: ntpd
    - watch:
{% if datamap.ntpd.configure|default(True) %}
      - file: ntpd
  file:
    - managed
    - name: {{ datamap.ntpd.path|default('/etc/ntp.conf') }}
    - source: {{ datamap.ntpd.template_path|default('salt://time/files/ntp.conf') }}
    - mode: '0644'
    - user: root
    - group: root
    - template: jinja
{% endif %}
