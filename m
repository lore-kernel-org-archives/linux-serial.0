From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial updates for 4.14-rc1
Date: Mon, 4 Sep 2017 18:41:39 +0200
Message-ID: <20170904164139.GA24328@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit ef954844c7ace62f773f4f23e28d2d915adc419f:

  Linux 4.13-rc5 (2017-08-13 16:01:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.14-rc1

for you to fetch changes up to 3840ed9548f778717aaab5eab744da798c3ea055:

  tty: goldfish: Implement support for kernel 'earlycon' parameter (2017-08-31 18:58:45 +0200)

----------------------------------------------------------------
TTY/Serial updates for 4.14-rc1

Here is the big tty/serial driver update for 4.14-rc1.

Well, not all that big, just a number of small serial driver fixes, and
a new serial driver.  Also in here are some much needed goldfish tty
driver (emulator) fixes to try to get that codebase under control.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksandar Markovic (1):
      tty: goldfish: Refactor constants to better reflect their nature

Alexey Khoroshilov (2):
      serial: 8250: fix error handling in of_platform_serial_probe()
      drivers/serial: Do not leave sysfs group in case of error in aspeed_vuart_probe()

Andreas Färber (1):
      tty: serial: owl: Implement console driver

Andy Shevchenko (11):
      serial: core: enforce type for upf_t when copying
      serial: core: move UPF_NO_TXEN_TEST to quirks and rename
      serial: 8250_pci: Enable device after we check black list
      serial: fsl_lpuart: Avoid using irq_wake flag
      serial: st-asc: Avoid using irq_wake flag
      serial: stm32-usart: Avoid using irq_wake flag
      serial: core: remove unneeded irq_wake flag
      serial: pch_uart: Make port type explicit
      serial: Remove unused port type
      serial: Fix port type numbering for TI DA8xx
      serial: 8250_port: Remove useless NULL checks

Arnd Bergmann (3):
      tty: improve tty_insert_flip_char() fast path
      tty: improve tty_insert_flip_char() slow path
      tty: fix __tty_insert_flip_char regression

Arvind Yadav (16):
      tty: synclinkmp: constify pci_device_id.
      tty: isicom: constify pci_device_id.
      tty: mxser: constify pci_device_id.
      tty: synclink: constify pci_device_id.
      tty: moxa: constify pci_device_id.
      tty: serial: exar: constify pci_device_id.
      tty: serial: pci: constify pci_device_id.
      tty: synclink_gt: constify pci_device_id.
      tty: serial: jsm: constify pci_device_id.
      serial: pl010: constify amba_id
      serial: pl011: constify amba_id
      tty: 8250: constify parisc_device_id
      tty: mux: constify parisc_device_id
      tty: mips_ejtag_fdc: constify mips_cdmm_device_id
      tty: hvc_vio: constify vio_device_id
      tty: hvcs: constify vio_device_id

Bhumika Goyal (1):
      tty: hvcs: make ktermios const

Bich HEMON (2):
      serial: stm32: fix copyright
      serial: stm32: add RTS support

Eugeniy Paltsev (1):
      earlycon: initialise baud field of earlycon device structure

Fabio Estevam (1):
      serial: pch_uart: Remove unneeded NULL check

Fabrice Gasnier (3):
      serial: stm32: fix error handling in probe
      dt-bindings: serial: add compatible for stm32h7
      serial: stm32: add wakeup mechanism

Franklin S Cooper Jr (1):
      serial: 8250_of: Add basic PM runtime support

Geert Uytterhoeven (1):
      dt-bindings: serial: sh-sci: Add support for r8a77995 (H)SCIF

Gerald Baeza (4):
      serial: stm32: fix multi-ports management
      serial: stm32: Increase maximum number of ports
      serial: stm32: add fifo support
      serial: stm32: fix pio transmit timeout

Greg Kroah-Hartman (2):
      Merge 4.13-rc2 into tty-next
      Merge 4.13-rc5 into tty-next

Gustavo A. R. Silva (1):
      tty: serial: sprd: fix error return code in sprd_probe()

Himanshu Jha (1):
      tty: serial: 8250_mtk: Use PTR_ERR_OR_ZERO

Ian Jamison (1):
      serial: imx: Avoid post-PIO cleanup if TX DMA is started

Jeffy Chen (6):
      serial: arc: Remove __init marking from early write
      serial: omap: Remove __init marking from early write
      serial: xuartps: Remove __init marking from early write
      serial: 8250_ingenic: Remove __init marking from early write
      serial: 8250_early: Remove __init marking from early write
      serial: earlycon: Only try fdt when specify 'earlycon' exactly

Johannes Thumshirn (1):
      mcb: introduce mcb_get_resource()

Julia Lawall (12):
      tty: amba-pl011: constify vendor_data structures
      serial: owl: constify uart_ops structures
      serial: meson: constify uart_ops structures
      serial: uuc_uart: constify uart_ops structures
      serial: 21285: constify uart_ops structures
      serial: sunsab: constify uart_ops structures
      serial: apbuart: constify uart_ops structures
      serial: cpm_uart: constify uart_ops structures
      serial: m32r_sio: constify uart_ops structures
      serial: mpc52xx: constify uart_ops structures
      serial: sunsu: constify uart_ops structures
      serial: mux: constify uart_ops structures

Lanqing Liu (1):
      serial: sprd: clear timeout interrupt only rather than all interrupts

Lars Poeschel (1):
      tty: n_gsm: Add compat_ioctl

Marius Vlad (1):
      tty/serial/fsl_lpuart: Add CONSOLE_POLL support for lpuart32.

Masahiro Yamada (3):
      serial: 8250_uniphier: fix serial port index in private data
      serial: 8250_uniphier: use CHAR register for canary to detect power-off
      serial: 8250_uniphier: add suspend/resume support

Masatake YAMATO (1):
      pty: show associative slave of ptmx in fdinfo

Maxim Yu. Osipov (1):
      tty: serial: imx: disable irq after suspend

Michael Moese (1):
      Introduce 8250_men_mcb

Miodrag Dinic (2):
      tty: goldfish: Use streaming DMA for r/w operations on Ranchu platforms
      tty: goldfish: Implement support for kernel 'earlycon' parameter

Neeraj Upadhyay (1):
      tty: serial: msm: Move request_irq to the end of startup

Philipp Zabel (2):
      serial: 8250_dw: explicitly request exclusive reset control
      serial: tegra: explicitly request exclusive reset control

Rafael Gago (2):
      serial: core: Consider rs485 settings to drive RTS
      serial: 8250: Use hrtimers for rs485 delays

Rob Herring (1):
      tty: Convert to using %pOF instead of full_name

Sean Wang (2):
      dt-bindings: serial: 8250: Add MediaTek BTIF controller bindings
      serial: 8250: of: Add new port type for MediaTek BTIF controller on MT7622/23 SoC

Sergei Shtylyov (2):
      serial: sh-sci: use of_property_read_bool()
      serial: 8250_of: use of_property_read_bool()

Uwe Kleine-König (3):
      serial: imx: drop useless member from driver data
      serial: fsl_lpuart: clear unsupported options in .rs485_config()
      dt-bindings: serial/rs485: make rs485-rts-delay optional

 Documentation/devicetree/bindings/serial/8250.txt  |   2 +
 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 Documentation/devicetree/bindings/serial/rs485.txt |   5 +-
 .../devicetree/bindings/serial/st,stm32-usart.txt  |  17 +-
 drivers/mcb/mcb-core.c                             |  20 +-
 drivers/tty/Kconfig                                |   3 +
 drivers/tty/ehv_bytechan.c                         |   2 +-
 drivers/tty/goldfish.c                             | 234 ++++++--
 drivers/tty/hvc/hvc_opal.c                         |  16 +-
 drivers/tty/hvc/hvc_vio.c                          |   8 +-
 drivers/tty/hvc/hvcs.c                             |   4 +-
 drivers/tty/isicom.c                               |   2 +-
 drivers/tty/mips_ejtag_fdc.c                       |   2 +-
 drivers/tty/moxa.c                                 |   2 +-
 drivers/tty/mxser.c                                |   2 +-
 drivers/tty/n_gsm.c                                |  11 +
 drivers/tty/pty.c                                  |   8 +-
 drivers/tty/serdev/core.c                          |   2 +-
 drivers/tty/serial/21285.c                         |   2 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   7 +-
 drivers/tty/serial/8250/8250_core.c                |  16 +-
 drivers/tty/serial/8250/8250_dw.c                  |   2 +-
 drivers/tty/serial/8250/8250_early.c               |   8 +-
 drivers/tty/serial/8250/8250_exar.c                |   2 +-
 drivers/tty/serial/8250/8250_gsc.c                 |   4 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   8 +-
 drivers/tty/serial/8250/8250_men_mcb.c             | 118 ++++
 drivers/tty/serial/8250/8250_mtk.c                 |   5 +-
 drivers/tty/serial/8250/8250_of.c                  |  60 +-
 drivers/tty/serial/8250/8250_pci.c                 |  43 +-
 drivers/tty/serial/8250/8250_port.c                |  81 ++-
 drivers/tty/serial/8250/8250_uniphier.c            |  63 +-
 drivers/tty/serial/8250/Kconfig                    |  11 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/Kconfig                         |   4 +-
 drivers/tty/serial/amba-pl010.c                    |   2 +-
 drivers/tty/serial/amba-pl011.c                    |   6 +-
 drivers/tty/serial/apbuart.c                       |   2 +-
 drivers/tty/serial/arc_uart.c                      |   4 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   2 +-
 drivers/tty/serial/earlycon.c                      |   7 +-
 drivers/tty/serial/fsl_lpuart.c                    |  76 ++-
 drivers/tty/serial/imx.c                           |  20 +-
 drivers/tty/serial/jsm/jsm_driver.c                |   2 +-
 drivers/tty/serial/m32r_sio.c                      |   2 +-
 drivers/tty/serial/meson_uart.c                    |   2 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  14 +-
 drivers/tty/serial/msm_serial.c                    |  19 +-
 drivers/tty/serial/mux.c                           |   6 +-
 drivers/tty/serial/omap-serial.c                   |  13 +-
 drivers/tty/serial/owl-uart.c                      | 635 ++++++++++++++++++++-
 drivers/tty/serial/pch_uart.c                      |  38 +-
 drivers/tty/serial/pmac_zilog.c                    |   4 +-
 drivers/tty/serial/serial-tegra.c                  |   2 +-
 drivers/tty/serial/serial_core.c                   |  47 +-
 drivers/tty/serial/sh-sci.c                        |   3 +-
 drivers/tty/serial/sprd_serial.c                   |   8 +-
 drivers/tty/serial/st-asc.c                        |   2 +-
 drivers/tty/serial/stm32-usart.c                   | 125 +++-
 drivers/tty/serial/stm32-usart.h                   |  37 +-
 drivers/tty/serial/sunsab.c                        |   2 +-
 drivers/tty/serial/sunsu.c                         |   6 +-
 drivers/tty/serial/ucc_uart.c                      |   2 +-
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 drivers/tty/synclink.c                             |   2 +-
 drivers/tty/synclink_gt.c                          |   2 +-
 drivers/tty/synclinkmp.c                           |   2 +-
 drivers/tty/tty_buffer.c                           |  26 +
 drivers/tty/tty_io.c                               |   9 +
 include/linux/mcb.h                                |   2 +
 include/linux/serial_8250.h                        |   7 +-
 include/linux/serial_core.h                        |  10 +-
 include/linux/tty_driver.h                         |   2 +
 include/linux/tty_flip.h                           |   3 +-
 include/uapi/linux/serial_core.h                   |  14 +-
 75 files changed, 1634 insertions(+), 312 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_men_mcb.c
