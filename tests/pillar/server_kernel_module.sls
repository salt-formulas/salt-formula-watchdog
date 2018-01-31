watchdog:
  server:
    enabled: true
    timeout: 60
    kernel:
      parameter:
        soft_panic: 1
        parameter: second
        value_only: none
    module:
