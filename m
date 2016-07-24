From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY patches for 4.8-rc1
Date: Sun, 24 Jul 2016 15:18:27 -0700
Message-ID: <20160724221827.GA13366@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef:

  Linux 4.7-rc6 (2016-07-03 23:01:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.8-rc1

for you to fetch changes up to 67417f9c262e2cd4b706eba3e1fd879d0bebc6d8:

  Merge 4.7-rc6 into tty-next (2016-07-04 08:17:08 -0700)

----------------------------------------------------------------
TTY/Serial driver update for 4.8-rc1

Here is the big tty and serial driver update for 4.8-rc1.

Lots of good cleanups from Jiri on a number of vt and other tty related
things, and the normal driver updates.  Full details are in the
shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shiyan (6):
      serial: max310x: Fix RS485 handling
      serial: max310x: Using resource-managed function for GPIO
      serial: max310x: Register UART driver at module_init
      serial: max310x: Remove duplicate bits definition
      serial: max310x: Unregister UARTs on error
      serial: max310x: Assign port line automatically

Alexandr Petrenko (1):
      8250_pci: Adds support for the WCH CH355 4S card

Alexandre Belloni (1):
      tty/serial: atmel: fix RS485 half duplex with DMA

Ben Dooks (2):
      tty: serial: msm: fix definition of msm_stop_dma
      serial: sirf: make fifo functions static

Bjorn Andersson (1):
      tty: serial: msm: Don't read off end of tx fifo

Charanya Venkatraman (1):
      tty:serial:msm:Do not restore Rx interrupts in DMA

Chuah, Kim Tatt (3):
      dmaengine: hsu: Export hsu_dma_get_status()
      serial: 8250_dma: Export serial8250_rx_dma_flush()
      serial: 8250_mid: Read RX buffer on RX DMA timeout for DNV

Fabio Estevam (1):
      serial: serial_core: Perform NULL checks for release/request_port ops

Geert Uytterhoeven (17):
      serial: sh-sci: Update DT binding documentation for GPIO modem lines
      serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
      serial: sh-sci: Always set TIOCM_CTS in .get_mctrl() callback
      serial: sh-sci: Add support for GPIO-controlled modem lines
      serial: sh-sci: Do not open-code sci_getreg()
      serial: sh-sci: Add more Serial Port Register documentation
      serial: sh-sci: Add more Serial Port Control/Data Register documentation
      serial: sh-sci: Correct pin initialization on (H)SCIF
      serial: sh-sci: Add pin initialization for SCIFA/SCIFB
      serial: sh-sci: Fix support for hardware-assisted RTS/CTS
      serial: sh-sci: Add DT support for dedicated RTS/CTS
      serial: sh-sci: Do not start transfers from sci_startup()
      serial: sh-sci: Clear RX, error, and break flags during reset
      serial: sh-sci: Clear (H)SCIF timeout and overrun during reset
      serial: Make SERIAL_MPS2_UART depend on ARCH_MPS2
      MAINTAINERS: Add file patterns for serial device tree bindings
      serial: sh-sci: Stop transfers in sci_shutdown()

Greg Kroah-Hartman (1):
      Merge 4.7-rc6 into tty-next

Hiromitsu Yamasaki (1):
      serial: sh-sci: Document SoC specific bindings for r8a7796

Ji-Ze Hong (Peter Hong) (1):
      serial: 8250_fintek: fix the mismatched IRQ mode

Jiri Slaby (24):
      tty: ipwireless, cleanup TIOCGSERIAL
      net: ircomm, cleanup TIOCGSERIAL
      tty: cyclades+mxser, do not initialize to zero
      tty: frv, remove unused serial macros
      tty: stop defining STD_COM_FLAGS in drivers
      tty: 8250, drop unused members from struct old_serial_port
      tty: 8250, kill DEBUG_INTR
      TTY: serial, handle platform_get_irq retval properly
      tty: 8250, remove shadow and unused variables
      vt: remove lines parameter from scrollback
      vt: document vc_data by example
      sisusb: remove dummy variables
      tty: vt, consw->con_scrolldelta cleanup
      tty: vt, consw->con_set_palette cleanup
      tty: vt, remove consw->con_bmove
      tty: vt, drop VT_BUF_VRAM_ONLY
      tty: vt, get rid of ugly FLUSH macro
      tty: vt, separate T.416 high colors handler
      tty: vt, do not pass structure over stack
      tty: vt, too many commands per line in rgb_foreground
      tty: vt, whitespace cleanup in csi_m
      tty: vt, convert more macros to functions
      tty: vt, ignore PIO_UNIMAPCLR param
      tty: vt, remove unused vc_deccolm

Jonas Gorski (1):
      serial/bcm63xx_uart: use correct alias naming

Kefeng Wang (1):
      serial: 8250_early: Add earlycon support for Synopsys DesignWare ABP UART

Krzysztof Kozlowski (2):
      serial: samsung: Fix ERR pointer dereference on deferred probe
      serial: samsung: Fix possible out of bounds access on non-DT platform

Ludovic Desroches (1):
      tty/serial: atmel: add comment for the ring buffer size macro

Masahiro Yamada (5):
      serial: 8250_uniphier: add COMPILE_TEST option
      earlycon: mark earlycon code as __used iif the caller is built-in
      serial: 8250_uniphier: drop !defined(MODULE) conditional
      serial: 8250_mtk: drop !defined(MODULE) conditional
      serial: 8250_ingenic: drop #if conditional surrounding earlycon code

Matthew Leach (3):
      tty: serial: samsung: fixup accessors for endian
      tty: serial: samsung: add byte-order aware bit functions
      tty: serial: 8250: add CON_CONSDEV to flags

Muhammad Falak R Wani (1):
      tty/vt/keyboard: use memdup_user().

Nicolas Ferre (3):
      tty/serial: atmel: re-integrate status check in irq handler
      tty/serial: atmel: split tx and rx paths
      tty/serial: atmel: enforce tasklet init and termination sequences

Paul Gortmaker (3):
      serial: pxa: make it explicitly non-modular
      serial: vt8500_serial: make it explicitly non-modular
      serial: m32r_sio: make it explicitly non-modular

Purna Chandra Mandal (1):
      serial: pic32_uart: Fix double free of 'sport->irq_fault_name'.

Shubhrajyoti Datta (1):
      tty: xuartps: disable clocks when not used

Stephen Boyd (3):
      tty: serial: msm: Move header file into driver
      tty: serial: msm: Only configure MND registers on hw that has it
      tty: serial: msm: Cleanup include usage

Thomas Petazzoni (1):
      serial: mvebu-uart: free the IRQ in ->shutdown()

Vladimir Murzin (1):
      serial: mps2-uart: make driver explicitly non-modular

Yegor Yefremov (4):
      tty/serial/8250: make UART_MCR register access consistent
      serial: mctrl_gpio: add modem control read routine
      serial: mctrl_gpio: enable API usage only for initialized mctrl_gpios struct
      tty/serial/8250: use mctrl_gpio helpers

 Documentation/devicetree/bindings/serial/8250.txt  |  19 +
 .../bindings/serial/renesas,sci-serial.txt         |   6 +
 MAINTAINERS                                        |   1 +
 arch/frv/include/asm/serial.h                      |   4 -
 arch/xtensa/platforms/xt2000/setup.c               |   1 -
 drivers/dma/hsu/hsu.c                              |  90 ++++-
 drivers/dma/hsu/pci.c                              |  11 +-
 drivers/tty/cyclades.c                             |   4 -
 drivers/tty/ipwireless/tty.c                       |  11 +-
 drivers/tty/mxser.c                                |   1 -
 drivers/tty/serial/8250/8250.h                     |  51 ++-
 drivers/tty/serial/8250/8250_core.c                |  19 +-
 drivers/tty/serial/8250/8250_dma.c                 |   1 +
 drivers/tty/serial/8250/8250_early.c               |   1 +
 drivers/tty/serial/8250/8250_fintek.c              |  36 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   2 -
 drivers/tty/serial/8250/8250_mid.c                 |  24 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   2 +-
 drivers/tty/serial/8250/8250_omap.c                |  35 +-
 drivers/tty/serial/8250/8250_pci.c                 |  28 +-
 drivers/tty/serial/8250/8250_port.c                |  71 ++--
 drivers/tty/serial/8250/8250_uniphier.c            |   2 +-
 drivers/tty/serial/8250/Kconfig                    |   6 +-
 drivers/tty/serial/Kconfig                         |   3 +-
 drivers/tty/serial/amba-pl011.c                    |   8 +-
 drivers/tty/serial/atmel_serial.c                  | 143 ++++---
 drivers/tty/serial/bcm63xx_uart.c                  |   8 +-
 drivers/tty/serial/fsl_lpuart.c                    |   8 +-
 drivers/tty/serial/m32r_sio.c                      |  23 +-
 drivers/tty/serial/max310x.c                       | 176 +++++----
 drivers/tty/serial/mps2-uart.c                     |  29 +-
 drivers/tty/serial/msm_serial.c                    | 197 +++++++++-
 drivers/tty/serial/msm_serial.h                    | 184 ---------
 drivers/tty/serial/mvebu-uart.c                    |   2 +
 drivers/tty/serial/pic32_uart.c                    |   1 -
 drivers/tty/serial/pmac_zilog.c                    |   2 +-
 drivers/tty/serial/pxa.c                           |  30 +-
 drivers/tty/serial/samsung.c                       |  38 +-
 drivers/tty/serial/samsung.h                       |  38 +-
 drivers/tty/serial/serial-tegra.c                  |   7 +-
 drivers/tty/serial/serial_core.c                   |   8 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |  36 ++
 drivers/tty/serial/serial_mctrl_gpio.h             |  15 +-
 drivers/tty/serial/sh-sci.c                        | 196 ++++++++--
 drivers/tty/serial/sh-sci.h                        |  25 +-
 drivers/tty/serial/sirfsoc_uart.h                  |   4 +-
 drivers/tty/serial/vt8500_serial.c                 |  30 +-
 drivers/tty/serial/xilinx_uartps.c                 |  30 +-
 drivers/tty/vt/consolemap.c                        |  13 +-
 drivers/tty/vt/keyboard.c                          |  16 +-
 drivers/tty/vt/vt.c                                | 431 ++++++++++-----------
 drivers/tty/vt/vt_ioctl.c                          |   8 +-
 drivers/usb/misc/sisusbvga/sisusb.c                |  28 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c            |  87 +----
 drivers/usb/misc/sisusbvga/sisusb_init.h           |   2 +-
 drivers/video/console/dummycon.c                   |   3 -
 drivers/video/console/fbcon.c                      |  53 ++-
 drivers/video/console/mdacon.c                     |  45 ---
 drivers/video/console/newport_con.c                |  42 --
 drivers/video/console/sticon.c                     |  29 --
 drivers/video/console/vgacon.c                     |  29 +-
 include/linux/console.h                            |  13 +-
 include/linux/console_struct.h                     |  38 +-
 include/linux/dma/hsu.h                            |  14 +-
 include/linux/serial_8250.h                        |   1 +
 include/linux/serial_core.h                        |   8 +-
 include/linux/vt_kern.h                            |   7 +-
 net/irda/ircomm/ircomm_tty_ioctl.c                 |   8 -
 68 files changed, 1398 insertions(+), 1144 deletions(-)
 delete mode 100644 drivers/tty/serial/msm_serial.h
