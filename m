From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 00/34] jz4780 & CI20 support
Date: Wed, 4 Feb 2015 15:21:29 +0000
Message-ID: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

Hi,

This series introduces initial support for the Ingenic jz4780 SoC & the
MIPS Creator CI20 board which is based upon it.

The jz4780 shares aspects with jz4740. But jz4740 is platform only.

So, the jz4740 & qi_lb60 (Ben NanoNote) are converted to use DT
for some things in order to ease the process of sharing code.

Series is based on 3.19-rc7.

ACKS from various subsystems are welcome so that the series can
go via mips if that is OK with everyone.

Alternative suggestions welcome.

Changes in V2
- Removed FSF addresses. 
- Removed 2 patches for binding docs that
  were consolidated in the same binding for jz4740.
- Bug fix in error handling in cgu
- Rebase on 3.19-rc7
- Updated defconfig with jz47xx serial and removed initramfs
- Renames in binding from intc to interrupt-controller
- Fix in jz47xx serial for build error on x86 in one config option
- Removed interupt-parent bindings from required bindings
- Fixed imgtec prefix to img
- Added jz47xx config for qi_lb60_defconfig

Regards,
ZubairLK


Paul Burton (34):
  dt: Add Ingenic Semiconductor vendor prefix
  MIPS: jz4740: require & include DT
  MIPS: irq_cpu: declare irqchip table entry
  MIPS: jz4740: probe CPU interrupt controller via DT
  MIPS: jz4740: use generic plat_irq_dispatch
  MIPS: jz4740: move arch_init_irq out of arch/mips/jz4740/irq.c
  dt: interrupt-controller: Add ingenic,jz4740-intc binding doc
  MIPS: jz4740: allow interrupt controller probe via DT
  MIPS: jz4740: probe interrupt controller via DT
  MIPS: jz4740: remove non-DT interrupt controller init
  MIPS: jz4740: register an irq_domain for the interrupt controller
  MIPS: jz4740: call jz4740_clock_init earlier
  MIPS: jz4740: replace use of jz4740_clock_bdata
  clk: jz47xx-cgu: add driver for Ingenic jz47xx series CGU clocks
  dt: clk: Add ingenic,jz4740-cgu binding documentation
  MIPS: clk: migrate jz4740 to common clock framework
  MIPS: clk: move jz4740_clock_set_wait_mode to jz4740-cgu
  MIPS: clk: move jz4740 UDC auto suspend functions to jz4740-cgu
  MIPS: clk: move jz4740 clock suspend, resume functions to jz4740-cgu
  MIPS: jz4740: remove clock.h
  MIPS: jz4740: only detect RAM size if not specified in DT
  MIPS: jz4740: support >32 interrupts
  MIPS: jz4740: define IRQ numbers based on number of intc IRQs
  dt: serial: Add ingenic,jz4740-uart binding
  serial: 8250_jz47xx: support for Ingenic jz47xx UARTs
  MIPS: allow mach-provided serial.h
  MIPS: jz4740: use jz47xx-uart & DT for UART output
  dt: clk: Add ingenic,jz4780-cgu binding documentation
  clk: add Ingenic jz4780 CGU driver
  MIPS: jz4740: add jz4780 interrupt controller support
  MIPS: add jz4780 Ingenic vendor ID
  MIPS: initial Ingenic jz4780 support
  MIPS: initial MIPS Creator CI20 board support
  MIPS: allow jz4780 to be selected in Kconfig

 .../bindings/clock/ingenic,jz4740-cgu.txt          |  52 ++
 .../bindings/clock/ingenic,jz4780-cgu.txt          |  52 ++
 .../interrupt-controller/ingenic,jz4740-intc.txt   |  26 +
 .../bindings/serial/ingenic,jz4740-uart.txt        |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/mips/Kconfig                                  |  22 +-
 arch/mips/boot/dts/Makefile                        |   2 +
 arch/mips/boot/dts/ci20.dts                        |  21 +
 arch/mips/boot/dts/jz4740.dtsi                     |  68 ++
 arch/mips/boot/dts/jz4780.dtsi                     | 101 +++
 arch/mips/boot/dts/qi_lb60.dts                     |  15 +
 arch/mips/configs/ci20_defconfig                   | 127 +++
 arch/mips/configs/qi_lb60_defconfig                |   1 +
 arch/mips/include/asm/Kbuild                       |   1 -
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/mach-generic/serial.h        |  21 +
 arch/mips/include/asm/mach-jz4740/clock.h          |   3 +
 arch/mips/include/asm/mach-jz4740/irq.h            |  15 +-
 arch/mips/include/asm/mach-jz4740/platform.h       |   2 -
 arch/mips/include/asm/mach-jz4740/serial.h         |  27 +
 arch/mips/include/asm/serial.h                     |  21 +
 arch/mips/jz4740/Kconfig                           |  10 +
 arch/mips/jz4740/Makefile                          |   6 +-
 arch/mips/jz4740/Platform                          |   4 +
 arch/mips/jz4740/board-qi_lb60.c                   |   7 -
 arch/mips/jz4740/clock-debugfs.c                   | 108 ---
 arch/mips/jz4740/clock.c                           | 924 ---------------------
 arch/mips/jz4740/clock.h                           |  76 --
 arch/mips/jz4740/irq.c                             | 103 ++-
 arch/mips/jz4740/platform.c                        |  37 +-
 arch/mips/jz4740/pm.c                              |   2 -
 arch/mips/jz4740/prom.c                            |  13 -
 arch/mips/jz4740/reset.c                           |  13 +-
 arch/mips/jz4740/serial.c                          |  33 -
 arch/mips/jz4740/serial.h                          |  23 -
 arch/mips/jz4740/setup.c                           |  33 +-
 arch/mips/jz4740/time.c                            |  19 +-
 arch/mips/kernel/cpu-probe.c                       |   1 +
 arch/mips/kernel/irq_cpu.c                         |   3 +
 drivers/clk/Makefile                               |   2 +
 drivers/clk/jz47xx/Makefile                        |   3 +
 drivers/clk/jz47xx/jz4740-cgu.c                    | 295 +++++++
 drivers/clk/jz47xx/jz4780-cgu.c                    | 742 +++++++++++++++++
 drivers/clk/jz47xx/jz47xx-cgu.c                    | 723 ++++++++++++++++
 drivers/clk/jz47xx/jz47xx-cgu.h                    | 205 +++++
 drivers/tty/serial/8250/8250_jz47xx.c              | 225 +++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 include/dt-bindings/clock/jz4740-cgu.h             |  37 +
 include/dt-bindings/clock/jz4780-cgu.h             |  88 ++
 50 files changed, 3070 insertions(+), 1276 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,jz4740-cgu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,jz4780-cgu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,jz4740-intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,jz4740-uart.txt
 create mode 100644 arch/mips/boot/dts/ci20.dts
 create mode 100644 arch/mips/boot/dts/jz4740.dtsi
 create mode 100644 arch/mips/boot/dts/jz4780.dtsi
 create mode 100644 arch/mips/boot/dts/qi_lb60.dts
 create mode 100644 arch/mips/configs/ci20_defconfig
 create mode 100644 arch/mips/include/asm/mach-generic/serial.h
 create mode 100644 arch/mips/include/asm/mach-jz4740/serial.h
 create mode 100644 arch/mips/include/asm/serial.h
 delete mode 100644 arch/mips/jz4740/clock-debugfs.c
 delete mode 100644 arch/mips/jz4740/clock.c
 delete mode 100644 arch/mips/jz4740/clock.h
 delete mode 100644 arch/mips/jz4740/serial.c
 delete mode 100644 arch/mips/jz4740/serial.h
 create mode 100644 drivers/clk/jz47xx/Makefile
 create mode 100644 drivers/clk/jz47xx/jz4740-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz4780-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz47xx-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz47xx-cgu.h
 create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c
 create mode 100644 include/dt-bindings/clock/jz4740-cgu.h
 create mode 100644 include/dt-bindings/clock/jz4780-cgu.h

-- 
1.9.1
