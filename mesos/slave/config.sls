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

mesos_cfg_containerizers:
  file.managed:
    - name: /etc/mesos-slave/containerizers
    - contents:
      - "{{ salt['pillar.get']('mesos-slave:containerizers', 'mesos') }}"
    - notify_in:
      - service: mesos-slave

mesos_cfg_executor_registration_timeout:
  file.managed:
    - name: /etc/mesos-slave/executor_registration_timeout
    - contents:
      - "{{ salt['pillar.get']('mesos-slave:registration_timeout', '5mins') }}"
    - notify_in:
      - service: mesos-slave
