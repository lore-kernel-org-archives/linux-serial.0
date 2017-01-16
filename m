From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/9] Serial slave device bus
Date: Mon, 16 Jan 2017 16:54:27 -0600
Message-ID: <20170116225436.17505-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Here's a new version of the serdev bus support with all the review
feedback so far incorporated. I've left it named serdev for now pending
any further votes one way or the other, but I did rename the sysfs visible
portions to "serial".

There's still some discussion about what to do with devices that pass thru
data to userspace unmodified like GPS and could still use tty device for
the data path. IMO, we should treat this as a separate problem following
this series. Drivers we want to convert to serdev and already in the
kernel don't need this functionality.

I need a SoB from Alan on his patch 2 and would like review from Alan and/or
Peter on the locking in patch 5.

I have hacked up versions of the BT ldisc and TI ST drivers moved over to
use the serdev bus. I have BT working on the HiKey board which has TI BT.
With the serdev bus support, it eliminates the need for the TI userspace
UIM daemon. I've made some progress cleaning up the TI-ST into proper
patches and also got it working at 3Mbps.

Changelog is in individual patches. Previous version is here[1]. This
series and the mentioned drivers can be found here[2].

Rob

[1] https://lkml.org/lkml/2017/1/6/411
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-v3


Alan Cox (1):
  tty_port: allow a port to be opened with a tty that has no file handle

Rob Herring (8):
  tty: move the non-file related parts of tty_release to new
    tty_release_struct
  tty_port: make tty_port_register_device wrap
    tty_port_register_device_attr
  tty: constify tty_ldisc_receive_buf buffer pointer
  tty_port: Add port client functions
  dt/bindings: Add a serial/UART attached device binding
  serdev: Introduce new bus for serial attached devices
  serdev: add a tty port controller driver
  tty_port: register tty ports with serdev bus

 .../devicetree/bindings/serial/slave-device.txt    |  36 ++
 MAINTAINERS                                        |   8 +
 drivers/char/Kconfig                               |   1 +
 drivers/tty/Makefile                               |   1 +
 drivers/tty/serdev/Kconfig                         |  16 +
 drivers/tty/serdev/Makefile                        |   5 +
 drivers/tty/serdev/core.c                          | 421 +++++++++++++++++++++
 drivers/tty/serdev/serdev-ttyport.c                | 240 ++++++++++++
 drivers/tty/tty_buffer.c                           |  19 +-
 drivers/tty/tty_io.c                               |  52 ++-
 drivers/tty/tty_port.c                             |  58 ++-
 include/linux/serdev.h                             | 234 ++++++++++++
 include/linux/tty.h                                |  12 +-
 13 files changed, 1062 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
 create mode 100644 drivers/tty/serdev/Kconfig
 create mode 100644 drivers/tty/serdev/Makefile
 create mode 100644 drivers/tty/serdev/core.c
 create mode 100644 drivers/tty/serdev/serdev-ttyport.c
 create mode 100644 include/linux/serdev.h

--
2.10.1
