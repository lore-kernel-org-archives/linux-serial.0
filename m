From: Rob Herring <robh@kernel.org>
Subject: [PATCH v4 0/5] Serial slave device bus
Date: Thu,  2 Feb 2017 13:48:04 -0600
Message-ID: <20170202194809.18274-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Here's V4 of the serdev bus support. Just 2 small fixes from V3 and 
Sebastian's Tested-by(Thanks!). I fixed a module build breakage in 
serdev.h and dropped setting of receive_room. It was only needed for the 
ldisc->receive_buf() function.

There's a few additions Sebastion needed for more serial port control of 
RTS/CTS. I think these can be added on top of this series as drivers 
need them.

Changelog is in individual patches. Previous versions are here[1][2][3]. 
This series and the mentioned drivers can be found here[4].

Rob

[1] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1304151.html
[2] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1311650.html
[3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1318626.html
[4] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-v5


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
 drivers/tty/serdev/serdev-ttyport.c                | 224 +++++++++++
 drivers/tty/tty_buffer.c                           |  17 +-
 drivers/tty/tty_port.c                             |  58 ++-
 include/linux/serdev.h                             | 262 +++++++++++++
 include/linux/tty.h                                |   9 +-
 12 files changed, 1037 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
 create mode 100644 drivers/tty/serdev/Kconfig
 create mode 100644 drivers/tty/serdev/Makefile
 create mode 100644 drivers/tty/serdev/core.c
 create mode 100644 drivers/tty/serdev/serdev-ttyport.c
 create mode 100644 include/linux/serdev.h

-- 
2.10.1
