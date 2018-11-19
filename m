From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 00/14] Add basic support for Socionext Milbeaut M10V SoCs
Date: Mon, 19 Nov 2018 10:01:05 +0900
Message-ID: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Here is the series of patches the initial support for SC2000(M10V) of
Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
source code.

SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
computer vision. It also features advanced functionalities such as 360-degree,
real-time spherical stitching with multi cameras, image stabilization for
without mechanical gimbals, and rolling shutter correction. More detail is
below:
https://www.socionext.com/en/products/assp/milbeaut/SC2000.html

Specifications for developers are below:
 - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
 - NEON support
 - DSP
 - GPU
 - MAX 3GB DDR3
 - Cortex-M0 for power control
 - NAND Flash Interface
 - SD UHS-I
 - SD UHS-II
 - SDIO
 - USB2.0 HOST / Device
 - USB3.0 HOST / Device
 - PCI express Gen2
 - Ethernet Engine
 - I2C
 - UART
 - SPI
 - PWM

Support is quite minimal for now, since it only includes timer, clock,
pictrl and serial controller drivers, so we can only boot to userspace
through initramfs. Support for the other peripherals  will come eventually.


Sugaya Taichi (14):
  ARM: milbeaut: Add basic support for Milbeaut m10v SoC
  dt-bindings: soc: milbeaut: Add Milbeaut trampoline description
  ARM: milbeaut: Add Milbeaut M10V early printk
  dt-bindings: timer: Add Milbeaut M10V timer description
  clocksource/drivers/timer-milbeaut: Add Milbeaut M10V timer
  dt-bindings: clock: milbeaut: add Milbeaut clock description
  clock: milbeaut: Add Milbeaut M10V clock control
  dt-bindings: serial: Add Milbeaut M10V serial description
  serial: Add Milbeaut M10V serial control
  dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V pinctrl description
  pinctrl: milbeaut: Add Milbeaut M10V pinctrl
  ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
  ARM: configs: Add Milbeaut M10V defconfig
  MAINTAINERS: Add entry to MAINTAINERS for Milbeaut

 .../devicetree/bindings/clock/milbeaut-clock.txt   |  93 +++
 .../pinctrl/socionext,milbeaut-pinctrl.txt         |  33 +
 .../devicetree/bindings/serial/milbeaut-uart.txt   |  23 +
 .../bindings/soc/socionext/socionext,m10v.txt      |  12 +
 .../bindings/timer/socionext,milbeaut-timer.txt    |  17 +
 MAINTAINERS                                        |   9 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  12 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts            |  35 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dtsi           |  17 +
 arch/arm/boot/dts/milbeaut-m10v.dtsi               | 510 ++++++++++++++
 arch/arm/configs/milbeaut_m10v_defconfig           | 364 ++++++++++
 arch/arm/include/debug/milbeaut.S                  |  25 +
 arch/arm/mach-milbeaut/Kconfig                     |  28 +
 arch/arm/mach-milbeaut/Makefile                    |   3 +
 arch/arm/mach-milbeaut/m10v_evb.c                  |  31 +
 arch/arm/mach-milbeaut/platsmp.c                   | 157 +++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-m10v.c                             | 671 ++++++++++++++++++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-m10v.c                   | 146 ++++
 drivers/pinctrl/Kconfig                            |   9 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-m10v.c                     | 765 +++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |  24 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/m10v_usio.c                     | 605 ++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 31 files changed, 3606 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/milbeaut-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dtsi
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig
 create mode 100644 arch/arm/include/debug/milbeaut.S
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/m10v_evb.c
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c
 create mode 100644 drivers/clk/clk-m10v.c
 create mode 100644 drivers/clocksource/timer-m10v.c
 create mode 100644 drivers/pinctrl/pinctrl-m10v.c
 create mode 100644 drivers/tty/serial/m10v_usio.c

-- 
1.9.1
