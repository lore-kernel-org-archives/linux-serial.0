From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.13-rc1
Date: Mon, 3 Jul 2017 16:59:32 +0200
Message-ID: <20170703145932.GA23793@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:

  Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.13-rc1

for you to fetch changes up to a6d7514b14a6ea2a3868bdcb2fca7b2410738595:

  tty: serial: lpuart: add a more accurate baud rate calculation method (2017-06-29 17:12:34 +0200)

----------------------------------------------------------------
TTY/Serial patches for 4.13-rc1

Here is the large tty/serial patchset for 4.13-rc1.

A lot of tty and serial driver updates are in here, along with some
fixups for some __get/put_user usages that were reported.  Nothing huge,
just lots of development by a number of different developers, full
details in the shortlog.

All of these have been in linux-next for a while.  There will be a merge
issue with the arm-soc tree in the include/linux/platform_data/atmel.h
file.  Stephen has sent out a fixup for it, so it shouldn't be that
difficult to merge.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Borowski (6):
      vt: use copy_from/to_user instead of __get/put_user for scrnmap ioctls
      vt: fix unchecked __put_user() in tioclinux ioctls
      vt: use copy_to_user instead of __put_user in GIO_UNIMAP ioctl
      vt: use memdup_user in PIO_UNIMAP ioctl
      vt: drop access_ok() calls in unimap ioctls
      vt: fix \e[2m using the wrong placeholder color on graphical consoles

Alan Cox (1):
      tty: handle the case where we cannot restore a line discipline

Aleksa Sarai (2):
      tty: add compat_ioctl callbacks
      tty: add TIOCGPTPEER ioctl

Alexandre Belloni (2):
      tty/serial: atmel: remove atmel_default_console_device handling
      tty/serial: atmel: make the driver DT only

Andreas Färber (2):
      dt-bindings: serial: Document Actions Semi Owl UARTs
      tty: serial: Add Actions Semi Owl UART earlycon

Andy Shevchenko (3):
      serial: 8250_exar: Remove duplicate assignment
      tty/vt/keyboard: Remove AVR32 bits from the driver
      tty/serial: atmel: Remove AVR32 bits from the driver

Arnd Bergmann (1):
      serial: meson: hide an unused function

Arvind Yadav (1):
      serial: sirf: make of_device_ids const

Christoph Hellwig (1):
      serial/mpsc: switch to dma_alloc_attrs

Colin Ian King (1):
      drivers/tty/hvc: fix spelling mistake: "missmanaged" -> "mismanaged"

Dong Aisheng (7):
      tty: serial: lpuart: introduce lpuart_soc_data to represent SoC property
      tty: serial: lpuart: refactor lpuart32_{read|write} prototype
      tty: serial: lpuart: add little endian 32 bit register support
      dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
      tty: serial: lpuart: add imx7ulp support
      tty: serial: lpuart: add earlycon support for imx7ulp
      tty: serial: lpuart: add a more accurate baud rate calculation method

Fabio Estevam (1):
      serial: imx: Remove unused members from imx_port struct

Geert Uytterhoeven (2):
      serial: sh-sci: Fix race condition causing garbage during shutdown
      serial: sh-sci: Update warning message in sci_request_dma_chan()

Geliang Tang (2):
      tty/serial: atmel: use offset_in_page() macro
      serial: pch_uart: use offset_in_page() macro

Greg Kroah-Hartman (4):
      Merge 4.12-rc3 into tty-next
      tty: reserve N_SPEAKUP number
      Merge 4.12-rc4 into tty-next
      Merge branch 'vt_copy_cleanup' into tty-next

Heiner Kallweit (6):
      serial: meson: fix setting number of stop bits
      serial: meson: remove unneeded variable assignment in meson_serial_port_write
      serial: meson: remove dead code in meson_uart_change_speed
      serial: meson: make use of uart_port member mapsize
      serial: meson: remove use of flag UPF_IOREMAP
      serial: meson: change interrupt description to tty name

Helmut Klein (2):
      dt-bindings: serial: Add bindings for the Amlogic Meson UARTs
      tty/serial: meson_uart: update to stable bindings

Jan Kiszka (3):
      serial: exar: Preconfigure xr17v35x MPIOs as output
      serial: uapi: Add support for bus termination
      serial: exar: Leave MPIOs as output for Commtech adapters

Jeremy Kerr (1):
      drivers/serial: Add driver for Aspeed virtual UART

Joel Stanley (2):
      serial: 8250: Add flag so drivers can avoid THRE probe
      serial: 8250_of: Add reset support

Johan Hovold (9):
      serial: rate limit custom-speed deprecation notice
      USB: serial: ftdi_sio: simplify TIOCSSERIAL flag logic
      USB: serial: ftdi_sio: remove broken alt-speed handling
      tty: simserial: drop unused alt_speed handling
      tty: amiserial: drop broken alt-speed support
      tty: cyclades: drop broken alt-speed support
      tty: rocket: drop broken alt-speed support
      tty: ircomm: remove dead and broken ioctl code
      tty: drop unused alt_speed from tty_struct

Matthias Brugger (1):
      serial: Delete dead code for CIR serial ports

Nandor Han (2):
      serial: imx: Enable RTSD only when needed
      serial: imx-serial - move DMA buffer configuration to DT

Nava kishore Manne (1):
      serial: uartps: Fix kernel doc warnings

Peter Senna Tschudin (1):
      imx-serial: RX DMA startup latency

Phil Elwell (2):
      serial: 8250: Add CAP_MINI, set for bcm2835aux
      serial: 8250: Fix THRE flag usage for CAP_MINI

Sascha Hauer (1):
      tty: n_gsm: do not send/receive in ldisc close path

Shubhrajyoti Datta (1):
      serial: xilinx_uartps: Fix the error path

Sjoerd Simons (2):
      serial: pl010: Move uart_register_driver call to device probe
      serial: sh-sci: Move uart_register_driver call to device probe

Stefan Wahren (1):
      tty: serdev-ttyport: return actual baudrate from ttyport_set_baudrate

Thomas Bogendoerfer (1):
      Fix serial console on SNI RM400 machines

Vignesh R (2):
      serial: 8250: omap: Disable DMA for console UART
      serial: 8250: 8250_omap: Fix race b/w dma completion and RX timeout

 Documentation/ABI/stable/sysfs-driver-aspeed-vuart |  15 +
 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/devicetree/bindings/serial/8250.txt  |   3 +
 .../bindings/serial/actions,owl-uart.txt           |  16 +
 .../bindings/serial/amlogic,meson-uart.txt         |  38 +++
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   2 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 Documentation/serial/n_gsm.txt                     |   7 +
 MAINTAINERS                                        |   2 +-
 arch/alpha/include/uapi/asm/ioctls.h               |   1 +
 arch/ia64/hp/sim/simserial.c                       |  13 -
 arch/mips/include/uapi/asm/ioctls.h                |   1 +
 arch/parisc/include/uapi/asm/ioctls.h              |   1 +
 arch/powerpc/include/uapi/asm/ioctls.h             |   1 +
 arch/sh/include/uapi/asm/ioctls.h                  |   1 +
 arch/sparc/include/uapi/asm/ioctls.h               |   3 +-
 arch/xtensa/include/uapi/asm/ioctls.h              |   1 +
 drivers/tty/Makefile                               |   3 +-
 drivers/tty/amiserial.c                            |  23 +-
 drivers/tty/cyclades.c                             |  21 +-
 drivers/tty/hvc/hvcs.c                             |   3 +-
 drivers/tty/n_gsm.c                                |  54 ++--
 drivers/tty/n_null.c                               |  80 +++++
 drivers/tty/pty.c                                  |  93 +++++-
 drivers/tty/rocket.c                               |  27 +-
 drivers/tty/serdev/serdev-ttyport.c                |   2 +-
 drivers/tty/serial/8250/8250.h                     |   3 +
 drivers/tty/serial/8250/8250_aspeed_vuart.c        | 323 +++++++++++++++++++++
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   2 +-
 drivers/tty/serial/8250/8250_core.c                |  23 +-
 drivers/tty/serial/8250/8250_exar.c                |  16 +-
 drivers/tty/serial/8250/8250_of.c                  |  10 +
 drivers/tty/serial/8250/8250_omap.c                |  27 +-
 drivers/tty/serial/8250/8250_port.c                |  12 +-
 drivers/tty/serial/8250/Kconfig                    |  10 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/Kconfig                         |  35 ++-
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/amba-pl010.c                    |  31 +-
 drivers/tty/serial/atmel_serial.c                  | 164 +++--------
 drivers/tty/serial/fsl_lpuart.c                    | 286 ++++++++++++------
 drivers/tty/serial/imx.c                           |  58 ++--
 drivers/tty/serial/meson_uart.c                    | 153 +++++++---
 drivers/tty/serial/mpsc.c                          |  10 +-
 drivers/tty/serial/owl-uart.c                      | 135 +++++++++
 drivers/tty/serial/pch_uart.c                      |   3 +-
 drivers/tty/serial/sccnxp.c                        |  15 +-
 drivers/tty/serial/serial_core.c                   |   5 +-
 drivers/tty/serial/sh-sci.c                        |  45 ++-
 drivers/tty/serial/sirfsoc_uart.c                  |   2 +-
 drivers/tty/serial/xilinx_uartps.c                 |  10 +-
 drivers/tty/tty_ldisc.c                            |  44 ++-
 drivers/tty/vt/consolemap.c                        |  56 +---
 drivers/tty/vt/keyboard.c                          |   3 +-
 drivers/tty/vt/vt.c                                |   8 +-
 drivers/tty/vt/vt_ioctl.c                          |   8 -
 drivers/usb/serial/ftdi_sio.c                      |  67 +----
 fs/compat_ioctl.c                                  |   6 -
 include/linux/platform_data/atmel.h                |  10 -
 include/linux/serial_core.h                        |   1 +
 include/linux/tty.h                                |   1 -
 include/uapi/asm-generic/ioctls.h                  |   1 +
 include/uapi/linux/serial.h                        |   3 +
 include/uapi/linux/serial_core.h                   |   2 +-
 include/uapi/linux/tty.h                           |   2 +
 net/irda/ircomm/ircomm_tty_ioctl.c                 | 107 +------
 66 files changed, 1406 insertions(+), 712 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-aspeed-vuart
 create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 drivers/tty/n_null.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed_vuart.c
 create mode 100644 drivers/tty/serial/owl-uart.c
