From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/15] Add initial RDA8810PL SoC and Orange Pi boards support
Date: Wed, 21 Nov 2018 09:06:37 +0530
Message-ID: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, overseas.sales@unisoc.com, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
  arm: dts: Add devicetree for RDA8810PL SoC
  arm: dts: Add devicetree for OrangePi 2G IoT board
  arm: dts: Add devicetree for OrangePi i96 board
  irqchip: Add RDA8810PL interrupt driver
  dt-bindings: timer: Document RDA8810PL SoC timer
  arm: dts: rda8810pl: Add timer support
  clocksource: Add clock driver for RDA8810PL SoC
  arm: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../interrupt-controller/rda,8810pl-intc.txt  |  61 ++
 .../bindings/serial/rda,8810pl-uart.txt       |  15 +
 .../bindings/timer/rda,8810pl-timer.txt       |  21 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  14 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  40 +
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  40 +
 arch/arm/boot/dts/rda8810pl.dtsi              |  99 +++
 arch/arm/mach-rda/Kconfig                     |   9 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rda.c               | 195 ++++
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rda-intc.c                | 113 +++
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 25 files changed, 1506 insertions(+)
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
