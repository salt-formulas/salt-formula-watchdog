{%- from "watchdog/map.jinja" import server with context %}
{%- if server.enabled %}

watchdog_packages:
  pkg.installed:
    - name: watchdog

/etc/default/watchdog:
  file.managed:
    - name: /etc/default/watchdog
    - template: jinja
    - source: salt://watchdog/files/default_watchdog
    - makedirs: True
    - require:
      - pkg: watchdog_packages
    - require_in: watchdog_service

/etc/watchdog.conf:
  file.managed:
    - name: /etc/watchdog.conf
    - template: jinja
    - source: salt://watchdog/files/watchdog.conf
    - require:
      - pkg: watchdog_packages

watchdog_service:
  service.running:
    - enable: true
    - name: watchdog
    - watch:
      - file: /etc/watchdog.conf
      - file: /etc/default/watchdog

{%- endif %}
