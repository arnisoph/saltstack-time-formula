time:
  lookup:
    ntpd:
      template_path: salt://override/time/files/ntp.conf
      servers:
        - 1.de.pool.ntp.org
        - 3.de.pool.ntp.org
