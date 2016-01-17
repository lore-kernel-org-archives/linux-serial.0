From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V3 0/4] serial: bcm2835: add bcm2835 auxiliar uart driver
Date: Sun, 17 Jan 2016 12:15:27 +0000
Message-ID: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This patch series adds the bcm2835aux uart driver, which is created
as a wrapper arround the 8250 driver (based on recommendations by
Stephen Warren)

Also (as per request) the recommendation for naming conventions of nodes
in the device-tree have been followed for both the primary uart as well
as for the auxiliar uart: nodes should be called "serial@...".

The device tree patches will not apply cleanly as:
* the bcm-auxiliar clock device tree patch has not been applied to
  upstream yet (but it is pending).
* there is a rename of arch/arm/boot/dts/bcm2835.dtsi
  scheduled, which is also not upstream yet.

I want to get this patch out before I go on vacation not waiting for
it to appear. If necessary please modify the corresponding patches.

Martin Sperl (4):
  ARM: bcm2835: follow dt uart node-naming convention
  dt/bindings: serial: bcm2835: add binding documentation for
    bcm2835-aux-uart
  serial: bcm2835: add driver for bcm2835-aux-uart
  ARM: bcm2835: add bcm2835-aux-uart support to default DT

 .../bindings/serial/brcm,bcm2835-aux-uart.txt      |   18 +++
 arch/arm/boot/dts/bcm2835.dtsi                     |    9 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  146 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   24 ++++
 drivers/tty/serial/8250/Makefile                   |    1 +
 5 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_bcm2835aux.c

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
