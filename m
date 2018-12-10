From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 00/15] Add initial RDA8810PL SoC and Orange Pi boards support
Date: Mon, 10 Dec 2018 23:05:35 +0530
Message-ID: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hello,

This patchset adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
GPU. The SoC has been added as a new ARM sub architecture with myself
and Andreas as the maintainers.

More information about the boards can be found in below links:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

This patchset is based on the initial revision sent out by Andreas long
back (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/515951.html).

I have extended his patchset with proper irqchip and UART drivers. Now,
boards can boot into initramfs with console at UART2.

Thanks,
Mani

Changes in v4:

* Added Rob's Reviewed-by tags for vendor and SoC patches.
* Moved platform Kconfig changes from timer and irqchip drivers to
  SoC support patch.
* Added Marc's Reviewed-by tag for irqchip driver.
* Addressed Rob's review comments for bindings patches.
* Added the newly created linux-unisoc mailing list to MAINTAINERS
  entry.
* Dropped overseas.sales@unisoc.com mail address as it is bouncing back.
* Modified the DTS subject prefix to ARM: from arm:

Changes in v3:

As per Marc's review:

* Removed unused header and defines from irqchip driver.
* Removed setting flow handlers from set_type callback.
* Minor code cleanups.

As per Arnd's review:

* Modified the UART indexes to start from 1 to match the SoC numbering
* Enabled exposed UARTs (all 3 on both boards)
* Modified the serial aliases as per board numbering

* Added Greg's Reviewed-by tag for serial driver.

Changes in v2:

* Used readl/writel_relaxed calls for both irqchip and timer drivers as
  per Marc's review.
* Implemented the logic to prevent counter wrapping during read as
  suggested by Marc.
* Used the timer-of API as per Daniel's suggestion.
* Added description about the timer in both commit log and driver.
* Changed the Vendor name for RDA to Unisoc Communications Inc.
* Removed the soc node level and cleaned up devicetrees as per Rob's
  review.
* Merged interrupt controller DT patch to SoC.
* Moved aliases to board dts as per Arnd's suggestion.
* Removed RDA Micro support mail address and used Unisoc one and added
  my missing signed off by tag as per Andreas's comments.

Andreas Färber (4):
  dt-bindings: Add RDA Micro vendor prefix
  dt-bindings: arm: Document RDA8810PL and reference boards
  ARM: Prepare RDA8810PL SoC
  dt-bindings: serial: Document RDA Micro UART

Manivannan Sadhasivam (11):
  dt-bindings: interrupt-controller: Document RDA8810PL intc
  ARM: dts: Add devicetree for RDA8810PL SoC
  ARM: dts: Add devicetree for OrangePi 2G IoT board
  ARM: dts: Add devicetree for OrangePi i96 board
  irqchip: Add RDA8810PL interrupt driver
  dt-bindings: timer: Document RDA8810PL SoC timer
  ARM: dts: rda8810pl: Add timer support
  clocksource: Add clock driver for RDA8810PL SoC
  ARM: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../interrupt-controller/rda,8810pl-intc.txt  |  61 ++
 .../bindings/serial/rda,8810pl-uart.txt       |  17 +
 .../bindings/timer/rda,8810pl-timer.txt       |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  15 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  50 ++
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  50 ++
 arch/arm/boot/dts/rda8810pl.dtsi              |  99 +++
 arch/arm/mach-rda/Kconfig                     |   9 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rda.c               | 195 ++++
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rda-intc.c                | 107 +++
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 25 files changed, 1522 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile
 create mode 100644 drivers/clocksource/timer-rda.c
 create mode 100644 drivers/irqchip/irq-rda-intc.c
 create mode 100644 drivers/tty/serial/rda-uart.c

-- 
2.17.1
