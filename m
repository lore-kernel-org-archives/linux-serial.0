From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 0/8] MIPS: BCM63XX: add and use clkdev lookup support
Date: Wed, 20 Sep 2017 13:14:00 +0200
Message-ID: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This patchset adds support for clckdev lookup support to name input
clocks in various drivers more closely to their functions, or simplify
their usage.

Since most of these patches touch arch/mips, it probably makes most
sense to go through the MIPS tree.

The HSSPI driver was already updated previously to support a "pll"
input with ff18e1ef04e2 ("spi/bcm63xx-hsspi: allow providing clock rate
through a second clock"), so there is no need to touch it.

This patch series is part of an effort to modernize BCM63XX and clean up
its drivers to eventually make them usable with BMIPS and device tree.

Changes V1 -> V2:
* Drop the bcm63xx_enet patch, it will be sent again once the clkdev
  lookup is actually applied.
* Added a patch to fix refcounting in the secondary switch clocks.
* Slightly reordered patches to be ordered thematically.
* Added collected Acks / Reviews to their respective patches.

Due to none of the patches having changed between V1 and V2 I did not
add individual changelogs. These will be added if the code or commit log
text changes.

Jonas Gorski (8):
  MIPS: BCM63XX: add clkdev lookup support
  MIPS: BCM63XX: provide periph clock as refclk for uart
  tty/bcm63xx_uart: use refclk for the expected clock name
  tty/bcm63xx_uart: allow naming clock in device tree
  MIPS: BMIPS: name the refclk clock for uart
  MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
  MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
  MIPS: BCM63XX: split out swpkt_sar/usb clocks

 .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
 arch/mips/Kconfig                                  |   1 +
 arch/mips/bcm63xx/clk.c                            | 242 +++++++++++++++++----
 arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
 drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
 10 files changed, 218 insertions(+), 49 deletions(-)

-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
