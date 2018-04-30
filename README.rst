
==================================
Watchdog Formula
==================================

The Linux kernel can reset the system if serious problems are detected. This can
be implemented via special watchdog hardware, or via a slightly less reliable
software-only watchdog inside the kernel. Either way, there needs to be a daemon
that tells the kernel the system is working fine. If the daemon stops doing that,
the system is reset.

watchdog is such a daemon. It opens `/dev/watchdog`, and keeps writing to it
often enough to keep the kernel from resetting, at least once per minute. Each
write delays the reboot time another minute. After a minute of inactivity the
watchdog hardware will cause the reset. In the case of the software watchdog the
ability to reboot will depend on the state of the machines and interrupts.

This formula installs and configure watchdog daemon

Sample Pillars
==============

Single watchdog service

.. code-block:: yaml

    watchdog:
      server:
        admin: root
        enabled: true
        interval: 1
        log_dir: /var/log/watchdog
        realtime: yes
        timeout: 60
        device: /dev/watchdog


Sample Pillars with kernel module
=================================

Salt Stack will automatically detect the necessary kernel module which needs to be loaded (ex. hpwdt, iTCO_wdt).
If the hardware model is not predefined in map.jinja the default watchdog driver is used: softdog
You may specify the kernel parameters if needed:

.. code-block:: yaml

    watchdog:
      server:
        admin: root
        enabled: true
        interval: 1
        log_dir: /var/log/watchdog
        realtime: yes
        timeout: 60
        device: /dev/watchdog
        module: softdog
   ......
   ......
    linux:
      system:
        kernel:
          module:
            softdog:
              option:
                soft_panic: 1

INFO: extra formula [salt-formula-linux](https://github.com/salt-formulas/salt-formula-linux) required.

In that case, apply command should also care about linux state. For example:


.. code-block:: bash

  salt "kvm0*" -l debug state.apply watchdog.server,linux.system.kernel -l debug


More Information
================

https://github.com/torvalds/linux/blob/master/Documentation/watchdog/watchdog-api.txt
Those formula also support json-schema definition with all options.
Please refer to "watchdog/schemas/\*.yaml" for more information.



Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use GitHub issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-watchdog/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

You should also subscribe to mailing list (salt-formulas@freelists.org):

    https://www.freelists.org/list/salt-formulas

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net


To-Do
================

Remove the part in `watchdog/server.sls` about the Ubuntu Xenial bug once it's fixed in upstream:
https://bugs.launchpad.net/ubuntu/+source/watchdog/+bug/1448924
