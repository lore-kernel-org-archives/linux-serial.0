From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 0/2] serial: bcm2835: add bcm2835 auxiliar uart driver
Date: Sat,  9 Jan 2016 13:07:31 +0000
Message-ID: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patch series adds the bcm2835aux uart driver, which is created
as a wrapper arround the 8250 driver (based on recommendations by
Stephen Warren)

The device tree patch itself is not included yet because this
patch requires the clk-bcm2835aux driver, which is right now only
in clk-next, but should become available with 4.5.

Martin Sperl (2):
  dt/bindings: serial: bcm2835: add binding documentation for
    bcm2835-aux-uart
  serial: bcm2835: add driver for bcm2835-aux-uart

 .../bindings/serial/brcm,bcm2835-aux-uart.txt      |   18 +++
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  143 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |    8 ++
 drivers/tty/serial/8250/Makefile                   |    1 +
 4 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_bcm2835aux.c

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
