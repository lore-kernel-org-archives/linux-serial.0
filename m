From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial Update for 4.7-rc1
Date: Fri, 20 May 2016 20:22:39 -0700
Message-ID: <20160521032239.GA6490@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

----------------
Note, you will get a merge error in include/uapi/linux/serial_core.h
when merging to your tree, just resolve it so that there is a unique
number for each serial driver and all should be fine.
----------------

The following changes since commit 44549e8f5eea4e0a41b487b63e616cb08992=
2b99:

  Linux 4.6-rc7 (2016-05-08 14:38:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.7-rc1

for you to fetch changes up to d20bb59af64667a16f2468b54fc0adb2f824a3b6=
:

  MAINTAINERS: 8250: remove website reference (2016-05-09 13:09:27 +020=
0)

----------------------------------------------------------------
TTY and Serial driver update for 4.7-rc1

Here's the large TTY and Serial driver update for 4.7-rc1.

A few new serial drivers are added here, and Peter has fixed a bunch of
long-standing bugs in the tty layer and serial drivers as normal.  Full
details in the shortlog.

All of these have been in linux-next for a while with no reported issue=
s.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandre Belloni (1):
      tty/serial: atmel: fix hardware handshake selection

Andreas F=E4rber (1):
      tty: serial: meson: Implement earlycon support

Andy Shevchenko (5):
      serial: 8250_mid: use proper bar for DNV platform
      serial: 8250_mid: recognize interrupt source in handler
      serial: 8250_mid: include missed linux/bitops.h
      serial: 8250_mid: make module available only on X86
      serial: 8250_mid: correct comment regarding Tangier HSU

Baruch Siach (2):
      serial: imx: support RS-485 Rx disable on Tx
      MAINTAINERS: 8250: remove website reference

Brian Bloniarz (1):
      Fix OpenSSH pty regression on close

Chanwoo Choi (1):
      serial: samsung: Reorder the sequence of clock control when call =
s3c24xx_serial_set_termios()

Christopher Covington (1):
      tty: amba-pl011: Use 32-bit accesses for SBSA UART

Dan Carpenter (1):
      tty: hvc_console: silence unintialized variable warning

David M=FCller (1):
      serial: 8250_pci: fix divide error bug if baud rate is 0

Geert Uytterhoeven (9):
      serial: Make SERIAL_MVEBU_UART depend on ARCH_MVEBU
      serial: mctrl_gpio: Grammar s/lines GPIOs/line GPIOs/, /sets/set/
      serial: Move Marvell UART DT bindings to correct location
      doc: DT: Add Generic Serial Device Tree Bindings
      serial: imx: Use generic uart-has-rtscts DT property
      serial: mxs-auart: Use generic uart-has-rtscts DT property
      serial: sirf: Introduce helper variable struct device_node *np
      serial: sirf: Use generic uart-has-rtscts DT property
      serial: mctrl_gpio: Drop support for out1-gpios and out2-gpios

Greg Kroah-Hartman (1):
      Merge 4.6-rc7 into tty-next

Jiri Slaby (8):
      TTY: n_gsm, fix false positive WARN_ON
      tty: vt, remove reduntant check
      tty: vt, get rid of weird source code flow
      tty: vt, make color_table const
      tty: vt, use proper type for default colors
      TTY: serial/ifx6x60, initialize more
      tty: vt, return error when con_startup fails
      tty: vt, finish looping on duplicate

Julia Lawall (2):
      serial: mvebu-uart: fix platform_no_drv_owner.cocci warnings
      TTY: add __init attribute

Kefeng Wang (1):
      serial: 8250_dw: fix wrong logic in dw8250_check_lcr()

Maarten Brock (1):
      serial-uartlite: Constify uartlite_be/uartlite_le

Masahiro Yamada (1):
      serial: 8250_uniphier: add "\n" at the end of error log

Matthias Schiffer (1):
      MIPS: ath79: make bootconsole wait for both THRE and TEMT

Oleksij Rempel (1):
      serial: mxs-auart: add Alphascale ASM9260 support

Paul Gortmaker (1):
      drivers/tty: make serial/mvebu-uart.c explicitly non-modular

Peter Hurley (27):
      tty: Replace TTY_IO_ERROR bit tests with tty_io_error()
      tty: Replace TTY_THROTTLED bit tests with tty_throttled()
      tty: Define ASYNC_ replacement bits
      tty: Replace ASYNC_CTS_FLOW bit and update atomically
      tty: Replace ASYNC_NORMAL_ACTIVE bit and update atomically
      tty: Replace ASYNC_CHECK_CD and update atomically
      tty: Replace ASYNC_SUSPENDED bit and update atomically
      tty: Replace ASYNC_INITIALIZED bit and update atomically
      tty: mxser: Remove unused ASYNC_SHARE_IRQ flag
      tty: core: Undefine ASYNC_* flags superceded by TTY_PORT* flags
      serial: core: Expand port mutex section in uart_poll_init()
      serial: core: Prevent unsafe uart port access, part 1
      serial: core: Prevent unsafe uart port access, part 2
      serial: core: Prevent unsafe uart port access, part 3
      tty: Remove unused TTY_NUMBER() macro
      tty: Remove stale parameter comment
      serial: 8250: Eliminate needless local in irq handlers
      serial: 8250: Reduce expr in 8250 irq handler
      serial: omap8250: Eliminate local in omap8250_runtime_resume()
      serial: 8250: Remove unused define
      serial: 8250: Validate dmaengine rx chan meets requirements
      serial: 8250: Validate dmaengine tx chan meets requirements
      serial: omap8250: Drop rx buffer sync
      serial: omap8250: Simplify rx dma completion interface
      serial: 8250: Extract IIR logic steering from rx dma
      serial: omap8250: Terminate rx dma only for flushes
      serial: core: Fix port mutex assert if lockdep disabled

Ricardo Ribalda Delgado (1):
      serial: 8250: Integrate Fintek into 8250_base

Srinivas Kandagatla (1):
      tty: msm_serial: remove static clk rate setting in probe

Stephen Boyd (1):
      tty: serial: msm: Support more bauds

Sudip Mukherjee (2):
      tty: ipwireless: fix possible NULL dereference
      tty: synclink: remove unneeded test

Thierry Reding (2):
      serial: tegra: Remove unused variable
      serial: 8250: of: Make tegra_serial_handle_break() static

Uwe Kleine-K=F6nig (6):
      serial: imx: fix polarity of RI
      serial: imx: let irq handler return IRQ_NONE if no event was hand=
led
      serial: imx: make sure unhandled irqs are disabled
      serial: imx: only count 0->1 transitions for RNG
      serial: imx: reorder functions to simplify next patch
      serial: imx: implement DSR irq handling for DTE mode

Vladimir Murzin (3):
      dt-bindings: document the MPS2 UART bindings
      serial: mps2-uart: add MPS2 UART driver
      serial: mps2-uart: add support for early console

Wan Ahmad Zainie (2):
      serial: 8250: export get_mctrl function
      serial: 8250_pci: report DCD and DSR signals as active for Bay Tr=
ail

Wang Hongcheng (1):
      serial: 8250dw: Add device HID for future AMD UART controller

Wills Wang (1):
      sc16is7xx: remove useless "uart_handle_cts_change"

Yegor Yefremov (1):
      serial: mctrl_gpio: add IRQ locking

Zhao Qiang (1):
      QE-UART: add "fsl,t1040-ucc-uart" to of_device_id

 .../devicetree/bindings/serial/arm,mps2-uart.txt   |  19 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   4 +-
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   |  16 +-
 .../bindings/{tty =3D> }/serial/mvebu-uart.txt       |   0
 .../devicetree/bindings/serial/serial.txt          |  57 ++
 .../devicetree/bindings/serial/sirf-uart.txt       |   8 +-
 Documentation/kernel-parameters.txt                |   6 +
 Documentation/serial/tty.txt                       |   3 -
 MAINTAINERS                                        |   1 -
 arch/ia64/hp/sim/simserial.c                       |   2 +-
 arch/mips/ath79/early_printk.c                     |   6 +-
 drivers/char/pcmcia/synclink_cs.c                  |  29 +-
 drivers/ipack/devices/ipoctal.c                    |   5 +-
 drivers/isdn/i4l/isdn_tty.c                        |  44 +-
 drivers/mmc/card/sdio_uart.c                       |   2 +-
 drivers/net/usb/hso.c                              |   2 +-
 drivers/s390/char/con3215.c                        |  22 +-
 drivers/s390/char/tty3270.c                        |   4 +-
 drivers/staging/dgnc/dgnc_tty.c                    |   2 +-
 drivers/staging/fwserial/fwserial.c                |   2 +-
 drivers/staging/speakup/selection.c                |   2 +-
 drivers/tty/amiserial.c                            |  39 +-
 drivers/tty/cyclades.c                             |  38 +-
 drivers/tty/hvc/hvc_console.c                      |   4 +-
 drivers/tty/hvc/hvcs.c                             |   2 +-
 drivers/tty/hvc/hvsi.c                             |   2 +-
 drivers/tty/ipwireless/hardware.c                  |   5 +
 drivers/tty/isicom.c                               |  19 +-
 drivers/tty/moxa.c                                 |  12 +-
 drivers/tty/mxser.c                                |  35 +-
 drivers/tty/n_gsm.c                                |  12 +-
 drivers/tty/n_hdlc.c                               |   4 +-
 drivers/tty/n_tty.c                                |  70 ++-
 drivers/tty/nozomi.c                               |   2 +-
 drivers/tty/pty.c                                  |   6 +-
 drivers/tty/rocket.c                               |  16 +-
 drivers/tty/serial/8250/8250.h                     |  15 +-
 drivers/tty/serial/8250/8250_core.c                |   3 +
 drivers/tty/serial/8250/8250_dma.c                 |  68 ++-
 drivers/tty/serial/8250/8250_dw.c                  |   8 +-
 drivers/tty/serial/8250/8250_fintek.c              | 118 +---
 drivers/tty/serial/8250/8250_mid.c                 |  44 +-
 drivers/tty/serial/8250/8250_of.c                  |   2 +-
 drivers/tty/serial/8250/8250_omap.c                |  93 ++-
 drivers/tty/serial/8250/8250_pci.c                 |  15 +
 drivers/tty/serial/8250/8250_port.c                |  38 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   2 +-
 drivers/tty/serial/8250/Kconfig                    |  24 +-
 drivers/tty/serial/8250/Makefile                   |   2 +-
 drivers/tty/serial/Kconfig                         |  20 +-
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/amba-pl011.c                    |   1 +
 drivers/tty/serial/atmel_serial.c                  |  14 +-
 drivers/tty/serial/crisv10.c                       |  30 +-
 drivers/tty/serial/ifx6x60.c                       |   2 +-
 drivers/tty/serial/imx.c                           | 174 ++++--
 drivers/tty/serial/meson_uart.c                    |  42 +-
 drivers/tty/serial/mps2-uart.c                     | 625 +++++++++++++=
+++++++
 drivers/tty/serial/msm_serial.c                    | 101 ++--
 drivers/tty/serial/mvebu-uart.c                    |  29 +-
 drivers/tty/serial/mxs-auart.c                     | 644 +++++++++++++=
++++----
 drivers/tty/serial/samsung.c                       |   4 +-
 drivers/tty/serial/sc16is7xx.c                     |  13 +-
 drivers/tty/serial/serial-tegra.c                  |   2 -
 drivers/tty/serial/serial_core.c                   | 430 +++++++++----=
-
 drivers/tty/serial/serial_mctrl_gpio.c             |   7 +-
 drivers/tty/serial/serial_mctrl_gpio.h             |   6 +-
 drivers/tty/serial/sirfsoc_uart.c                  |  39 +-
 drivers/tty/serial/uartlite.c                      |  12 +-
 drivers/tty/serial/ucc_uart.c                      |   3 +
 drivers/tty/synclink.c                             |  74 +--
 drivers/tty/synclink_gt.c                          |  41 +-
 drivers/tty/synclinkmp.c                           |  41 +-
 drivers/tty/tty_buffer.c                           |  34 +-
 drivers/tty/tty_io.c                               |   9 +-
 drivers/tty/tty_ioctl.c                            |   4 +-
 drivers/tty/tty_port.c                             |  27 +-
 drivers/tty/vt/selection.c                         |   2 +-
 drivers/tty/vt/vt.c                                | 115 ++--
 drivers/usb/class/cdc-acm.c                        |   4 +-
 drivers/usb/gadget/function/u_serial.c             |   4 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c            |   2 +-
 drivers/usb/serial/console.c                       |   4 +-
 drivers/usb/serial/digi_acceleport.c               |   3 +-
 drivers/usb/serial/generic.c                       |   6 +-
 drivers/usb/serial/mxuport.c                       |   6 +-
 drivers/usb/serial/sierra.c                        |   4 +-
 drivers/usb/serial/usb-serial.c                    |   2 +-
 drivers/usb/serial/usb_wwan.c                      |   4 +-
 drivers/video/console/fbcon.c                      |   4 +-
 drivers/video/console/mdacon.c                     |   2 +-
 drivers/video/console/newport_con.c                |   2 +-
 drivers/video/console/sticon.c                     |   2 +-
 drivers/video/console/vgacon.c                     |   5 +-
 include/linux/console.h                            |   2 +-
 include/linux/selection.h                          |   8 +-
 include/linux/serial_8250.h                        |   2 +
 include/linux/serial_core.h                        |   3 +
 include/linux/tty.h                                |  89 ++-
 include/uapi/linux/serial_core.h                   |   3 +
 include/uapi/linux/tty_flags.h                     |  13 +-
 include/uapi/linux/vt.h                            |   1 -
 net/irda/ircomm/ircomm_tty.c                       |  31 +-
 net/irda/ircomm/ircomm_tty_attach.c                |   2 +-
 net/irda/ircomm/ircomm_tty_ioctl.c                 |  18 +-
 105 files changed, 2530 insertions(+), 1176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,mps2-u=
art.txt
 rename Documentation/devicetree/bindings/{tty =3D> }/serial/mvebu-uart=
=2Etxt (100%)
 create mode 100644 Documentation/devicetree/bindings/serial/serial.txt
 create mode 100644 drivers/tty/serial/mps2-uart.c
