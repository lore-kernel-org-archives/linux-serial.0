From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v4 00/10] Add basic support for Socionext Milbeaut M10V SoC
Date: Wed, 27 Feb 2019 13:50:56 +0900
Message-ID: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, soc@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Jassi Brar <jaswinder.singh@linaro.org>, Sugaya Taichi <sugaya.taichi@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh+dt@kernel.org>, Takao Orito <orito.takao@socionext.com>, Thomas Gleixner <tglx@linutronix.de>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
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

Changes since v3:
* Add "Reviewed" tag to the dt-binding of the serial driver.
* Fix schema string in milbeaut soc binding.
* Refine defconfig for milbeaut M10V.
* Add milbeaut architecture config to multi_v7_defconfig.

Changes since v2:
* Drop clk, pinctrl, and serial driver.
* Drop unneeded options from defconfig.
* Convert milbeaut soc binding to yaml.
* Fix serial driver binding.
* Change serial id of aliases in DT.
* Add platform checking when entering suspend/resume.
* Drop pr_err()s.

Changes since v1:
* Change file names.
* Change #define names.
* Refine cpu-enable-method and bindigs.
* Add documentation for Milbeaut SoCs.
* Add more infomation for timer driver.
* Add sched_clock to timer driver.
* Refine whole of clk driver.
* Add earlycon instead of earlyprintk.
* Refine Device Tree.


Sugaya Taichi (10):
  dt-bindings: sram: milbeaut: Add binding for Milbeaut smp-sram
  dt-bindings: arm: Add SMP enable-method for Milbeaut
  dt-bindings: Add documentation for Milbeaut SoCs
  ARM: milbeaut: Add basic support for Milbeaut m10v SoC
  dt-bindings: timer: Add Milbeaut M10V timer description
  clocksource/drivers/timer-milbeaut: Introduce timer for Milbeaut SoCs
  dt-bindings: serial: Add Milbeaut serial driver description
  ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
  ARM: configs: Add Milbeaut M10V defconfig
  ARM: multi_v7_defconfig: add ARCH_MILBEAUT and ARCH_MILBEAUT_M10V

 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 .../bindings/arm/socionext/milbeaut.yaml           |  22 +++
 .../devicetree/bindings/serial/milbeaut-uart.txt   |  21 +++
 .../devicetree/bindings/sram/milbeaut-smp-sram.txt |  24 +++
 .../bindings/timer/socionext,milbeaut-timer.txt    |  17 +++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts            |  32 ++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi               |  95 ++++++++++++
 arch/arm/configs/milbeaut_m10v_defconfig           | 119 +++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/mach-milbeaut/Kconfig                     |  20 +++
 arch/arm/mach-milbeaut/Makefile                    |   1 +
 arch/arm/mach-milbeaut/platsmp.c                   | 143 ++++++++++++++++++
 drivers/clocksource/Kconfig                        |   9 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-milbeaut.c               | 161 +++++++++++++++++++++
 18 files changed, 672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
 create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c
 create mode 100644 drivers/clocksource/timer-milbeaut.c

-- 
1.9.1
