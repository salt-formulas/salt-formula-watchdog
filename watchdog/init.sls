{%- if pillar.watchdog is defined %}
include:
{%- if pillar.watchdog.server is defined %}
- watchdog.server
{%- endif %}
{%- endif %}
