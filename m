From: Rob Herring <robh@kernel.org>
Subject: [PATCH 0/9] Serial slave device bus
Date: Fri,  6 Jan 2017 10:26:26 -0600
Message-ID: <20170106162635.19677-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Here goes another attempt at a serial device bus (aka uart slaves, tty
slaves, etc.).

After some discussions with Dmitry at LPC, I decided to move away from
extending serio and moved back to making a new bus type instead. He didn't
think using serio was a good fit, and serio has a number of peculiarities
in regards to sysfs and it's driver model. I don't think we want to inherit
those for serial slave devices.

This version sits on top of tty_port rather than uart_port as Alan
requested. Once I created a struct tty rather than moving everything
needed to tty_port, it became a lot easier and less invasive to the tty
core code.

I have hacked up versions of the BT ldisc and TI ST drivers moved over to
use the serdev bus. I have BT working on the HiKey board which has TI BT.
With the serdev bus support, it eliminates the need for the TI userspace
UIM daemon.

This series and the mentioned drivers can be found here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-v2

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

 .../devicetree/bindings/serial/slave-device.txt    |  34 ++
 MAINTAINERS                                        |   8 +
 drivers/char/Kconfig                               |   1 +
 drivers/tty/Makefile                               |   1 +
 drivers/tty/serdev/Kconfig                         |  16 +
 drivers/tty/serdev/Makefile                        |   5 +
 drivers/tty/serdev/core.c                          | 388 +++++++++++++++++++++
 drivers/tty/serdev/serdev-ttyport.c                | 244 +++++++++++++
 drivers/tty/tty_buffer.c                           |  19 +-
 drivers/tty/tty_io.c                               |  44 ++-
 drivers/tty/tty_port.c                             |  60 +++-
 include/linux/serdev.h                             | 227 ++++++++++++
 include/linux/tty.h                                |  12 +-
 13 files changed, 1017 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
 create mode 100644 drivers/tty/serdev/Kconfig
 create mode 100644 drivers/tty/serdev/Makefile
 create mode 100644 drivers/tty/serdev/core.c
 create mode 100644 drivers/tty/serdev/serdev-ttyport.c
 create mode 100644 include/linux/serdev.h

--
2.10.1
