From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 3.20-rc1
Date: Sun, 15 Feb 2015 07:13:13 -0800
Message-ID: <20150215151313.GA31904@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc:

  Linux 3.19-rc5 (2015-01-18 18:02:20 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.20-rc1

for you to fetch changes up to c09babfab7ae8c7d79a5dce9d866fbb28b82dde4:

  serial: 8250: Fix UART_BUG_TXEN workaround (2015-02-07 18:44:55 +0800)

----------------------------------------------------------------
TTY/Serial driver patches for 3.20-rc1

Here's the big tty/serial driver update for 3.20-rc1.  Nothing huge
here, just lots of driver updates and some core tty layer fixes as well.
All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (4):
      serial: 8250_dma: terminate transfer explicitly when timeout
      x86, mrst: remove Moorestown specific serial drivers
      serial: 8250_core: remove redundant else keyword
      serial: 8250_dma: don't bother DMA with small transfers

Anton Bondarenko (1):
      serial: imx: initialized DMA w/o HW flow enabled

Arnd Bergmann (1):
      tty/isicom: fix big-endian compile warning

Barry Song (1):
      serial: sirf: rename marco to atlas7

Baruch Siach (4):
      devicetree: bindings: add Conexant vendor prefix
      serial: driver for Conexant Digicolor USART
      serial: add device tree binding documentation for Conexant USART
      tty/serial: digicolor: remove sysrq reference

Chunyan Zhang (2):
      Documentation: DT: Add bindings for Spreadtrum SoC Platform
      tty/serial: Add Spreadtrum sc9836-uart driver support

Cyrille Pitchen (5):
      tty/serial: at91: use correct type for dma_sync_*_for_cpu() and dma_sync_*_for_device()
      tty/serial: at91: enable peripheral clock before accessing I/O registers
      tty/serial: at91: fix error handling in atmel_serial_probe()
      tty/serial: at91: fix RTS line management when hardware handshake is enabled
      tty/serial: at91: fix typo and indentation

Dave Airlie (1):
      vt_buffer: drop console buffer copying optimisations

Dirk Behme (6):
      serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
      serial: imx: TX DMA: clean up sg initialization
      serial: imx: unmap sg in case of dmaengine_prep_slave_sg() failure
      serial: imx: unmap scatter gather list in imx_flush_buffer
      serial: imx: use dma_is_txing to synchronize dma_tx_callback and imx_dma_tx
      serial: imx: disable TDMAEN in imx_flush_buffer()

Eric Nelson (2):
      serial: imx: preserve characters with parity or framing errors
      serial: imx: ignore framing errors when IGNPAR is set.

Fabian Frederick (1):
      tty: remove unused variable sprop

Fabio Estevam (8):
      serial: mxs-auart: Remove unneeded goto label
      serial: mxs-auart: Use devm_kzalloc()
      serial: mxs-auart: Use devm_clk_get()
      serial: mxs-auart: Use devm_request_irq()
      serial: imx: Fix imx_flush_buffer()
      serial: mxs-auart: Remove irq from private structure
      serial: mxs-auart: Check for platform_get_irq() error
      serial: mxs-auart: Remove unneeded zeroing of 'ret'

Feng Kan (1):
      serial: 8250: add support for ACPI-probed serial port for X-Gene platform

Greg Kroah-Hartman (1):
      Merge 3.19-rc5 into tty-next

Greg Ungerer (3):
      serial: mcf: change email address to gerg@uclinux.org
      serial: mcf: fix compile warnings
      serial: mcf: fix no driver name in probe output

Heikki Krogerus (1):
      serial: 8250_pci: remove one useless explicit type conversion

Hisashi Nakamura (1):
      serial: sh-sci: Fix R-Car SCIF and HSCIF overrun handling

Imre Deak (2):
      vt: fix check for system/busy console drivers when unregistering them
      vt: fix locking around vt_bind/vt_unbind

Jiada Wang (7):
      serial: imx: add CREAD flag support
      serial: imx: use locking to stop concurrent access of UCR1
      Revert "serial: imx: always wake up the processes in the TX callback"
      serial: imx: call imx_dma_tx() again in dma_tx_callback
      serial: imx: Enable UCR4_OREN in startup interface
      serial: imx: Fix issue in software flow control
      serial: imx: Support sw flow control in DMA mode

Johannes Thumshirn (1):
      tty: serial: men_z135_uart: Fix driver for changes in hardware

Julia Lawall (2):
      TTY: fix misspelling of current function in string
      TTY: fix misspelling of current function in string

Ley Foon Tan (2):
      serial: altera-juart: fix NULL device in log message
      serial: altera-uart: fix NULL device in log message

Lucas Stach (1):
      serial: of-serial: fetch line number from DT

Marek Szyprowski (1):
      serial: samsung: earlycon support depends on CONFIG_SERIAL_SAMSUNG_CONSOLE

Nathan Rossi (1):
      tty: xuartps: Fix RX hang, and TX corruption in termios call

Nicolas Pitre (1):
      vt: provide notifications on selection changes

Niklas Cassel (1):
      serial: driver for ETRAX FS UART

Pavel Machek (1):
      trivial fixes for omap-serial

Peter Hurley (28):
      serial: omap_8250: Fix RTS handling
      serial: omap_8250: Fix RTS handling, part B
      tty: Remove warning in tty_lock_slave()
      tty: Prevent untrappable signals from malicious program
      PNP: Allow console to override ACPI device sleep
      serial: 8250_pnp: Enable PNP_CONSOLE for console ports
      pty: Fix overlimit memory use
      n_tty: Eliminate receive_room() from consumer/exclusive paths
      n_tty: Fix throttle for canon lines > 3967 chars
      n_tty: Simplify throttle threshold calculation
      n_tty: Fix unordered accesses to lockless read buffer
      n_tty: Fix PARMRK over-throttling
      n_tty: Fix read buffer overwrite when no newline
      tty: Make lock subclasses available for other tty locks
      pty: Fix buffer flush deadlock
      n_tty: Fix signal handling flushes
      serial: core: Simplify console suspend logic in uart_suspend_port()
      serial: 8250: Move UART_BUG_QUOT workaround
      serial: 8250: Refactor LCR computation
      serial: 8250: Refactor divisor programming
      serial: 8250: Refactor XR17V35X divisor calculation
      serial: 8250: Use canary to restart console after suspend
      serial: 8250: Prevent concurrent updates to shadow registers
      serial: core: Rework hw-assisted flow control support
      serial: 8250_omap: Use UPSTAT_AUTORTS for RTS handling
      serial: omap: Fix RTS handling
      tty: Remove external interface for tty_set_termios()
      serial: 8250: Fix UART_BUG_TXEN workaround

Pramod Gurav (2):
      tty: serial: msm_serial: code cleanup in msm_console_setup
      tty: serial: msm_serial: Remove console unregistration from driver exit.

Rob Herring (3):
      tty/serial: of_serial: add DT alias ID handling
      tty/serial: of_serial: add support for PXA/MMP uarts
      tty/serial: 8250_early: Add support for PXA UARTs

Robert Baldyga (7):
      serial: samsung: add struct s3c24xx_uart_dma
      serial: samsung: alloc dma stucture in ourport
      serial: s3c: add missing register definitions
      serial: samsung: add dma reqest/release functions
      serial: samsung: add DMA support for TX
      serial: samsung: add DMA support for RX
      serial: samsung: remove redundant interrupt enabling

Robin Gong (1):
      serial: imx: start rx_dma once RXFIFO is not empty

Sebastian Andrzej Siewior (1):
      tty: serial: 8250: omap: add ttySx console if the user didn't

Sergei Shtylyov (1):
      sh-sci: extend PM methods

Stefan Agner (5):
      serial: fsl_lpuart: delete timer on shutdown
      serial: fsl_lpuart: avoid new transfer while DMA is running
      serial: fsl_lpuart: move DMA channel request to probe
      serial: fsl_lpuart: update RX timer on successful DMA transfer
      tty: serial: fsl_lpuart: terminate DMA on buffer flush

Stuart R. Anderson (1):
      Specify PCI based UART for earlyprintk

Tomasz Figa (2):
      serial: samsung: Add support for early console
      ARM: dts: exynos4: Add stdout-path properties

Vijay Rai (1):
      tty: 8250: Add 64byte UART support for FSL platforms

Vineet Gupta (1):
      serial: 8250_early: optimize early 8250 uart

Wolfram Sang (1):
      tty: serial: 8250: drop owner assignment from platform_drivers

Yoshihiro Kaneko (1):
      serial: sh-sci: Use dev_dbg() to log an error message

Yuan Yao (1):
      serial: fsl-lpuart: disable interrupt when suspend

kbuild test robot (1):
      tty/serial: serial8250_set_divisor() can be static

 Documentation/devicetree/bindings/arm/sprd.txt     |  11 +
 .../devicetree/bindings/serial/digicolor-usart.txt |  27 +
 .../devicetree/bindings/serial/sirf-uart.txt       |   4 +-
 .../devicetree/bindings/serial/sprd-uart.txt       |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 Documentation/kernel-parameters.txt                |  12 +
 arch/arm/boot/dts/exynos4210-origen.dts            |   1 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |   1 +
 arch/arm/boot/dts/exynos4210-trats.dts             |   1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   4 +
 arch/arm/boot/dts/exynos4412-origen.dts            |   1 +
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |   1 +
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |   4 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |   1 +
 arch/x86/include/asm/intel-mid.h                   |   3 -
 arch/x86/kernel/early_printk.c                     | 187 +++-
 arch/x86/platform/intel-mid/device_libs/Makefile   |   2 -
 .../intel-mid/device_libs/platform_max3111.c       |  35 -
 .../platform/intel-mid/early_printk_intel_mid.c    | 220 +----
 drivers/bluetooth/hci_ath.c                        |  15 +-
 drivers/pnp/driver.c                               |   2 +-
 drivers/tty/amiserial.c                            |   2 +-
 drivers/tty/ehv_bytechan.c                         |   1 -
 drivers/tty/isicom.c                               |   2 +-
 drivers/tty/n_tty.c                                | 254 +++---
 drivers/tty/pty.c                                  |  31 +-
 drivers/tty/rocket.c                               |   4 +-
 drivers/tty/serial/8250/8250_core.c                | 230 +++--
 drivers/tty/serial/8250/8250_dma.c                 |   6 +-
 drivers/tty/serial/8250/8250_dw.c                  |  11 +
 drivers/tty/serial/8250/8250_early.c               |  13 +-
 drivers/tty/serial/8250/8250_omap.c                |  88 +-
 drivers/tty/serial/8250/8250_pci.c                 |   4 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   8 +-
 drivers/tty/serial/8250/Kconfig                    |  19 +
 drivers/tty/serial/Kconfig                         |  54 +-
 drivers/tty/serial/Makefile                        |   4 +-
 drivers/tty/serial/altera_jtaguart.c               |   1 +
 drivers/tty/serial/altera_uart.c                   |   1 +
 drivers/tty/serial/atmel_serial.c                  | 153 ++--
 drivers/tty/serial/digicolor-usart.c               | 560 ++++++++++++
 drivers/tty/serial/etraxfs-uart.c                  | 996 +++++++++++++++++++++
 drivers/tty/serial/fsl_lpuart.c                    | 135 +--
 drivers/tty/serial/imx.c                           | 190 +++-
 drivers/tty/serial/mcf.c                           |   7 +-
 drivers/tty/serial/men_z135_uart.c                 | 155 +++-
 drivers/tty/serial/mrst_max3110.c                  | 909 -------------------
 drivers/tty/serial/mrst_max3110.h                  |  61 --
 drivers/tty/serial/msm_serial.c                    |  27 +-
 drivers/tty/serial/mxs-auart.c                     |  55 +-
 drivers/tty/serial/of_serial.c                     |  13 +
 drivers/tty/serial/omap-serial.c                   |  37 +-
 drivers/tty/serial/samsung.c                       | 680 +++++++++++++-
 drivers/tty/serial/samsung.h                       |  42 +
 drivers/tty/serial/serial_core.c                   | 111 +--
 drivers/tty/serial/sh-sci.c                        |  25 +-
 drivers/tty/serial/sirfsoc_uart.c                  |  40 +-
 drivers/tty/serial/sirfsoc_uart.h                  |   4 +-
 drivers/tty/serial/sprd_serial.c                   | 793 ++++++++++++++++
 drivers/tty/serial/xilinx_uartps.c                 |  10 +-
 drivers/tty/tty_buffer.c                           |   6 +
 drivers/tty/tty_ioctl.c                            |   3 +-
 drivers/tty/tty_mutex.c                            |  18 +-
 drivers/tty/vt/vt.c                                |  18 +-
 include/linux/pnp.h                                |  12 +-
 include/linux/serial_8250.h                        |   4 +
 include/linux/serial_core.h                        |  22 +-
 include/linux/serial_s3c.h                         |  28 +
 include/linux/tty.h                                |  25 +-
 include/linux/vt_buffer.h                          |   4 -
 include/uapi/linux/serial_core.h                   |  12 +-
 include/uapi/linux/serial_reg.h                    |   3 +-
 73 files changed, 4523 insertions(+), 1910 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_max3111.c
 create mode 100644 drivers/tty/serial/digicolor-usart.c
 create mode 100644 drivers/tty/serial/etraxfs-uart.c
 delete mode 100644 drivers/tty/serial/mrst_max3110.c
 delete mode 100644 drivers/tty/serial/mrst_max3110.h
 create mode 100644 drivers/tty/serial/sprd_serial.c
