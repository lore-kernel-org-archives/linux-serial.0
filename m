From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver fixes for 4.9-rc3
Date: Sat, 29 Oct 2016 12:45:55 -0400
Message-ID: <20161029164555.GA4394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.9-rc3

for you to fetch changes up to d0f4bce2bce7e998abc906f3590e9032af7a41ba:

  tty: serial_core: fix NULL struct tty pointer access in uart_write_wakeup (2016-10-28 08:13:07 -0400)

----------------------------------------------------------------
tty/serial driver fixes for 4.9-rc3

Here are a number of small tty and serial driver fixes for reported
issues for 4.9-rc3.  Nothing major, but they do resolve a bunch of
problems with the tty core changes that are in 4.9-rc1, and finally the
atmel serial driver is back working properly.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Brice (1):
      tty: serial: fsl_lpuart: Fix Tx DMA edge case

Andy Shevchenko (1):
      serial: 8250_lpss: enable MSI for sure

Denys Vlasenko (1):
      serial: 8250_uniphier: fix more unterminated string

Dmitry Vyukov (1):
      tty: limit terminal size to 4M chars

Francois Berder (1):
      sc16is7xx: always write state when configuring GPIO as an output

Geert Uytterhoeven (3):
      serial: stm32: Fix comparisons with undefined register
      serial: SERIAL_STM32 should depend on HAS_DMA
      tty: serial_core: Fix serial console crash on port shutdown

Jiri Slaby (1):
      tty: vt, fix bogus division in csi_J

Masahiro Yamada (1):
      serial: 8250_uniphier: fix clearing divisor latch access bit

Nava kishore Manne (2):
      serial: xuartps: Add new compatible string for ZynqMP
      devicetree: bindings: uart: Add new compatible string for ZynqMP

Richard Genoud (1):
      tty/serial: at91: fix hardware handshake on Atmel platforms

Rob Herring (2):
      serial: core: fix console problems on uart_close
      tty: serial_core: fix NULL struct tty pointer access in uart_write_wakeup

Scot Doyle (1):
      vt: clear selection before resizing

Sergei Shtylyov (1):
      sh-sci: document R8A7743/5 support

Steve Shih (1):
      tty: serial: 8250: 8250_core: NXP SC16C2552 workaround

Wei Yongjun (1):
      serial: pch_uart: add terminate entry for dmi_system_id tables

 .../devicetree/bindings/serial/cdns,uart.txt       |  4 +++-
 .../bindings/serial/renesas,sci-serial.txt         |  8 +++++++
 drivers/tty/serial/8250/8250_lpss.c                |  2 +-
 drivers/tty/serial/8250/8250_port.c                |  3 ++-
 drivers/tty/serial/8250/8250_uniphier.c            |  4 ++--
 drivers/tty/serial/Kconfig                         |  1 +
 drivers/tty/serial/atmel_serial.c                  | 26 ++++++++++++++++++----
 drivers/tty/serial/fsl_lpuart.c                    |  3 +--
 drivers/tty/serial/pch_uart.c                      |  1 +
 drivers/tty/serial/sc16is7xx.c                     |  8 +++++--
 drivers/tty/serial/serial_core.c                   |  8 +++----
 drivers/tty/serial/stm32-usart.h                   |  2 +-
 drivers/tty/serial/xilinx_uartps.c                 |  2 ++
 drivers/tty/vt/vt.c                                |  7 +++++-
 14 files changed, 60 insertions(+), 19 deletions(-)
