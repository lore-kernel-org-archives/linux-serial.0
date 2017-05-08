From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY patches for 4.12-rc1
Date: Mon, 8 May 2017 11:46:24 +0200
Message-ID: <20170508094624.GA7452@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 4f7d029b9bf009fbee76bb10c0c4351a1870d2f3:

  Linux 4.11-rc7 (2017-04-16 13:00:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.12-rc1

for you to fetch changes up to 8e1c21f486944bf92f2a981f23ee811a45f5eaff:

  serial: small Makefile reordering (2017-04-18 18:01:52 +0200)

----------------------------------------------------------------
TTY/Serial patches for 4.12-rc1

Here is the "big" TTY/Serial patch updates for 4.12-rc1

Not a lot of new things here, the normal number of serial driver updates
and additions, tiny bugs fixed, and some core files split up to make
future changes a bit easier for Nicolas's "tiny-tty" work.

All of these have been in linux-next for a while.  There will be a merge
conflict with include/linux/serdev.h coming from the bluetooth tree
merge, which we knew about, as we wanted some of the serdev changes to
go in through that tree.  I'll send the expected merge result as a
follow-on message.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Borowski (2):
      vt: set mouse selection word-chars to gpm's default
      vt: make mouse selection of non-ASCII consistent

Aleksey Makarov (1):
      Revert "tty: serial: pl011: add ttyAMA for matching pl011 console"

Alexandre Belloni (2):
      tty/serial: atmel: increase ATMEL_MAX_UART
      tty/serial: atmel: remove cache when unnecessary

Andrey Smirnov (2):
      linux/serdev.h: Replace 'ctrl->serdev' with 'serdev'
      serdev: Add serdev_device_write subroutine

Andy Shevchenko (3):
      serial: 8250_exar: Fix spelling of "driver"
      serial: core: constify struct uart_port {name} field
      serial: core: Re-use struct uart_port {name} field

Chunyan Zhang (2):
      dt-bindings: arm: Add bindings for SP9860G
      dt-bindings: serial: add a new compatible string for SC9860

Denis Kirjanov (1):
      tty/hvc_console: fix console lock ordering with spinlock

Elena Reshetova (1):
      drivers: convert sbd_duart.map_guard from atomic_t to refcount_t

Geert Uytterhoeven (3):
      serial: sh-sci: Fix hang in sci_reset()
      serial: sh-sci: Fix late enablement of AUTORTS
      serial: sh-sci: Fix (AUTO)RTS in sci_init_pins()

Greg Kroah-Hartman (4):
      Revert "tty: Fix ldisc crash on reopened tty"
      Merge 4.11-rc4 into tty-next
      Merge 4.11-rc5 into tty-next
      Merge 4.11-rc7 into tty-next

Jan Kiszka (1):
      serial: 8250_lpss: Unconditionally set PCI master for Quark

Jayachandran C (1):
      tty: amba-pl011: Fix spurious TX interrupts

Jiri Slaby (1):
      tty: serial_core, remove state checks in uart_poll*

Joe Perches (1):
      drivers/tty: Convert remaining uses of pr_warning to pr_warn

Johan Hovold (5):
      tty: close race between device register and open
      tty: drop obsolete termios_locked comments
      tty: reset termios state on device registration
      serial: omap: fix runtime-pm handling on unbind
      serial: omap: suspend device on probe errors

Lee Jones (1):
      serial: st-asc: Change default baudrate from 9600 to 115200

Lionel Debieve (1):
      tty: serial: st-asc: Make the locking RT aware

Lukas Redlinger (1):
      serial: 8250_fintek: Enable high speed mode on Fintek F81866

Marc Gonzalez (1):
      serial: 8250_early: Add earlycon support for Palmchip UART

Marek Szyprowski (3):
      serial: samsung: Use right device for DMA-mapping calls
      serial: samsung: Add missing checks for dma_map_single failure
      serial: samsung: Remove useless spinlock

Nicolas Pitre (4):
      console: move console_init() out of tty_io.c
      tty: move baudrate handling code to a file of its own
      tty: split job control support into a file of its own
      serial: small Makefile reordering

Peter Hurley (1):
      tty: Fix ldisc crash on reopened tty

Peter Senna Tschudin (1):
      imx-serial: Reduce RX DMA startup latency when opening for reading

Philipp Zabel (1):
      serial: 8250_dw: simplify optional reset handling

Richard Genoud (1):
      tty/serial: atmel: move atmel_serial header into driver directory

Sam Povilus (1):
      uartlite: Adding a kernel parameter for the number of uartlites

Samuel Thibault (1):
      braille-console: Fix value returned by _braille_console_setup

Sebastian Reichel (1):
      tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init

Shubhrajyoti Datta (3):
      serial: xilinx_uartps: Add pm runtime support
      serial: xuartps: Cleanup the clock enable
      serial: xuartps: Enable clocks in the pm disable case also

Stefan Agner (1):
      tty: serial: fsl_lpuart: lock port on console write

Takatoshi Akiyama (1):
      serial: sh-sci: Fix panic when serial console and DMA are enabled

Thadeu Lima de Souza Cascardo (1):
      tty: fix comment typo s/repsonsible/responsible/

Tim Gardner (1):
      tty: Disable default console blanking interval

Timur Tabi (1):
      tty: pl011: use "qdf2400_e44" as the earlycon name for QDF2400 E44

Tobias Klauser (3):
      tty: n_gsm: Use net_device_stats from struct net_device
      serial: altera_jtaguart: add earlycon support
      serial: altera_uart: add earlycon support

Uwe Kleine-König (1):
      serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off

Vignesh R (3):
      serial: 8250: 8250_core: Use dev_name() during request_irq()
      tty: serial_core: Add name field to uart_port struct
      serial: 8250: 8250_core: Fix irq name for 8250 serial IRQ

Wang YanQing (1):
      tty: pty: Fix ldisc flush after userspace become aware of the data already

Wei Qiao (1):
      serial: sprd: adjust TIMEOUT to a big value

 Documentation/devicetree/bindings/arm/sprd.txt     |  13 +-
 .../devicetree/bindings/serial/sprd-uart.txt       |  14 +-
 MAINTAINERS                                        |   2 +-
 drivers/tty/Makefile                               |   3 +-
 drivers/tty/hvc/hvc_console.c                      |   4 +-
 drivers/tty/hvc/hvcs.c                             |   2 +-
 drivers/tty/n_gsm.c                                |  21 +-
 drivers/tty/pty.c                                  |   7 +-
 drivers/tty/serdev/core.c                          |  36 +-
 drivers/tty/serial/8250/8250_core.c                |   2 +-
 drivers/tty/serial/8250/8250_dw.c                  |  13 +-
 drivers/tty/serial/8250/8250_early.c               |  24 +
 drivers/tty/serial/8250/8250_exar.c                |   2 +-
 drivers/tty/serial/8250/8250_fintek.c              |  43 +-
 drivers/tty/serial/8250/8250_lpss.c                |   3 +-
 drivers/tty/serial/8250/8250_port.c                |   4 +-
 drivers/tty/serial/Kconfig                         |  11 +
 drivers/tty/serial/Makefile                        |   3 +-
 drivers/tty/serial/altera_jtaguart.c               |  20 +
 drivers/tty/serial/altera_uart.c                   |  32 ++
 drivers/tty/serial/amba-pl011.c                    |  54 +-
 drivers/tty/serial/atmel_serial.c                  |   7 +-
 .../linux => drivers/tty/serial}/atmel_serial.h    |   0
 drivers/tty/serial/fsl_lpuart.c                    |  20 +
 drivers/tty/serial/imx.c                           |  99 +++-
 drivers/tty/serial/omap-serial.c                   |  12 +-
 drivers/tty/serial/samsung.c                       |  44 +-
 drivers/tty/serial/sb1250-duart.c                  |  18 +-
 drivers/tty/serial/serial_core.c                   |  34 +-
 drivers/tty/serial/sh-sci.c                        |  43 +-
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 drivers/tty/serial/st-asc.c                        |  10 +-
 drivers/tty/serial/uartlite.c                      |   2 +-
 drivers/tty/serial/xilinx_uartps.c                 |  71 ++-
 drivers/tty/tty_baudrate.c                         | 232 ++++++++
 drivers/tty/tty_io.c                               | 635 ++-------------------
 drivers/tty/tty_ioctl.c                            | 222 -------
 drivers/tty/tty_jobctrl.c                          | 554 ++++++++++++++++++
 drivers/tty/vt/selection.c                         |  18 +-
 drivers/tty/vt/vt.c                                |   2 +-
 include/linux/console.h                            |   2 +
 include/linux/serdev.h                             |  21 +-
 include/linux/serial_core.h                        |   1 +
 include/linux/tty.h                                |  13 +-
 init/main.c                                        |   2 +-
 kernel/printk/braille.c                            |  15 +-
 kernel/printk/braille.h                            |  13 +-
 kernel/printk/printk.c                             |  24 +
 48 files changed, 1397 insertions(+), 1032 deletions(-)
 rename {include/linux => drivers/tty/serial}/atmel_serial.h (100%)
 create mode 100644 drivers/tty/tty_baudrate.c
 create mode 100644 drivers/tty/tty_jobctrl.c
