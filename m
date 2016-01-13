From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.5-rc1
Date: Tue, 12 Jan 2016 20:33:18 -0800
Message-ID: <20160113043318.GA6149@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 4ef7675344d687a0ef5b0d7c0cee12da0058=
70c0:

  Linux 4.4-rc6 (2015-12-20 16:06:09 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.5-rc1

for you to fetch changes up to 041497eb721ddbdc1e690316976dd8ba7bc136a2=
:

  drivers/tty/serial: delete unused MODULE_DEVICE_TABLE from atmel_seri=
al.c (2016-01-08 21:12:19 -0800)

----------------------------------------------------------------
TTY/Serial patches for 4.5-rc1

Here is the big serial/tty driver updates for 4.5-rc1.  Lots of driver
updates and some tty core changes.  All of these have been in linux-nex=
t
and the details are in the shortlog.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (3):
      serial: remove NWP serial support
      serial: of: CONFIG_SERIAL_8250 is always set
      serial: 8250: move of_serial code to 8250 directory

Ben Dooks (9):
      ARM: meson: serial: release region on port release
      ARM: meson: serial: don't reset port on uart startup
      ARM: meson: serial: tx_empty fails to check for transmitter busy
      ARM: meson: serial: ensure console port uart enabled
      ARM: meson: serial: only disable tx irq on stop
      ARM: meson: serial: use meson_uart_tx_empty() to wait for empty
      ARM: meson: serial: disable rx/tx irqs during console write
      ARM: meson: serial: ensure tx irq on if more work to do
      ARM: meson: serial: check for tx-irq enabled in irq code

DengChao (1):
      serial:bfin-uart:Remove 'struct timeval'

Denys Vlasenko (20):
      cyclades: Deinline cyy_readb, save 368 bytes
      cyclades: Deinline cyy_writeb, save 880 bytes
      cyclades: Deinline serial_paranoia_check, save 304 bytes
      isicom: Deinline WaitTillCardIsFree, save 1120 bytes
      serial/bcm63xx_uart: Deinline wait_for_xmitr, save 374 bytes
      serial/jsm: Deinline neo_parse_isr, save 688 bytes
      serial_core: Deinline uart_update_mctrl, save 304 bytes
      tty/tty_ldisc: Deinline tty_ldisc_put, save 368 bytes
      cyclades: Deinline cyz_is_loaded, save 240 bytes
      isicom: Deinline drop_dtr, save 112 bytes
      serial/m32r_sio: Deinline wait_for_xmitr, save 165 bytes
      serial/men_z135_uart: Deinline men_z135_reg_clr, save 176 bytes
      serial/omap-serial: Deinline wait_for_xmitr, save 165 bytes
      serial/pxa: Deinline wait_for_xmitr, save 165 bytes
      serial/sprd_serial: Deinline wait_for_xmitr, save 165 bytes
      serial/sunsu: Deinline wait_for_xmitr, save 165 bytes
      serial/vt8500_serial: Deinline wait_for_xmitr, save 165 bytes
      tty: Deinline __ldsem_down_read_nested, save 128 bytes
      tty: Deinline __ldsem_down_write_nested, save 128 bytes
      vt: Deinline save_screen, save 238 bytes

=46lorian Achleitner (1):
      sc16is7xx: Fix TX buffer overrun caused by wrong tx fifo level re=
ad-out

=46rederik V=F6lkel (5):
      drivers: tty: 68328serial.c: Add missing spaces(checkpatch)
      drivers: tty: 68328serial.c: remove unnecessary spaces(checkpatch=
)
      drivers: tty: 68328serial.c: Do not initialize statics to 0
      drivers: tty: 68328serial.c: Fix "foo * bar" should be "foo *bar"
      drivers: tty: 68328serial.c: Remove parentheses after return

Gavin Thomas Claugus (1):
      drivers: serial: jsm: Switch "jsm" to JSM_DRIVER_NAME

Geert Uytterhoeven (27):
      serial: SERIAL_ATMEL should depend on HAS_DMA
      serial: SERIAL_IMX_AUART should depend on HAS_DMA
      serial: SERIAL_MXS_AUART should depend on HAS_DMA
      serial: sh-sci: Add fallback compatibility strings
      serial: sh-sci: Update DT binding documentation for external cloc=
k input
      serial: sh-sci: Update DT binding documentation for BRG support
      serial: sh-sci: Drop useless check for zero sampling_rate
      serial: sh-sci: Grammar s/Get ... for/Get ... from/
      serial: sh-sci: Use existing local variable in sci_parse_dt()
      serial: sh-sci: Drop unused frame_len parameter for sci_baud_calc=
_hscif()
      serial: sh-sci: Don't overwrite clock selection in serial_console=
_write()
      serial: sh-sci: Convert from clk_get() to devm_clk_get()
      serial: sh-sci: Make unsigned values in sci_baud_calc_hscif() uns=
igned
      serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
      serial: sh-sci: Improve bit rate error calculation for HSCIF
      serial: sh-sci: Avoid calculating the receive margin for HSCIF
      serial: sh-sci: Merge sci_scbrr_calc() and sci_baud_calc_hscif()
      serial: sh-sci: Take into account sampling rate for max baud rate
      serial: sh-sci: Add BRG register definitions
      serial: sh-sci: Replace struct sci_port_info by type/regtype enco=
ding
      serial: sh-sci: Correct SCIF type on RZ/A1H
      serial: sh-sci: Correct SCIF type on R-Car for BRG
      serial: sh-sci: Prepare for multiple sampling clock sources
      serial: sh-sci: Add support for optional external (H)SCK input
      serial: sh-sci: Add support for optional BRG on (H)SCIF
      sh: sh7734: Correct SCIF type for BRG
      serial: sh-sci: Remove cpufreq notifier to fix crash/deadlock

Greg Kroah-Hartman (2):
      Merge 4.4-rc6 into tty-next
      Merge branch 'scif-clk-sck-brg-for-v4.5' of git://git.kernel.org/=
=2E../geert/renesas-drivers into tty-next

Heikki Krogerus (1):
      serial: 8250_mid: fix broken DMA dependency

LABBE Corentin (1):
      serial: imx: fix a possible NULL dereference

Laurent Pinchart (4):
      serial: sh-sci: Drop the interface clock
      sh: Rename sci_ick and sci_fck clock to fck
      sh: Remove sci_ick clock alias
      serial: sh-sci: Drop the sci_fck clock fallback

Masahiro Yamada (7):
      serial: 8250_uniphier: add earlycon support
      serial: 8250_ingenic: delete redundant "select SERIAL_EARLYCON"
      serial: 8250_ingenic: allow to be independent of SERIAL_8250_CONS=
OLE
      serial: 8250_early: do not save and restore IER in write callback
      serial: 8250_early: confirm empty transmitter after sending chara=
cters
      serial: 8250_early: squash wait_for_xmitr() into serial_putc()
      serial: support 16-bit register interface for console

Paul Gortmaker (3):
      drivers/tty/serial: make serial/atmel_serial.c explicitly non-mod=
ular
      drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular
      drivers/tty/serial: delete unused MODULE_DEVICE_TABLE from atmel_=
serial.c

Peter Hurley (23):
      tty: Improve tty_debug() macro
      tty: Make tty_paranoia_check() file scope
      tty: synclink_gt: Rename tty_driver_name
      tty: core: Remove redundant oom message
      tty: core: Add helper fn to deref tty driver name
      tty: Define tty_*() printk macros
      tty: Convert SAK messages to tty_notice()
      tty: core: Add driver name to invalid device registration message
      tty: core: Refactor parameters for unset_locked_termios() helper
      tty: Remove unset_locked_termios() error message
      tty: core: Prefer pr_* to printk(*)
      tty: Remove __func__ from tty_debug() macro
      tty: Merge conditional + error message + WARN_ON()
      tty: core: Prefer dev_dbg() over pr_debug()
      tty: Only allow slave pty as controlling tty
      tty: Remove dead tty_write_flush() declaration and macro
      tty: Remove unused SERIAL_DO_RESTART define
      tty: Simplify tty_set_ldisc() exit handling
      n_tty: Uninline tty_copy_to_user()
      n_tty: Clarify copy_from_read_buf()
      n_tty: Reduce branching in canon_copy_from_read_buf()
      tty: Prevent ldisc drivers from re-using stale tty fields
      serial: Fix UPIO_MEM comment

Peter Ujfalusi (1):
      serial: 8250: of: Fix the driver and actually compile the 8250_of

Russell King (13):
      tty: amba-pl011: add register accessor functions
      tty: amba-pl011: convert accessor functions to take uart_amba_por=
t
      tty: amba-pl011: add helper to detect split LCRH register
      tty: amba-pl011: prepare REG_* register indexes
      tty: amba-pl011: add register lookup table
      tty: amba-pl011: add register offset table to vendor data
      tty: amba-pl011: add ST register offset table
      tty: amba-pl011: clean up LCR register offsets
      tty: amba-pl011: remove ST micro registers from standard table
      tty: amba-pl011: add support for 32-bit register access
      tty: amba-pl011: add support for ZTE UART (EXPERIMENTAL)
      tty: amba-pl011: switch to using relaxed IO accessors
      tty: amba-pl011: fix earlycon register offsets

Timur Tabi (1):
      tty: amba-pl011: use iotype instead of access_32b to track 32-bit=
 I/O

Ulrich Hecht (1):
      serial: sh-sci: Add device tree bindings for r8a7793

Uwe Kleine-K=F6nig (5):
      serial: atmel: convert to irq handling provided mctrl-gpio
      serial: imx: repair and complete handshaking
      serial: imx: reorder functions and simplify a bit
      serial: mctrl_gpio: export mctrl_gpio_disable_ms and mctrl_gpio_i=
nit
      serial: imx: implement handshaking using gpios with the mctrl_gpi=
o helper

 .../bindings/serial/renesas,sci-serial.txt         |  44 +-
 Documentation/kernel-parameters.txt                |  14 +-
 arch/sh/kernel/cpu/clock-cpg.c                     |   1 -
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c             |   9 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c             |  16 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c             |   8 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c             |   6 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c             |   6 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c             |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c               |   8 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |  12 +-
 drivers/tty/amiserial.c                            |   1 -
 drivers/tty/cyclades.c                             |   8 +-
 drivers/tty/isicom.c                               |   4 +-
 drivers/tty/moxa.c                                 |   1 -
 drivers/tty/n_tty.c                                |  55 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/tty/serial/68328serial.c                   | 130 ++---
 drivers/tty/serial/8250/8250_core.c                |   7 +-
 drivers/tty/serial/8250/8250_early.c               |  29 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   2 +
 drivers/tty/serial/8250/8250_mtk.c                 |  35 +-
 drivers/tty/serial/{of_serial.c =3D> 8250/8250_of.c} |  38 +-
 drivers/tty/serial/8250/8250_port.c                |  20 +
 drivers/tty/serial/8250/8250_uniphier.c            |  24 +
 drivers/tty/serial/8250/Kconfig                    |  14 +-
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/Kconfig                         |  33 +-
 drivers/tty/serial/Makefile                        |   2 -
 drivers/tty/serial/amba-pl011.c                    | 341 +++++++-----
 drivers/tty/serial/amba-pl011.h                    |  34 ++
 drivers/tty/serial/atmel_serial.c                  | 187 +------
 drivers/tty/serial/bcm63xx_uart.c                  |   2 +-
 drivers/tty/serial/bfin_uart.c                     |  27 +-
 drivers/tty/serial/earlycon.c                      |  15 +-
 drivers/tty/serial/icom.c                          |   1 -
 drivers/tty/serial/imx.c                           | 189 ++++---
 drivers/tty/serial/jsm/jsm_driver.c                |   4 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |   2 +-
 drivers/tty/serial/m32r_sio.c                      |   2 +-
 drivers/tty/serial/men_z135_uart.c                 |   2 +-
 drivers/tty/serial/meson_uart.c                    |  80 ++-
 drivers/tty/serial/nwpserial.c                     | 477 -------------=
----
 drivers/tty/serial/omap-serial.c                   |   2 +-
 drivers/tty/serial/pxa.c                           |   2 +-
 drivers/tty/serial/sc16is7xx.c                     |  13 +
 drivers/tty/serial/serial_core.c                   |  11 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |   2 +
 drivers/tty/serial/sh-sci.c                        | 589 +++++++++++++=
+-------
 drivers/tty/serial/sh-sci.h                        |  10 +
 drivers/tty/serial/sprd_serial.c                   |   2 +-
 drivers/tty/serial/sunsu.c                         |   2 +-
 drivers/tty/serial/vt8500_serial.c                 |   2 +-
 drivers/tty/synclink_gt.c                          |   4 +-
 drivers/tty/tty_io.c                               |  88 ++-
 drivers/tty/tty_ioctl.c                            |  21 +-
 drivers/tty/tty_ldisc.c                            |  51 +-
 drivers/tty/tty_ldsem.c                            |   4 +-
 drivers/tty/tty_mutex.c                            |  10 +-
 drivers/tty/tty_port.c                             |   9 +-
 drivers/tty/vt/vt.c                                |   2 +-
 include/linux/amba/serial.h                        |  18 +
 include/linux/nwpserial.h                          |  18 -
 include/linux/serial_core.h                        |   3 +-
 include/linux/serial_sci.h                         |   1 +
 include/linux/tty.h                                |  23 +-
 include/uapi/linux/serial.h                        |   1 +
 include/uapi/linux/serial_core.h                   |   2 +-
 71 files changed, 1332 insertions(+), 1499 deletions(-)
 rename drivers/tty/serial/{of_serial.c =3D> 8250/8250_of.c} (91%)
 create mode 100644 drivers/tty/serial/amba-pl011.h
 delete mode 100644 drivers/tty/serial/nwpserial.c
 delete mode 100644 include/linux/nwpserial.h
