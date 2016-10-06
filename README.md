# salt-mesos
Saltstack formula for mesos master and slave


### Configuration - Mesos master
Each node involved in the mesos cluster as a master should have the following grains set:

```
roles:
  - mesos_master
```

- `roles:mesos_master` - used by the formula to deploy and configure mesos as a master.

Additionally, the following salt mine information should be set:

```
# From pillar/mesos_master.sls
mine_functions:
  network.ip_addrs: [eth0]
```

`eth0` - the primary interface where mesos will be listening on.

### Example `top.sls` usage
```
base:
  'G@roles:mesos_master`:
    - match: compound
    - mesos.master
```


### Configuration - Mesos slave
Each node involved in the mesos cluster as a slave should have the following grains set:

```
roles:
  - mesos_slave
```

- `roles:mesos_slave` - used by the formula to deploy and configure mesos as a slave.

Additionally, the following salt mine information should be set:

```
# From pillar/mesos_slave.sls
mine_functions:
  network.ip_addrs: [eth0]
```

`eth0` - the primary interface where mesos will be listening on.

### Example `top.sls` usage
```
base:
  'G@roles:mesos_slave`:
    - match: compound
    - mesos.slave
```
