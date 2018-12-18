From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards support
Date: Tue, 18 Dec 2018 20:32:27 +0530
Message-ID: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hello Maintainers,

This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
GPU. The SoC has been added as a new ARM sub architecture with myself as the
maintainer.

More information about the boards can be found in below links:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

All patches are reviewed by the corresponding subsystem maintainers. The
clocksource and irqchip patches are reviewed and merged while the serial
driver got review from Greg but I'm not sure who will apply it.

So as per my discussion with Arnd, sending the individual patches instead
of a Pull request so that the rest of the patches can go through the
ARM SoC tree.

Please consider applying it.

Thanks,
Mani

Andreas Färber (4):
  dt-bindings: Add RDA Micro vendor prefix
  dt-bindings: arm: Document RDA8810PL and reference boards
  ARM: Prepare RDA8810PL SoC
  dt-bindings: serial: Document RDA Micro UART

Manivannan Sadhasivam (7):
  ARM: dts: Add devicetree for RDA8810PL SoC
  ARM: dts: Add devicetree for OrangePi 2G IoT board
  ARM: dts: Add devicetree for OrangePi i96 board
  ARM: dts: rda8810pl: Add timer support
  ARM: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../bindings/serial/rda,8810pl-uart.txt       |  17 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  14 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  50 ++
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  50 ++
 arch/arm/boot/dts/rda8810pl.dtsi              |  99 +++
 arch/arm/mach-rda/Kconfig                     |   7 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 17 files changed, 1122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile
 create mode 100644 drivers/tty/serial/rda-uart.c

-- 
2.17.1
