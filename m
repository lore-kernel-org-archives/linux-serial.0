From: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Subject: [PATCH v3 0/2] drivers: serial: Aspeed VUART driver
Date: Mon, 10 Apr 2017 13:33:58 +0930
Message-ID: <20170410040400.5509-1-joel@jms.id.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
