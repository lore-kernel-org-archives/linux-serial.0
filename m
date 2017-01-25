From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/5] Serial slave device bus
Date: Wed, 25 Jan 2017 14:23:38 -0600
Message-ID: <20170125202343.30923-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Here's V3 of the serdev bus support with all the review feedback so far
incorporated. Greg applied the first 4 patches already. I also found a
problem in the tty_port_wakeup changes and have fixed that.

I've added serdev support to the BT hci_ll.c driver as it turns out it works
on newer TI chips too, but just needed firmware loading. That avoids the
impossible mess of cleaning up the TI-ST driver, and it's in a much closer
state to being ready for upstream. I've sent that out separately.

Changelog is in individual patches. Previous versions are here[1][2]. This
series and the mentioned drivers can be found here[3].

Rob

[1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1304151.html
[2] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1311650.html
[3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-v4


Rob Herring (5):
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
 drivers/tty/serdev/serdev-ttyport.c                | 226 +++++++++++
 drivers/tty/tty_buffer.c                           |  17 +-
 drivers/tty/tty_port.c                             |  58 ++-
 include/linux/serdev.h                             | 262 +++++++++++++
 include/linux/tty.h                                |   9 +-
 12 files changed, 1039 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
 create mode 100644 drivers/tty/serdev/Kconfig
 create mode 100644 drivers/tty/serdev/Makefile
 create mode 100644 drivers/tty/serdev/core.c
 create mode 100644 drivers/tty/serdev/serdev-ttyport.c
 create mode 100644 include/linux/serdev.h

--
2.10.1
