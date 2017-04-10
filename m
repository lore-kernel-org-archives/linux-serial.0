From: Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 0/2] drivers: serial: Aspeed VUART driver
Date: Mon, 10 Apr 2017 13:29:02 +0930
Message-ID: <20170410035904.29443-1-joel@jms.id.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeremy Kerr <jk@ozlabs.org>
List-Id: linux-serial@vger.kernel.org

This is v3 of a driver for the Aspeed VUART. This version addresses feedback
from Andy and Greg, and includes Rob's ack for the bindings change.

The VUART is a serial device on the BMC side of the LPC bus that connects a BMC
to it's host processor.

We add a flag to the serial core to allow the driver to skip probing of the
THRE irq behaviour, which could hang due to the host not reading bytes out of
the buffer.

We've been using this on systems for over a year, so it has seen a good amount
of testing.

Cheers,

Joel

Jeremy Kerr (1):
  drivers/serial: Add driver for Aspeed virtual UART

Joel Stanley (1):
  serial: 8250: Add flag so drivers can avoid THRE probe

 Documentation/ABI/stable/sysfs-driver-aspeed-vuart |  15 +
 Documentation/devicetree/bindings/serial/8250.txt  |   2 +
 drivers/tty/serial/8250/8250_aspeed_vuart.c        | 323 +++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c                |   2 +-
 drivers/tty/serial/8250/Kconfig                    |  10 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 include/linux/serial_core.h                        |   1 +
 7 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-aspeed-vuart
 create mode 100644 drivers/tty/serial/8250/8250_aspeed_vuart.c

-- 
2.11.0
