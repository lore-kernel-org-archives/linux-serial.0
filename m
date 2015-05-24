From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 00/37] JZ4780 & CI20 support
Date: Sun, 24 May 2015 16:11:10 +0100
Message-ID: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Cc: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Joshua Kinard <kumba-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Antony Pavlov <antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felix Fietkau <nbd-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Steven J. Hill" <Steven.Hill-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Leonid Yegoshin <Leonid.Yegoshin-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>M
List-Id: linux-serial@vger.kernel.org

This series introduces initial support for the Ingenic JZ4780 SoC and
the Imagination Technologies MIPS Creator CI20 board which is built
around it. In the process the existing JZ4740 & qi_lb60 code gains
initial support for using DeviceTree such that much of the existing
platform code under arch/mips/jz4740 can be shared.

The series applies atop v4.1-rc4. Review appreciated, and hopefully
this can make it in for v4.2.

Paul Burton (37):
  devicetree/bindings: add Ingenic Semiconductor vendor prefix
  devicetree/bindings: add Qi Hardware vendor prefix
  MIPS: JZ4740: introduce CONFIG_MACH_INGENIC
  MIPS: ingenic: add newer vendor IDs
  MIPS: JZ4740: require & include DT
  MIPS: irq_cpu: declare irqchip table entry
  MIPS: JZ4740: probe CPU interrupt controller via DT
  MIPS: JZ4740: use generic plat_irq_dispatch
  MIPS: JZ4740: move arch_init_irq out of arch/mips/jz4740/irq.c
  devicetree: document Ingenic SoC interrupt controller binding
  MIPS: JZ4740: probe interrupt controller via DT
  MIPS: JZ4740: parse SoC interrupt controller parent IRQ from DT
  MIPS: JZ4740: register an irq_domain for the interrupt controller
  MIPS: JZ4740: drop intc debugfs code
  MIPS: JZ4740: remove jz_intc_base global
  MIPS: JZ4740: support >32 interrupts
  MIPS: JZ4740: define IRQ numbers based on number of intc IRQs
  MIPS: JZ4740: read intc base address from DT
  MIPS: JZ4740: avoid JZ4740-specific naming
  MIPS: JZ4740: support newer SoC interrupt controllers
  irqchip: move Ingenic SoC intc driver to drivers/irqchip
  MIPS: JZ4740: call jz4740_clock_init earlier
  MIPS: JZ4740: replace use of jz4740_clock_bdata
  devicetree: add Ingenic CGU binding documentation
  clk: ingenic: add driver for Ingenic SoC CGU clocks
  MIPS,clk: migrate JZ4740 to common clock framework
  MIPS,clk: move jz4740_clock_set_wait_mode to jz4740-cgu
  MIPS, clk: move jz4740 UDC auto suspend functions to jz4740-cgu
  MIPS, clk: move jz4740 clock suspend, resume functions to jz4740-cgu
  clk: ingenic: add JZ4780 CGU support
  MIPS: JZ4740: remove clock.h
  MIPS: JZ4740: only detect RAM size if not specified in DT
  devicetree: document Ingenic SoC UART binding
  serial: 8250_ingenic: support for Ingenic SoC UARTs
  MIPS: JZ4740: use Ingenic SoC UART driver
  MIPS: ingenic: initial JZ4780 support
  MIPS: ingenic: initial MIPS Creator CI20 support

 .../devicetree/bindings/clock/ingenic,cgu.txt      |  53 ++
 .../bindings/interrupt-controller/ingenic,intc.txt |  28 +
 .../devicetree/bindings/serial/ingenic,uart.txt    |  22 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/mips/Kconfig                                  |  11 +-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/ingenic/Makefile                |  10 +
 arch/mips/boot/dts/ingenic/ci20.dts                |  44 +
 arch/mips/boot/dts/ingenic/jz4740.dtsi             |  68 ++
 arch/mips/boot/dts/ingenic/jz4780.dtsi             | 111 +++
 arch/mips/boot/dts/ingenic/qi_lb60.dts             |  15 +
 arch/mips/configs/ci20_defconfig                   | 162 ++++
 arch/mips/configs/qi_lb60_defconfig                |   3 +-
 arch/mips/include/asm/cpu-type.h                   |   2 +-
 arch/mips/include/asm/cpu.h                        |   6 +-
 arch/mips/include/asm/mach-jz4740/clock.h          |   3 +
 .../asm/mach-jz4740/cpu-feature-overrides.h        |   3 -
 arch/mips/include/asm/mach-jz4740/irq.h            |  14 +-
 arch/mips/include/asm/mach-jz4740/platform.h       |   2 -
 arch/mips/jz4740/Kconfig                           |  17 +-
 arch/mips/jz4740/Makefile                          |   8 +-
 arch/mips/jz4740/Platform                          |   8 +-
 arch/mips/jz4740/board-qi_lb60.c                   |   7 -
 arch/mips/jz4740/clock-debugfs.c                   | 108 ---
 arch/mips/jz4740/clock.c                           | 924 ---------------------
 arch/mips/jz4740/clock.h                           |  76 --
 arch/mips/jz4740/gpio.c                            |   7 +-
 arch/mips/jz4740/irq.c                             | 162 ----
 arch/mips/jz4740/platform.c                        |  38 +-
 arch/mips/jz4740/pm.c                              |   2 -
 arch/mips/jz4740/prom.c                            |  13 -
 arch/mips/jz4740/reset.c                           |  13 +-
 arch/mips/jz4740/serial.c                          |  33 -
 arch/mips/jz4740/serial.h                          |  23 -
 arch/mips/jz4740/setup.c                           |  36 +-
 arch/mips/jz4740/time.c                            |  19 +-
 arch/mips/kernel/cpu-probe.c                       |   4 +-
 arch/mips/kernel/irq_cpu.c                         |   3 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/ingenic/Makefile                       |   3 +
 drivers/clk/ingenic/cgu.c                          | 711 ++++++++++++++++
 drivers/clk/ingenic/cgu.h                          | 223 +++++
 drivers/clk/ingenic/jz4740-cgu.c                   | 303 +++++++
 drivers/clk/ingenic/jz4780-cgu.c                   | 733 ++++++++++++++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-ingenic.c                      | 177 ++++
 drivers/tty/serial/8250/8250_ingenic.c             | 266 ++++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   3 +
 include/dt-bindings/clock/jz4740-cgu.h             |  37 +
 include/dt-bindings/clock/jz4780-cgu.h             |  88 ++
 .../irq.h => include/linux/irqchip/ingenic.h       |   8 +-
 53 files changed, 3205 insertions(+), 1424 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,cgu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,uart.txt
 create mode 100644 arch/mips/boot/dts/ingenic/Makefile
 create mode 100644 arch/mips/boot/dts/ingenic/ci20.dts
 create mode 100644 arch/mips/boot/dts/ingenic/jz4740.dtsi
 create mode 100644 arch/mips/boot/dts/ingenic/jz4780.dtsi
 create mode 100644 arch/mips/boot/dts/ingenic/qi_lb60.dts
 create mode 100644 arch/mips/configs/ci20_defconfig
 delete mode 100644 arch/mips/jz4740/clock-debugfs.c
 delete mode 100644 arch/mips/jz4740/clock.c
 delete mode 100644 arch/mips/jz4740/clock.h
 delete mode 100644 arch/mips/jz4740/irq.c
 delete mode 100644 arch/mips/jz4740/serial.c
 delete mode 100644 arch/mips/jz4740/serial.h
 create mode 100644 drivers/clk/ingenic/Makefile
 create mode 100644 drivers/clk/ingenic/cgu.c
 create mode 100644 drivers/clk/ingenic/cgu.h
 create mode 100644 drivers/clk/ingenic/jz4740-cgu.c
 create mode 100644 drivers/clk/ingenic/jz4780-cgu.c
 create mode 100644 drivers/irqchip/irq-ingenic.c
 create mode 100644 drivers/tty/serial/8250/8250_ingenic.c
 create mode 100644 include/dt-bindings/clock/jz4740-cgu.h
 create mode 100644 include/dt-bindings/clock/jz4780-cgu.h
 rename arch/mips/jz4740/irq.h => include/linux/irqchip/ingenic.h (74%)

-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
