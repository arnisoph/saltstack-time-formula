#!jinja|yaml

{% from "time/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('time:lookup')) %}

ntpd:
  pkg:
    - installed
    - pkgs: {{ datamap.ntpd.pkgs|default([]) }}
  service:
    - {{ datamap.ntpd.ensure|default('running') }}
    - name: {{ datamap.ntpd.service.name }}
    - enable: {{ datamap.ntpd.service.enable|default(True) }}
{% if datamap.ntpd.configure|default(True) %}
  file:
    - managed
    - name: {{ datamap.ntpd.path|default('/etc/ntp.conf') }}
    - source: {{ datamap.ntpd.template_path|default('salt://time/files/ntp.conf') }}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - watch:
      - service: ntpd
{% endif %}
