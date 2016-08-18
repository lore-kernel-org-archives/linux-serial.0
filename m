From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 0/3] UART slave device bus
Date: Wed, 17 Aug 2016 20:14:42 -0500
Message-ID: <20160818011445.22726-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Currently, devices attached via a UART are not well supported in the
kernel. The problem is the device support is done in tty line disciplines,
various platform drivers to handle some sideband, and in userspace with
utilities such as hciattach.

There have been several attempts to improve support, but they suffer from
still being tied into the tty layer and/or abusing the platform bus. This
is a prototype to show creating a proper UART bus for UART devices. It is
tied into the serial core (really struct uart_port) below the tty layer
in order to use existing serial drivers.

This is functional with minimal testing using the loopback driver and
pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
device). It still needs lots of work and polish.

TODOs:
- Figure out the port locking. mutex plus spinlock plus refcounting? I'm
  hoping all that complexity is from the tty layer and not needed here.
- Split out the controller for uart_ports into separate driver. Do we see
  a need for controller drivers that are not standard serial drivers?
- Implement/test the removal paths
- Fix the receive callbacks for more than character at a time (i.e. DMA)
- Need better receive buffering than just a simple circular buffer or
  perhaps a different receive interface (e.g. direct to client buffer)?
- Test with other UART drivers
- Convert a real driver/line discipline over to UART bus.

Before I spend more time on this, I'm looking mainly for feedback on the
general direction and structure (the interface with the existing serial
drivers in particular).

Rob


Rob Herring (3):
  uart bus: Introduce new bus for UART slave devices
  tty: serial_core: make tty_struct optional
  tty: serial_core: add uart controller registration

 drivers/Kconfig                  |   2 +
 drivers/Makefile                 |   1 +
 drivers/tty/serial/serial_core.c |  11 +-
 drivers/tty/tty_buffer.c         |   2 +
 drivers/uart/Kconfig             |  17 ++
 drivers/uart/Makefile            |   3 +
 drivers/uart/core.c              | 458 +++++++++++++++++++++++++++++++++++++++
 drivers/uart/loopback.c          |  72 ++++++
 include/linux/serial_core.h      |   3 +-
 include/linux/uart_device.h      | 163 ++++++++++++++
 10 files changed, 730 insertions(+), 2 deletions(-)
 create mode 100644 drivers/uart/Kconfig
 create mode 100644 drivers/uart/Makefile
 create mode 100644 drivers/uart/core.c
 create mode 100644 drivers/uart/loopback.c
 create mode 100644 include/linux/uart_device.h

--
2.9.2
