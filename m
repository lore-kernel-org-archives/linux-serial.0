From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.2-rc2
Date: Fri, 26 Jun 2015 12:24:55 -0700
Message-ID: <20150626192455.GA25662@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit d4a4f75cd8f29cd9464a5a32e9224a91571d=
6649:

  Linux 4.1-rc7 (2015-06-07 20:23:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.2-rc1

for you to fetch changes up to 71206b9f8120eb513c621d4f31906577bb658df3=
:

  Doc: serial-rs485.txt: update RS485 driver interface (2015-06-12 17:3=
9:51 -0700)

----------------------------------------------------------------
TTY/Serial driver patches for 4.2-rc1

Here's the tty and serial driver patches for 4.2-rc1.

A number of individual driver updates, some code cleanups, and other
minor things, full details in the shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andre Przywara (10):
      drivers: PL011: avoid potential unregister_driver call
      drivers: PL011: refactor pl011_startup()
      drivers: PL011: refactor pl011_shutdown()
      drivers: PL011: refactor pl011_set_termios()
      drivers: PL011: refactor pl011_probe()
      drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
      drivers: PL011: move cts_event workaround into separate function
      drivers: PL011: allow avoiding UART enabling/disabling
      drivers: PL011: allow to supply fixed option string
      drivers: PL011: add support for the ARM SBSA generic UART

Arnd Bergmann (3):
      tty: remove platform_sysrq_reset_seq
      serial: samsung: only use earlycon for console
      tty: serial/8250: remove console dependency for mediatek

Baruch Siach (3):
      MAINTAINERS: tty: add serial docs directory
      Doc: tty.txt: remove mention of the BKL
      Doc: serial-rs485.txt: update RS485 driver interface

Daniel Axtens (1):
      tty/hvc: remove celleb-only beat driver

Daniel Vetter (1):
      vt: Don't check KD_GRAPHICS when binding/unbinding

Dave Martin (3):
      Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART i=
s not open"
      serial/amba-pl011: Refactor and simplify TX FIFO handling
      serial/amba-pl011: Fix mismerge between v4.1-rc4 and tty-next

Eddie Huang (2):
      tty: serial: 8250: export early_serial8250_setup function
      tty: serial: 8250_mtk: Add earlycon

=46abio Estevam (1):
      serial: imx: Remove return value from imx_setup_ufcr()

=46ernando Guzman Lugo (1):
      serial: sprd: check for NULL after calling devm_clk_get

=46iro Yang (1):
      ARM: meson: serial: convert iounmap to devm_iounmap

Geert Uytterhoeven (18):
      serial: ifx6x60: Remove dangerous spi_driver casts
      serial: ifx6x60: Remove superfluous casts when calling request_ir=
q()
      serial: SERIAL_IFX6X60 should depend on HAS_DMA
      serial: sh-sci: Move private definitions to private header file
      serial: sh-sci: Add (H)SCIF RTS/CTS pin data register bit definit=
ions
      serial: sh-sci: Add SCIFA/B SCPCR register definitions
      serial: sh-sci: Document remaining FIFO Control Register bits
      serial: sh-sci: Standardize on using the BIT() macro to define re=
gister bits
      serial: sh-sci: Replace hardcoded values in SCxSR_*_CLEAR macros
      serial: sh-sci: Replace hardcoded overrun bit values
      serial: sh-sci: Use the correct register for overrun checks
      serial: sh-sci: Don't set SCLSR bits in the SCxSR error mask
      serial: sh-sci: Remove obsolete comment about overrun detection
      serial: sh-sci: Add DMA support to the DT binding documentation
      ARM: shmobile: r8a7790 dtsi: Describe DMA for the serial ports
      ARM: shmobile: r8a7791 dtsi: Describe DMA for the serial ports
      ARM: shmobile: r8a7794 dtsi: Describe DMA for the serial ports
      tty: Spelling s/reseved/reserved/

Graeme Gregory (1):
      drivers: PL011: add ACPI probing for SBSA UART

Greg Kroah-Hartman (17):
      tty: 68328serial.c: move assignment out of if () block
      tty: amiserial.c: move assignment out of if () block
      tty: consolemap.c: move assignment out of if () block
      tty: crisv10.c: move assignment out of if () block
      tty: hvc_console.c: move assignment out of if () block
      tty: hvcs.c: move assignment out of if () block
      tty: icom.c: move assignment out of if () block
      tty: ioc3_serial.c: move assignment out of if () block
      tty: ioc4_serial.c: move assignment out of if () block
      tty: mpsc.c: move assignment out of if () block
      tty: synclink.c: move assignment out of if () block
      tty: synclink_gt.c: move assignment out of if () block
      tty: synclinkmp.c: move assignment out of if () block
      tty: tty_buffer.c: move assignment out of if () block
      tty: tty_ldsem.c: move assignment out of if () block
      Merge 4.1-rc4 into tty-next
      Merge 4.1-rc7 into tty-next

Heikki Krogerus (1):
      serial: 8250_dw: support ACPI platforms with integrated DMA engin=
e

Imre Deak (1):
      vt: fix console lock vs. kernfs s_active lock order

Jakub Kicinski (8):
      sc16is7xx: remove RS-485 delay RTS handling
      sc16is7xx: add missing compatible strings
      sc16is7xx: use LSR_TEMT_BIT in .tx_empty()
      sc16is7xx: use kthread_worker for tx_work and irq
      sc16is7xx: move RTS delay to workqueue
      sc16is7xx: use kworker for md_proc
      sc16is7xx: use kworker to update ier bits
      sc16is7xx: use kworker for RS-485 configuration

Jan Kiszka (1):
      serial: 8250: Do nothing if nr_uarts=3D0

Jiada Wang (1):
      serial: imx: protect Soft Reset of port with lock

Jiri Slaby (1):
      tty: move linux/gsmmux.h to uapi

Joachim Eastwood (2):
      serial: 8250: add LPC18xx/43xx UART driver
      doc: dt: add documentation for nxp,lpc1850-uart

Joakim Nordell (1):
      serial: core: cleanup in uart_get_baud_rate()

Joe Perches (1):
      serial: kgdb_nmi: Use bool function return values of true/false n=
ot 1/0

John Ogness (3):
      ARM: common: edma: clear completion interrupts on stop
      dmaenegine: edma: allow pause/resume for non-cyclic mode
      tty: serial: 8250: omap: synchronize rx_running

Jon Hunter (7):
      serial: tegra: Correct delay after TX flush
      serial: tegra: Add delay after enabling FIFO mode
      serial: tegra: Use unsigned types for RX and TX byte counts
      serial: tegra: Fix cookie used by TX channel
      serial: tegra: Correct shutdown of UARTs
      serial: tegra: Correct error handling on DMA setup
      serial: tegra: Fix memory leak on DMA setup failure

Krzysztof Kozlowski (4):
      serial: imx: Constify platform_device_id
      serial: mxs: Constify platform_device_id
      serial: samsung: Staticize local symbol
      serial: samsung: Constify platform_device_id

Leilei Zhao (1):
      tty/serial: at91: handle IRQ status more safely

Masahiro Yamada (11):
      serial: xuartps: add __init to earlycon write method
      serial: 8250: do not copy port.fifosize member twice
      serial: of_serial: do not set port.type twice
      tty: rocket: fix comment of ROCKET_SPD_HI
      tty: fix comment of ASYNCB_SPD_HI
      serial: 8250: include <linux/serial_reg.h> from serial_8250.h
      serial: 8250: remove return statements from void function
      serial: of_serial: use devm_clk_get() instead of clk_get()
      serial: of_serial: check the return value of clk_prepare_enable()
      serial: 8250_uniphier: add UniPhier serial driver
      serial: 8250_uniphier: add bindings document for UniPhier UART

Maxime Coquelin (1):
      serial: stm32-usart: Add STM32 USART Driver

Nicolas Ferre (1):
      tty/serial: at91: RS485 mode: 0 is valid for delay_rts_after_send

Noam Camus (1):
      serial: earlycon: Add support for big-endian MMIO accesses

Peter Hurley (1):
      serial: core: Fix unused variable warnings from uart_console()

Qipan Li (13):
      Revert "serial: sirf: add a new uart type support"
      serial: sirf: move from clk_get to devm_clk_get
      serial: sirf: use dynamic method allocate uart structure
      serial: sirf: use uart_port's fifosize for fifo related operation
      serial: sirf: enable ATLAS7 USP serial support
      serial: sirf: fix the issue that HW flow control doesn't work for=
 BT
      serial: sirf: fix endless loop bug in uart receive tasklet
      serial: sirf: add uart receive's some error counter and mark
      serial: sirf: add serial loopback function support
      serial: sirf: assign console default index if users not set a val=
id one
      serial: sirf: fix system hung on console log output
      serial: sirf: correct the fifo empty_bit
      serial: sirf: use hrtimer for data rx

Rama Kiran Kumar Indrakanti (2):
      sc16is7xx: spi interface is added
      sc16is7xx: spi interface documentation

Rasmus Villemoes (3):
      tty: constify return type of tty_name
      tty: return tty->name directly from tty_name
      tty: remove buf parameter from tty_name()

Rob Herring (1):
      tty/serial: kill off set_irq_flags usage

Sascha Hauer (4):
      tty: serial: 8250_mtk: remove unnecessary test
      tty: serial: 8250_mtk: Use devm_clk_get
      tty: serial: 8250_mtk: use pm_runtime callbacks for enabling
      tty: serial: 8250_mtk: Add support for bus clock

Scot Doyle (2):
      vt: add cursor blink interval escape sequence
      fbcon: use the cursor blink interval provided by vt

Sebastian Andrzej Siewior (1):
      serial: 8250_omap: provide complete custom startup & shutdown cal=
lbacks

Shardar Shariff Md (2):
      serial: tegra: check the count and read if any from dma
      serial: tegra: handle race condition on uart rx side

Soeren Grunewald (2):
      serial: 8250_pci: Add support for 12 port Exar boards
      serial: 8250_pci: Correct uartclk for xr17v35x expansion chips

Stephen Boyd (1):
      TTY: msm_smd_tty: Remove unused driver

Thierry Reding (1):
      fbcon: Avoid deleting a timer in IRQ context

Uwe Kleine-K=F6nig (1):
      serial: mctrl-gpio: drop usages of IS_ERR_OR_NULL

Valentin Rothberg (12):
      drivers/tty/serial/sh-sci.h: remove dead reference on ARCH_SH7372
      drivers/tty/serial: altera: fix typos in #endif comments
      drivers/tty/serial/crisv10.c: remove dead #ifdef block
      drivers/tty/serial/crisv10.c: remove dead #ifdef blocks
      drivers/tty/serial/crisv10.c: remove dead #ifdef blocks
      drivers/tty/serial/crisv10.c: rename CPP identifier CONFIG_ETRAX_=
SERX_DTR_RI_DSR_CD_MIXED
      drivers/tty/serial/8250/8250_core.c: remove CONFIG_HUB6
      drivers/tty/serial/mpc52xx_uart.c: fix typo in C comment
      serial: bfin: ctsrts: enfore Kconfig naming convention
      drivers/tty/serial/mcf.c: fix typo on SERIAL_MCF_CONSOLE
      serial: 8250: remove Kconfig indirection
      drivers/tty/nozomi.c: rename CONFIG_MAGIC

 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |  10 +
 .../devicetree/bindings/serial/mtk-uart.txt        |  12 +-
 .../bindings/serial/nxp,lpc1850-uart.txt           |  28 +
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   |  37 ++
 .../bindings/serial/renesas,sci-serial.txt         |   7 +
 .../devicetree/bindings/serial/sirf-uart.txt       |  15 +-
 .../devicetree/bindings/serial/uniphier-uart.txt   |  23 +
 Documentation/kernel-parameters.txt                |   9 +-
 Documentation/serial/serial-rs485.txt              |  50 +-
 Documentation/serial/tty.txt                       |   3 -
 MAINTAINERS                                        |   1 +
 arch/alpha/include/asm/serial.h                    |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  20 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  36 +
 arch/arm/boot/dts/r8a7794.dtsi                     |  36 +
 arch/arm/common/edma.c                             |   3 +
 arch/blackfin/include/asm/bfin_serial.h            |   8 +-
 arch/m68k/include/asm/serial.h                     |   2 +-
 arch/mn10300/include/asm/serial.h                  |   4 +-
 arch/x86/include/asm/serial.h                      |   2 +-
 drivers/dma/edma.c                                 |   7 +-
 drivers/input/serio/serport.c                      |   5 +-
 drivers/tty/amiserial.c                            |  11 +-
 drivers/tty/cyclades.c                             |   8 +-
 drivers/tty/hvc/Kconfig                            |   7 -
 drivers/tty/hvc/Makefile                           |   1 -
 drivers/tty/hvc/hvc_beat.c                         | 134 ----
 drivers/tty/hvc/hvc_console.c                      |   3 +-
 drivers/tty/hvc/hvcs.c                             |   4 +-
 drivers/tty/n_gsm.c                                |   5 +-
 drivers/tty/n_tty.c                                |   7 +-
 drivers/tty/nozomi.c                               |   8 +-
 drivers/tty/rocket.h                               |   2 +-
 drivers/tty/serial/68328serial.c                   |   3 +-
 drivers/tty/serial/8250/8250_core.c                |  27 +-
 drivers/tty/serial/8250/8250_dw.c                  |  19 +-
 drivers/tty/serial/8250/8250_early.c               |   2 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             | 230 +++++++
 drivers/tty/serial/8250/8250_mtk.c                 | 119 ++--
 drivers/tty/serial/8250/8250_omap.c                |  65 +-
 drivers/tty/serial/8250/8250_pci.c                 |  41 +-
 drivers/tty/serial/8250/8250_uniphier.c            | 257 +++++++
 drivers/tty/serial/8250/Kconfig                    |  15 +
 drivers/tty/serial/8250/Makefile                   |   2 +
 drivers/tty/serial/Kconfig                         |  72 +-
 drivers/tty/serial/Makefile                        |   4 +-
 drivers/tty/serial/altera_jtaguart.c               |   2 +-
 drivers/tty/serial/altera_uart.c                   |   2 +-
 drivers/tty/serial/amba-pl011.c                    | 651 +++++++++++--=
-----
 drivers/tty/serial/atmel_serial.c                  |  22 +-
 drivers/tty/serial/bfin_uart.c                     |  24 +-
 drivers/tty/serial/crisv10.c                       | 106 +--
 drivers/tty/serial/earlycon.c                      |   9 +-
 drivers/tty/serial/icom.c                          |  11 +-
 drivers/tty/serial/ifx6x60.c                       |  19 +-
 drivers/tty/serial/imx.c                           |  18 +-
 drivers/tty/serial/ioc3_serial.c                   |   3 +-
 drivers/tty/serial/ioc4_serial.c                   |   9 +-
 drivers/tty/serial/kgdb_nmi.c                      |   6 +-
 drivers/tty/serial/mcf.c                           |   2 +-
 drivers/tty/serial/meson_uart.c                    |   2 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   2 +-
 drivers/tty/serial/mpsc.c                          |  25 +-
 drivers/tty/serial/msm_smd_tty.c                   | 232 -------
 drivers/tty/serial/mxs-auart.c                     |   2 +-
 drivers/tty/serial/of_serial.c                     |   8 +-
 drivers/tty/serial/samsung.c                       |   4 +-
 drivers/tty/serial/sc16is7xx.c                     | 328 ++++++---
 drivers/tty/serial/serial-tegra.c                  | 158 +++--
 drivers/tty/serial/serial_core.c                   |  32 +-
 drivers/tty/serial/serial_ks8695.c                 |   2 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |   5 +-
 drivers/tty/serial/sh-sci.c                        |  96 +--
 drivers/tty/serial/sh-sci.h                        | 140 +++-
 drivers/tty/serial/sirfsoc_uart.c                  | 622 ++++++++-----=
----
 drivers/tty/serial/sirfsoc_uart.h                  | 120 ++--
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 drivers/tty/serial/stm32-usart.c                   | 739 +++++++++++++=
++++++++
 drivers/tty/serial/xilinx_uartps.c                 |   3 +-
 drivers/tty/synclink.c                             |  15 +-
 drivers/tty/synclink_gt.c                          |  15 +-
 drivers/tty/synclinkmp.c                           |  12 +-
 drivers/tty/sysrq.c                                |  19 +-
 drivers/tty/tty_buffer.c                           |   3 +-
 drivers/tty/tty_io.c                               |  34 +-
 drivers/tty/tty_ioctl.c                            |   4 +-
 drivers/tty/tty_ldisc.c                            |   8 +-
 drivers/tty/tty_ldsem.c                            |   3 +-
 drivers/tty/vt/consolemap.c                        |  60 +-
 drivers/tty/vt/vt.c                                |  92 ++-
 drivers/video/console/fbcon.c                      |   5 +-
 drivers/video/console/fbcon.h                      |   1 +
 include/linux/console_struct.h                     |   1 +
 include/linux/serial_8250.h                        |   3 +
 include/linux/serial_core.h                        |   2 +-
 include/linux/serial_sci.h                         |  86 +--
 include/linux/tty.h                                |   2 +-
 include/uapi/linux/Kbuild                          |   1 +
 include/{ =3D> uapi}/linux/gsmmux.h                  |   3 +
 include/uapi/linux/serial_core.h                   |   3 +
 include/uapi/linux/tty_flags.h                     |   2 +-
 101 files changed, 3326 insertions(+), 1820 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_u=
art.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc185=
0-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/uniphier-u=
art.txt
 delete mode 100644 drivers/tty/hvc/hvc_beat.c
 create mode 100644 drivers/tty/serial/8250/8250_lpc18xx.c
 create mode 100644 drivers/tty/serial/8250/8250_uniphier.c
 delete mode 100644 drivers/tty/serial/msm_smd_tty.c
 create mode 100644 drivers/tty/serial/stm32-usart.c
 rename include/{ =3D> uapi}/linux/gsmmux.h (94%)
