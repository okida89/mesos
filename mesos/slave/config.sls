mesos_cfg_master:
  file.managed:
    - name: /etc/mesos/zk
    - source: salt://mesos/slave/files/zk.tmpl
    - template: jinja
    - notify_in:
      - service: mesos-slave

mesos_cfg_hostname:
  file.managed:
    - name: /etc/mesos-slave/hostname
    - contents:
      - "{{ grains['host'] }}"
    - notify_in:
      - service: mesos-slave

mesos_cfg_ip:
  file.managed:
    - name: /etc/mesos-slave/ip
    - contents:
      - "{{ salt['mine.get']('roles:mesos_slave','network.ip_addrs','grain')[grains['host']][0]}}"
    - notify_in:
      - service: mesos-slave
