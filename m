From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/serial patches for 3.4-rc2
Date: Thu, 12 Apr 2012 15:26:55 -0700
Message-ID: <20120412222655.GC11612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-3.4-rc2

for you to fetch changes up to 11bbd5b6dae49fd7072ebf5eb63735827bd72f42:

  pch_uart: Add Kontron COMe-mTT10 uart clock quirk (2012-04-09 10:58:41 -0700)

----------------------------------------------------------------
tty and serial fixes for 3.4-rc2

Here are some tty and serial fixes for 3.4-rc2.

Most important here is the pl011 fix, which has been reported by about
100 different people, which means more people use it than I expected :)

There are also some 8250 driver reverts due to some problems reported by
them.  And other minor fixes as well.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      tty/serial/omap: console can only be built-in

Dan Williams (3):
      Revert "serial/8250_pci: init-quirk msi support for kt serial controller"
      Revert "serial/8250_pci: setup-quirk workaround for the kt serial controller"
      serial/8250_pci: add a "force background timer" flag and use it for the "kt" serial port

Kay Sievers (1):
      printk(): add KERN_CONT where needed in hpet and vt code

Kukjin Kim (1):
      serial: samsung: fix omission initialize ulcon in reset port fn()

Linus Walleij (1):
      serial: PL011: move interrupt clearing

Michael Brunner (1):
      pch_uart: Add Kontron COMe-mTT10 uart clock quirk

Shubhrajyoti D (1):
      omap-serial: Fix the error handling in the omap_serial probe

Siftar, Gabe (1):
      tty/serial: atmel_serial: fix RS485 half-duplex problem

Tilman Schmidt (1):
      isdn/gigaset: use gig_dbg() for debugging output

Tomoya MORINAGA (1):
      pch_uart: Fix MSI setting issue

Yuriy Kozlov (1):
      tty: serial: altera_uart: Check for NULL platform_data in probe.

 drivers/char/hpet.c                |    4 ++--
 drivers/isdn/gigaset/interface.c   |    2 +-
 drivers/tty/serial/8250/8250.c     |   12 +++++-----
 drivers/tty/serial/8250/8250_pci.c |   16 +-------------
 drivers/tty/serial/Kconfig         |    2 +-
 drivers/tty/serial/altera_uart.c   |    4 ++--
 drivers/tty/serial/amba-pl011.c    |    8 +++----
 drivers/tty/serial/atmel_serial.c  |    4 ++++
 drivers/tty/serial/omap-serial.c   |   43 +++++++++++++++++-------------------
 drivers/tty/serial/pch_uart.c      |    8 +++++++
 drivers/tty/serial/samsung.c       |    1 +
 drivers/tty/vt/vt.c                |    3 +--
 include/linux/serial_core.h        |    2 +-
 13 files changed, 52 insertions(+), 57 deletions(-)
