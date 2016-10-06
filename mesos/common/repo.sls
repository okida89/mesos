install_mesos_repo:
{% if grains['os_family'] == 'Debian' %}
  pkgrepo.managed:
    - name: deb http://repos.mesosphere.com/ubuntu {{ grains.get('lsb_distrib_codename') }} main
    - dist: {{ grains.get('lsb_distrib_codename') }}
    - file: /etc/apt/sources.list.d/mesosphere.list
    - keyid: E56151BF
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: install_mesos
{% elif grains['os_family'] == 'RedHat' %}
  pkg.installed:
    - sources:
      - mesosphere-el-repo: http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
    - require_in:
      - pkg: install_mesos
{% endif %}