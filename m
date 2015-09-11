From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 0/4] bcm2835: enable auxiliary uart1
Date: Fri, 11 Sep 2015 12:20:49 +0000
Message-ID: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The bcm2835 SOC contains an auxiliary uart, which is very close
to the ns16550 with some differences.

The big difference is that the uart HW is not using an internal divider
of 16 but 8, which results in an effictive baud-rate being twice
the requested baud-rate.

The bcm2835-aux-uart is also special in such that it is enabled/disabled
by a gate in the clock, which is managed by the clk-bcm2835-aux
clock driver.

there are 2 options:
* defining the clock-frequency property in the device tree to 500k
  instead of 250k, but this keeps the HW block disabled making the
  uart not work.
* defining a clock in the device tree, but this results in a baud rate
  that is twice the requested baud-rate.

To address this this patch-set introduce a new property in the device tree
to define a clock divider other than 16.

This currently just scales the clock by a factor of 16/divider.

Note that the use of fixed-factor-clock has also been proposed as a
workarround, but this does not really describe the hw in the device tree
so another solution was needed that allows a correct representation of
the HW in the device tree.

Martin Sperl (4):
  serial: of-serial: allow for a custom clock divider different from 16
  dt/bindings: serial: of-serial: add description for clock-divider
    property
  serial: bcm2835: add auxiliary uart1 to device tree of bcm2835
  ARM: bcm2835: add of-serial and 8250 to bcm2835_defconfig

 Documentation/devicetree/bindings/serial/8250.txt |    1 +
 arch/arm/boot/dts/bcm2835.dtsi                    |   11 +++++++++++
 arch/arm/configs/bcm2835_defconfig                |    7 +++++++
 drivers/tty/serial/of_serial.c                    |   14 ++++++++++++++
 4 files changed, 33 insertions(+)

--
1.7.10.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
