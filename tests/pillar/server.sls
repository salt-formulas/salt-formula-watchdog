watchdog:
  server:
    enabled: true
    timeout: 60
    # These parametrs shoudl create file in /etc/modprobe.d/kernel_module.conf with content "option module soft_panic=1 parameter=second value_only"
    kernel:
      parameter:
        nowayout: 0

