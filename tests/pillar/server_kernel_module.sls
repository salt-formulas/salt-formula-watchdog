watchdog:
  server:
    enabled: true
    timeout: 360
    module: softdog
linux:
  system:
    kernel:
      module:
        softdog:
          option:
            soft_panic: 1
