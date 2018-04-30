watchdog:
  server:
    enabled: true
    timeout: 360
    ping:
      1: 127.0.0.1
      2: 0.0.0.0
    ping_nic:
      1: lo
    max_load_1: 100
