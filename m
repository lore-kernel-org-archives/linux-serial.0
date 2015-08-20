From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.3-rc1
Date: Thu, 20 Aug 2015 12:11:21 -0700
Message-ID: <20150820191121.GA24594@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d1=
0a6f:

  Linux 4.2-rc4 (2015-07-26 12:26:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.3-rc1

for you to fetch changes up to c868cbb7e5c6d3c74b8d38c7c356444f2c807c28=
:

  serial: imx: save and restore context in the suspend path (2015-08-14=
 17:23:25 -0700)

----------------------------------------------------------------
TTY/Serial driver patches for 4.3-rc1

Here is the big tty/serial driver update for 4.3-rc1.

Not many major things, a number of driver updates and changes, and the
8250 driver got split up a bit to make it easier to work with by moving
some functions to a new file.  Full details are in the shortlog.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Lee (1):
      serial: 8250_pci: Add support for Pericom PI7C9X795[1248]

Alexander Stein (1):
      serial/uuc_uart: Support higher bitrates than 115200 Bit/s

Axel Lin (1):
      serial: etraxfs-uart: Convert to uart_console_device instead of o=
pen-coded

Cyrille Pitchen (6):
      ARM: at91/dt: add a new DT property to support FIFOs on Atmel USA=
RTs
      tty/serial: at91: fix some macro definitions to fit coding style
      tty/serial: at91: remove bunch of macros to access UART registers
      tty/serial: at91: add support to FIFOs
      tty/serial: at91: use 32bit writes into TX FIFO when DMA is enabl=
ed
      tty/serial: at91: fix I/O accesses on RHR and THR for AVR32

David Jander (1):
      tty: serial: imx.c: Reset UART before activating interrupts

Eduardo Valentin (4):
      serial: imx: remove unbalanced clk_prepare
      serial: imx: introduce serial_imx_enable_wakeup()
      serial: imx: allow waking up on RTSD
      serial: imx: save and restore context in the suspend path

=46abio Estevam (2):
      serial: imx: Disable irqs before requesting them
      Revert "tty: serial: imx.c: Reset UART before activating interrup=
ts"

Geert Uytterhoeven (1):
      serial: Allow compile test of GPIO consumers if !GPIOLIB

Greg Kroah-Hartman (1):
      Merge 4.2-rc4 into tty-next

Jakub Kicinski (3):
      sc16is7xx: save and use per-chip line number
      sc16is7xx: support multiple devices
      sc16is7xx: constify devtype

Javier Martinez Canillas (1):
      serial: samsung: Remove redundant DEBUG_LL check

Jiri Slaby (1):
      tty: linux/gsmmux.h needs linux/types.h

Joerg Roedel (1):
      serial: 8250: Do XR17V35X specific wakeup in serial8250_do_startu=
p

Johannes Thumshirn (2):
      tty: serial: men_z135_uart.c: Fix race between IRQ and set_termio=
s()
      tty: serial: men_z135_uart.c: Don't initialize port->lock

John Ogness (1):
      serial: 8250: move rx_running out of the bitfield

Juergen Borleis (2):
      serial: mxs-auart: use a function name to reflect what it really =
does
      serial: mxs-auart: keep the AUART unit in reset state when not in=
 use

Jun Nie (5):
      uart: pl011: Rename regs with enumeration
      uart: pl011: Introduce register accessor
      uart: pl011: Introduce register look up table
      uart: pl011: Improve LCRH register access decision
      uart: pl011: Add support to ZTE ZX296702 uart

Krzysztof Kozlowski (2):
      tty: serial: Drop owner assignment from platform_driver
      tty: serial: Drop owner assignment from i2c_driver

Maciej S. Szmigiero (2):
      serial: 8250: don't bind to SMSC IrCC IR port
      serial: 8250: bind to ALi Fast Infrared Controller (ALI5123)

Manfred Schlaegl (2):
      serial: imx: count tty buffer overruns
      serial: imx: reduce irq-latency after rx overflow

Marek Szyprowski (1):
      serial: samsung: fix DMA mode enter condition for small FIFO size=
s

Masahiro Yamada (1):
      serial: 8250_uniphier: call clk_disable_unprepare() on failure pa=
th

Maxime Coquelin (1):
      serial: stm32-usart: Fix SysRq support

Niklas Cassel (2):
      serial: etraxfs-uart: remove empty functions
      serial: etraxfs-uart: use mctrl_gpio helpers for handling modem s=
ignals

Patrick Donnelly (1):
      tty: add missing rcu_read_lock for task_pgrp

Paul Gortmaker (4):
      drivers/tty: make serial/sn_console.c driver explicitly non-modul=
ar
      drivers/tty: make serial/lantic.c driver explicitly non-modular
      drivers/tty: make serial/suncore.c driver explicitly non-modular
      drivers/tty: make serial/sunhv.c driver explicitly non-modular

Peter Hung (2):
      serial: 8250_pci: add RS485 for F81504/508/512
      serial: 8250_pci: fix mode after S3/S4 resume for F81504/508/512

Peter Hurley (14):
      serial: 8250_omap: Remove auto-IXON flow control
      serial: 8250: Split base port operations from universal driver
      serial: 8250: Defer interrupt enable until fifos enabled
      tty: Replace smp_rmb/smp_wmb with smp_load_acquire/smp_store_rele=
ase
      tty: buffers: Move hidden buffer index advance into outer loop
      tty: core: Improve debug message content
      tty: core: Add tty_debug() for printk(KERN_DEBUG) messages
      tty: Replace #ifdef TTY_DEBUG_HANGUP with tty_debug_hangup()
      tty: Use tty_debug() for tty_ldisc_debug()
      tty: Replace inline #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
      tty: core: Improve ldisc debug messages
      pty: Add debug message for ptmx open
      serial: core: Use proper spinlock flavor in uart_close()
      serial: core: Remove tty port activate() and shutdown() methods

Qipan Li (2):
      serial: sirf: workaround rx process to avoid possible data loss
      serial: sirf: let uart's receive start in right place

Qipeng Zha (2):
      serial: 8250: Auto CTS control by HW if AFE enabled
      serial:8250_dw: do not alter CTS and DCTS since AFE is enabled

Ricardo Ribalda Delgado (6):
      serial/8250_fintek: Use private data structure
      serial/8250_fintek: Support for multiple base_ports
      serial/8250_fintek: Support for chip_ip 0x0501
      serial/8250_fintek: Support keys different than default
      serial/8250_fintek: Support for any io address.
      serial/uartlite: Let it build on any arch with IOMEM

Richard Watts (1):
      Avoid usb reset crashes by making tty_io cdevs truly dynamic

Robert Baldyga (1):
      serial: samsung: fix DMA for FIFO smaller than cache line size

Sebastian Andrzej Siewior (1):
      tty: serial: 8250_omap: do not use RX DMA if pause is not support=
ed

Sekhar Nori (7):
      serial: 8250_omap: fix kernel crash in suspend-to-ram
      Documentation: DT: omap_serial: document missing compatible
      serial: 8250_omap: refactor mdr1 update
      serial: 8250_omap: introduce "ti,am3352-uart" compatible property
      serial: 8250_omap: workaround errata around idling UART after usi=
ng DMA
      serial: 8250_omap: workaround module disable errata on dra7x SoCs
      ARM: dts: dra7: workaround UART module disable errata

Shenwei Wang (1):
      Serial: imx: add dev_pm_ops to support suspend to ram/disk

Stefan Wahren (1):
      serial: mxs-auart: fix baud rate range

Uwe Kleine-K=F6nig (1):
      serial: mpc52xx: let tx_empty callback return either 0 or TIOCSER=
_TEMT

Vaishali Thakkar (1):
      tty: Convert use of __constant_htons to htons

Vineet Gupta (1):
      tty/early: make serial8250_early_{in,out} static again

 .../devicetree/bindings/serial/atmel-usart.txt     |    3 +
 .../bindings/serial/axis,etraxfs-uart.txt          |    6 +-
 .../devicetree/bindings/serial/omap_serial.txt     |    3 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/am33xx.dtsi                      |   12 +-
 arch/arm/boot/dts/dra7.dtsi                        |   20 +-
 drivers/acpi/acpi_pnp.c                            |    1 +
 drivers/tty/n_gsm.c                                |    2 +-
 drivers/tty/n_tty.c                                |   15 +-
 drivers/tty/pty.c                                  |    8 +
 drivers/tty/serial/8250/8250.h                     |   17 +-
 drivers/tty/serial/8250/8250_core.c                | 3260 ++----------=
--------
 drivers/tty/serial/8250/8250_dw.c                  |   27 +-
 drivers/tty/serial/8250/8250_early.c               |    4 +-
 drivers/tty/serial/8250/8250_fintek.c              |  172 +-
 drivers/tty/serial/8250/8250_ingenic.c             |    1 -
 drivers/tty/serial/8250/8250_omap.c                |  147 +-
 drivers/tty/serial/8250/8250_pci.c                 |  164 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   11 +
 drivers/tty/serial/8250/8250_port.c                | 2912 ++++++++++++=
+++++
 drivers/tty/serial/8250/8250_uniphier.c            |    1 +
 drivers/tty/serial/8250/Makefile                   |    5 +-
 drivers/tty/serial/Kconfig                         |   10 +-
 drivers/tty/serial/amba-pl011.c                    |  503 ++-
 drivers/tty/serial/atmel_serial.c                  |  484 ++-
 drivers/tty/serial/etraxfs-uart.c                  |   59 +-
 drivers/tty/serial/imx.c                           |  203 +-
 drivers/tty/serial/lantiq.c                        |    8 +-
 drivers/tty/serial/men_z135_uart.c                 |   10 +-
 drivers/tty/serial/mpc52xx_uart.c                  |    5 +-
 drivers/tty/serial/mxs-auart.c                     |   58 +-
 drivers/tty/serial/samsung.c                       |   48 +-
 drivers/tty/serial/samsung.h                       |    1 +
 drivers/tty/serial/sc16is7xx.c                     |  113 +-
 drivers/tty/serial/serial_core.c                   |   25 +-
 drivers/tty/serial/sirfsoc_uart.c                  |  126 +-
 drivers/tty/serial/sirfsoc_uart.h                  |    5 +-
 drivers/tty/serial/sn_console.c                    |   32 +-
 drivers/tty/serial/stm32-usart.c                   |    2 +-
 drivers/tty/serial/suncore.c                       |   11 +-
 drivers/tty/serial/sunhv.c                         |   13 +-
 drivers/tty/serial/ucc_uart.c                      |    2 +-
 drivers/tty/tty_buffer.c                           |   12 +-
 drivers/tty/tty_io.c                               |  108 +-
 drivers/tty/tty_ioctl.c                            |   11 +-
 drivers/tty/tty_ldisc.c                            |   15 +-
 include/linux/amba/serial.h                        |   14 +
 include/linux/atmel_serial.h                       |  240 +-
 include/linux/serial_8250.h                        |    7 +-
 include/linux/tty.h                                |    6 +
 include/linux/tty_driver.h                         |    2 +-
 include/uapi/linux/gsmmux.h                        |    1 +
 52 files changed, 4927 insertions(+), 3999 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_port.c
