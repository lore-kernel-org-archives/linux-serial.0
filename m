From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver patches for 4.9-rc1
Date: Mon, 3 Oct 2016 16:40:05 +0200
Message-ID: <20161003144005.GA15250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.9-rc1

for you to fetch changes up to 08bf21590041550e5ffd4d33e6a58548d0d09142:

  Revert "serial: pl011: add console matching function" (2016-09-30 07:46:35 +0200)

----------------------------------------------------------------
TTY/Serial patches for 4.9-rc1

Here is the big TTY and Serial patch set for 4.9-rc1.

It also includes some drivers/dma/ changes, as those were needed by some
serial drivers, and they were all acked by the DMA maintainer.  Also in
here is the long-suffering ACPI SPCR patchset, which was passed around
from maintainer to maintainer like a hot-potato.  Seems I was the
sucker^Wlucky one.  All of those patches have been acked by the various
subsystem maintainers as well.

All of this has been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Borowski (5):
      vt: Fix a read-past-array in vc_t416_color().
      vt: Make a comparison <= for readability.
      vt: Drop a no longer true comment.
      vt: Support \e[90-97m (bright foreground colors).
      vt: Emulate \e[100-107m (bright background colors).

Aleksey Makarov (3):
      ACPI: parse SPCR and enable matching console
      ARM64: ACPI: enable ACPI_SPCR_TABLE
      serial: pl011: add console matching function

Alexander Sverdlin (2):
      serial: earlycon: Extend earlycon command line option to support 64-bit addresses
      serial: core: Fix handling of options after MMIO address

Alexandre TORGUE (10):
      serial: stm32: adding support for stm32f7
      DOCUMENTATION: dt-bindings: Document the STM32 USART bindings
      serial: stm32: header file creation
      serial: stm32: disable tx and rx during shutdown
      serial: stm32: correct flow control property spelling
      serial: stm32: clock disabling management
      dt-bindings: Add DMA bindings for STM32 USART
      serial: stm32: adding dma support
      serial: stm32: fix spin_lock management
      serial: stm32: fix uart enable management

Alexey Starikovskiy (1):
      tty/serial: atmel: fix fractional baud rate computation

Andy Shevchenko (15):
      dmaengine: dw: keep copy of custom slave config in dwc
      dmaengine: dw: set polarity of handshake interface
      dmaengine: dw: override LLP support if asked in platform data
      dmaengine: dw: provide probe(), remove() stubs for users
      serial: 8250_dma: switch to new dmaengine_terminate_* API
      serial: 8250_dma: adjust DMA address of the UART
      serial: 8250: enable AFE on ports where FIFO is 16 bytes
      serial: 8250_lpss: split LPSS driver to separate module
      serial: 8250_lpss: move Quark code from PCI driver
      serial: 8250_lpss: enable MSI for Intel Quark
      serial: 8250_lpss: enable DMA on Intel Quark UART
      serial: 8250_port: fix runtime PM use in __do_stop_tx_rs485()
      serial: 8250_port: unify check of em485 variable
      dmaengine: hsu: refactor hsu_dma_do_irq() to return int
      serial: core: fix potential NULL pointer dereference

Anirudha Sarangi (2):
      serial: xuartps: Do not enable parity error interrupt
      serial: xuartps: Rewrite the interrupt handling logic

Arnd Bergmann (1):
      serial: stm32: use mapbase instead of membase for DMA

Baoyou Xie (2):
      tty/serial: mark __init early_smh_setup() static
      serial: stm32: mark symbols static where possible

Bhuvanchandra DV (5):
      tty: serial: fsl_lpuart: Fix broken 8m/s1 support
      tty: serial: fsl_lpuart: Use cyclic DMA for Rx
      tty: serial: fsl_lpuart: Use scatter/gather DMA for Tx
      tty: serial: fsl_lpuart: Update suspend/resume for DMA mode
      tty: serial: fsl_lpuart: Add support for RS-485

Christophe JAILLET (1):
      serial: vt8500_serial: Fix a parameter of find_first_zero_bit.

Eddie Huang (1):
      serial: 8250_mtk: support big baud rate.

Eric W. Biederman (6):
      devpts: Move parse_mount_options into fill_super
      devpts: Move the creation of /dev/pts/ptmx into fill_super
      devpts: Simplify devpts_mount by using mount_nodev
      devpts: Make devpts_kill_sb safe if fsi is NULL
      devpts: Remove sync_filesystems
      devpts: Change the owner of /dev/pts/ptmx to the mounter of /dev/pts

Fabien Lahoudere (1):
      serial: imx: Replace dmaengine old API

Fabio Estevam (1):
      serial: mxs-auart: Disable clock on error path

Florian Vallee (1):
      sc16is7xx: make sure device is in suspend once probed

Greg Kroah-Hartman (3):
      Merge 4.8-rc5 into tty-next
      Revert "drivers/tty: Explicitly pass current to show_stack"
      Revert "serial: pl011: add console matching function"

Jan Kiszka (1):
      serial: 8250_pci: Use symbolic constants for EXAR's MPIO registers

Jiri Olsa (1):
      tty/serial/8250: Touch NMI watchdog in wait_for_xmitr

Julia Lawall (10):
      tty/serial: at91: use of_property_read_bool
      serial/arc: constify uart_ops structures
      serial: st-asc: constify uart_ops structures
      tty/serial: at91: constify uart_ops structures
      serial: altera: constify uart_ops structures
      serial/bcm63xx_uart: constify uart_ops structures
      tty: serial: jsm_tty: constify uart_ops structures
      tty: serial: constify uart_ops structures
      tty: xuartps: constify uart_ops structures
      serial-uartlite: constify uart_ops structures

Kees Cook (1):
      pty: make ptmx file ops read-only after init

Kefeng Wang (4):
      serial: 8250_dw: Check the data->pclk when get apb_pclk
      serial: 8250_dw: Use an unified new dev variable in probe
      serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 SoC
      tty: amba-pl011: Don't complain on -EPROBE_DEFER when no irq

Krzysztof Kozlowski (1):
      serial: samsung: Register cpufreq notifier only on S3C24xx

Leif Lindholm (1):
      of/serial: move earlycon early_param handling to serial

Liu Xiang (1):
      serial: max310x: Set IRQF_TRIGGER_FALLING flag when dev.of_node is not NULL

Ludovic Desroches (1):
      tty/serial: atmel: add fractional baud rate support

Mark Rutland (1):
      drivers/tty: Explicitly pass current to show_stack

Martyn Welch (1):
      Allowing UART DMA to be configured on i.MX53

Nandor Han (4):
      dmaengine: imx-sdma - reduce transfer latency for DMA cyclic clients
      dmaengine: imx-sdma - update the residue calculation for cyclic channels
      serial: imx-serial - update UART IMX driver to use cyclic DMA
      serial: imx-serial - update RX error counters when DMA is used

Nava kishore Manne (3):
      serial: xuartps: Adds RXBS register support for zynqmp
      tty: serial: xuartps: Wait for rx and tx reset done status
      serial: xuartps: Removed unwanted checks while reading the error conditions

Nicolas Ferre (1):
      MAINTAINERS: update entry for atmel_serial driver

Richard Genoud (1):
      BUG: atmel_serial: Interrupts not disabled on close

Rob Herring (3):
      tty: serial_core: convert uart_open to use tty_port_open
      tty: serial_core: convert uart_close to use tty_port_close
      tty: serial_core: add tty NULL check to uart_tx_stopped

Sascha Hauer (1):
      serial: imx: Fix DCD reading

Scott Telford (1):
      serial: xuartps: Add some register initialisation to cdns_early_console_setup()

Shawn Guo (4):
      tty: amba-pl011: define flag register bits for ZTE device
      tty: amba-pl011: add .get_fifosize for ZTE device
      tty: amba-pl011: probe ZTE device from AMBA bus with a pseudo-ID
      tty: amba-pl011: uart_amba_port is not available with earlycon function

Stefan Agner (3):
      tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
      tty: serial: fsl_lpuart: support suspend/resume
      tty: serial: fsl_lpuart: fix clearing of receive flag

Thor Thayer (4):
      Documentation: dt: serial: Add TX FIFO threshold parameter
      serial: 8250: of: Load TX FIFO Threshold from DT
      serial: 8250: Set Altera 16550 TX FIFO Threshold
      nios2: dts: 10m50: Add tx-threshold parameter

Uwe Kleine-König (1):
      serial: imx: add error messages when .probe fails

Wei Yongjun (3):
      serial: mxs-auart: Use PTR_ERR_OR_ZERO() to simplify the code
      tty: serial: fsl_lpuart: use GFP_ATOMIC under spin lock
      serial: mxs-auart: Fix missing clk_disable_unprepare() on error in mxs_get_clks()

 Documentation/devicetree/bindings/serial/8250.txt  |   2 +
 .../devicetree/bindings/serial/st,stm32-usart.txt  |  46 ++
 Documentation/kernel-parameters.txt                |  11 +-
 MAINTAINERS                                        |  11 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/acpi.c                           |  11 +-
 arch/nios2/boot/dts/10m50_devboard.dts             |   1 +
 drivers/acpi/Kconfig                               |   3 +
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/spcr.c                                | 111 +++
 drivers/dma/dw/core.c                              |  39 +-
 drivers/dma/dw/regs.h                              |   5 +-
 drivers/dma/hsu/hsu.c                              |   9 +-
 drivers/dma/hsu/pci.c                              |   6 +-
 drivers/dma/imx-sdma.c                             |  56 +-
 drivers/of/fdt.c                                   |  11 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/tty/serial/8250/8250.h                     |   5 +
 drivers/tty/serial/8250/8250_core.c                |   2 +-
 drivers/tty/serial/8250/8250_dma.c                 |  14 +-
 drivers/tty/serial/8250/8250_dw.c                  |  48 +-
 drivers/tty/serial/8250/8250_lpss.c                | 378 ++++++++++
 drivers/tty/serial/8250/8250_mid.c                 |   8 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   6 +-
 drivers/tty/serial/8250/8250_of.c                  |   7 +
 drivers/tty/serial/8250/8250_pci.c                 | 312 ++------
 drivers/tty/serial/8250/8250_port.c                |  81 +-
 drivers/tty/serial/8250/Kconfig                    |  16 +-
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/altera_jtaguart.c               |   2 +-
 drivers/tty/serial/altera_uart.c                   |   2 +-
 drivers/tty/serial/amba-pl011.c                    |  57 +-
 drivers/tty/serial/arc_uart.c                      |   2 +-
 drivers/tty/serial/atmel_serial.c                  |  58 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   2 +-
 drivers/tty/serial/earlycon-arm-semihost.c         |   3 +-
 drivers/tty/serial/earlycon.c                      |  26 +-
 drivers/tty/serial/fsl_lpuart.c                    | 814 ++++++++++++---------
 drivers/tty/serial/imx.c                           | 213 ++++--
 drivers/tty/serial/jsm/jsm_tty.c                   |   2 +-
 drivers/tty/serial/max3100.c                       |   2 +-
 drivers/tty/serial/max310x.c                       |   2 +-
 drivers/tty/serial/men_z135_uart.c                 |   2 +-
 drivers/tty/serial/mxs-auart.c                     |  15 +-
 drivers/tty/serial/pch_uart.c                      |   2 +-
 drivers/tty/serial/samsung.c                       |   2 +-
 drivers/tty/serial/samsung.h                       |   2 +-
 drivers/tty/serial/sc16is7xx.c                     |  20 +
 drivers/tty/serial/serial_core.c                   | 136 ++--
 drivers/tty/serial/sh-sci.c                        |   2 +-
 drivers/tty/serial/st-asc.c                        |   2 +-
 drivers/tty/serial/stm32-usart.c                   | 613 ++++++++++++----
 drivers/tty/serial/stm32-usart.h                   | 229 ++++++
 drivers/tty/serial/timbuart.c                      |   2 +-
 drivers/tty/serial/uartlite.c                      |   2 +-
 drivers/tty/serial/vt8500_serial.c                 |   8 +-
 drivers/tty/serial/xilinx_uartps.c                 | 304 +++++---
 drivers/tty/vt/vt.c                                |  13 +-
 fs/devpts/inode.c                                  |  71 +-
 include/linux/acpi.h                               |   6 +
 include/linux/amba/bus.h                           |   6 +
 include/linux/amba/serial.h                        |   9 +
 include/linux/atmel_serial.h                       |   2 +
 include/linux/dma/dw.h                             |   5 +
 include/linux/dma/hsu.h                            |   9 +-
 include/linux/of_fdt.h                             |   3 +
 include/linux/platform_data/dma-dw.h               |   4 +
 include/linux/serial_core.h                        |  13 +-
 include/uapi/linux/serial_reg.h                    |   8 +
 69 files changed, 2610 insertions(+), 1269 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
 create mode 100644 drivers/acpi/spcr.c
 create mode 100644 drivers/tty/serial/8250/8250_lpss.c
 create mode 100644 drivers/tty/serial/stm32-usart.h
