mesos_cfg_zk:
  file.managed:
    - name: /etc/mesos/zk
    - source: salt://mesos/master/files/zk.tmpl
    - template: jinja
    - notify_in:
      - service: mesos-master

mesos_cfg_quorum:
  file.managed:
    - name: /etc/mesos-master/quorum
    - contents:
      - "{{ salt['mine.get']('roles:mesos_master', 'network.ip_addrs', 'grain') | length - 1 }}"
    - notify_in:
      - service: mesos-master

mesos_cfg_hostname:
  file.managed:
    - name: /etc/mesos-master/hostname
    - contents:
      - "{{ grains['host'] }}"
    - notify_in:
      - service: mesos-master

mesos_cfg_ip:
  file.managed:
    - name: /etc/mesos-master/ip
    - contents:
      - "{{ salt['mine.get']('roles:mesos_master','network.ip_addrs','grain')[grains['host']][0]}}"
    - notify_in:
      - service: mesos-master
