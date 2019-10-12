From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.4-rc3
Date: Sat, 12 Oct 2019 18:16:14 +0200
Message-ID: <20191012161614.GA2191633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc3

for you to fetch changes up to 10deeac921647c929c67752d377f22e632d55d1c:

  MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb (2019-10-11 08:40:29 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.4-rc3

Here are some small tty and serial driver fixes for 5.4-rc3 that resolve
a number of reported issues and regressions.

None of these are huge, full details are in the shortlog.  THere's also
a MAINTAINERS update that I think you might have already taken in your
tree already, but git should handle that merge easily.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Ford (2):
      serial: mctrl_gpio: Check for NULL pointer
      serial: 8250_omap: Fix gpio check for auto RTS/CTS

Andrey Smirnov (1):
      tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()

Anson Huang (1):
      tty: serial: imx: Use platform_get_irq_optional() for optional IRQs

Biju Das (1):
      dt-bindings: serial: sh-sci: Document r8a774b1 bindings

Christoph Hellwig (1):
      serial/sifive: select SERIAL_EARLYCON

Christophe JAILLET (2):
      tty: serial: owl: Fix the link time qualifier of 'owl_uart_exit()'
      tty: serial: rda: Fix the link time qualifier of 'rda_uart_exit()'

Douglas Anderson (1):
      MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb

Geert Uytterhoeven (1):
      serial: sh-sci: Use platform_get_irq_optional() for optional interrupts

Michal Simek (1):
      serial: uartps: Fix uartps_major handling

Randy Dunlap (3):
      serial: uartlite: fix exit path null pointer
      tty: n_hdlc: fix build on SPARC
      serial: fix kernel-doc warning in comments

Stefan-gabriel Mirea (2):
      tty: serial: linflexuart: Fix magic SysRq handling
      tty: serial: Fix PORT_LINFLEXUART definition

 .../bindings/serial/renesas,sci-serial.txt          |  2 ++
 MAINTAINERS                                         |  1 +
 drivers/tty/n_hdlc.c                                |  5 +++++
 drivers/tty/serial/8250/8250_omap.c                 |  5 +++--
 drivers/tty/serial/Kconfig                          |  1 +
 drivers/tty/serial/fsl_linflexuart.c                | 21 ++++++++++++++-------
 drivers/tty/serial/fsl_lpuart.c                     |  2 +-
 drivers/tty/serial/imx.c                            |  4 ++--
 drivers/tty/serial/owl-uart.c                       |  2 +-
 drivers/tty/serial/rda-uart.c                       |  2 +-
 drivers/tty/serial/serial_core.c                    |  2 ++
 drivers/tty/serial/serial_mctrl_gpio.c              |  3 +++
 drivers/tty/serial/sh-sci.c                         |  8 ++++++--
 drivers/tty/serial/uartlite.c                       |  3 ++-
 drivers/tty/serial/xilinx_uartps.c                  |  8 +++++++-
 include/uapi/linux/serial_core.h                    |  2 +-
 16 files changed, 52 insertions(+), 19 deletions(-)
