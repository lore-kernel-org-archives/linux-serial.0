From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 00/16] Support armada-37xx second UART port
Date: Fri, 13 Oct 2017 11:01:44 +0200
Message-ID: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Changes since v1:
- Added a fallback in probe() to allow the use of this driver without
  device tree.
- Used devm_free_irq() instead of free_irq().
- Changed comments on ESPRESSObin DTS.
- Fixed various typos.
- Added Gregory's Acked-by/Reviewed-by tags.


Hi,

This series adds support for the armada-37xx extended UART port. The new
capabilities of this IP compared to the standard port are the possibility
to use DMA, it has bigger FIFOs (128 bytes instead of 32/64), it is
possible to fill the FIFO byte-per-byte or 4 bytes at a time, it as RTS
and CTS control, it supports transfer count for RX/TX with transfer
finish status and finally it may achieve higher baudrates by the use of
special dividers.

Almost none of these extended features are implemented though. For now,
the extended UART is just supported with the same features as the
standard UART.

This IP is present on the Armada 3720 SoC and is now enabled by the
device tree related patches on the Armada-3720-DB. As adding the node to
enable the second port on Armada-3720-ESPRESSObin could break existing
users by changing the configuration of some pins on the main headers,
only a side note is added on how to do it easily.

- The driver patches should go through Greg KH.
- The DT patches should go through the mvebu maintainers.
- We would also like the DT binding documentation update to go through
  the mvebu maintainers, as it conflicts with another DT change.

Thank you,
Miquel


Allen Yan (5):
  serial: mvebu-uart: support probe of multiple ports
  serial: mvebu-uart: add soft reset at probe
  serial: mvebu-uart: add function to change baudrate
  serial: mvebu-uart: clear state register before IRQ request
  serial: mvebu-uart: add TX interrupt trigger for pulse interrupts

Miquel Raynal (10):
  dt-bindings: mvebu-uart: update documentation with extended UART
  pinctrl: dt-bindings: Fix A37xx uart2 group name
  serial: mvebu-uart: use a generic way to access the registers
  serial: mvebu-uart: dissociate RX and TX interrupts
  serial: mvebu-uart: augment the maximum number of ports
  serial: mvebu-uart: support extended port registers layout
  arm64: dts: marvell: armada-37xx: add UART clock
  arm64: dts: marvell: armada-37xx: add second UART port
  arm64: dts: marvell: armada-3720-db: enable second UART port
  arm64: dts: marvell: armada-3720-espressobin: fill UART nodes

Yehuda Yitschak (1):
  serial: mvebu-uart: use driver name when requesting an interrupt

 .../pinctrl/marvell,armada-37xx-pinctrl.txt        |   4 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |  49 ++-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   9 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |  12 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  19 +-
 drivers/tty/serial/mvebu-uart.c                    | 483 +++++++++++++++++----
 6 files changed, 473 insertions(+), 103 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
