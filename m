From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver changes for 4.10-rc1
Date: Tue, 13 Dec 2016 09:36:36 -0800
Message-ID: <20161213173636.GA32089@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.10-rc1

for you to fetch changes up to a9b01b5823f73dc741b623dfc52ccd68f8139b55:

  serial: 8250_mid fix calltrace when hotplug 8250 serial controller (2016-11-30 13:06:08 +0100)

----------------------------------------------------------------
TTY/Serial patches for 4.10-rc1

Here's the tty/serial patchset for 4.10-rc1.

It's been a quiet kernel cycle for this subsystem, just a small number
of changes.  A few new serial drivers, and some cleanups to the old
vgacon logic, and other minor serial driver changes as well.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksey Makarov (1):
      serial: pl011: add console matching function

Andy Shevchenko (6):
      serial: 8250_lpss: set PCI master only for private DMA
      serial: 8250_lpss: Try to enable Memory-Write-Invalidate
      serial: 8250_lpss: get IRQ via pci_irq_vector()
      serial: 8250_port: export serial8250_rpm_{get|put}_tx()
      serial: 8250_dma: power off device after TX is done
      serial: core: don't check port twice in a row

Angelo Butti (1):
      8250: FIX Fourth port offset of Pericom PI7C9X7954 boards

Arnd Bergmann (4):
      serial: 8250_pxa: hide early console setup when disabled
      serial: pxa2xx: remove __deprecated annotation
      serial: pxa2xx: mark PM functions as __maybe_unused
      tty: nozomi: avoid sprintf buffer overflow

Askar Safin (1):
      tty: typo in comments in drivers/tty/vt/keyboard.c

Ed Blake (3):
      serial: 8250: Add IrDA to UART capabilities
      serial: 8250: Expose set_ldisc function
      serial: 8250_dw: Add support for IrDA SIR mode

Gabriel Krisman Bertazi (1):
      serial: 8250_pci: Detach low-level driver during PCI error recovery

Greg Kroah-Hartman (2):
      serial: fsl_lpuart: remove build warning
      Merge 4.9-rc3 into tty-next

Ji-Ze Hong (Peter Hong) (6):
      serial: 8250_fintek: Refactoring read/write method
      serial: 8250_fintek: Set IRQ Mode when port probed
      serial: 8250_fintek: Set maximum FIFO of F81216H
      serial: 8250_fintek: Add F81216 Support
      serial: 8250_fintek: Add F81866 Support
      serial: 8250_fintek: Add F81865 Support

Jiri Slaby (7):
      tty: vt, cleanup and document con_scroll
      tty: vt, unify scrolling functions
      tty: vgacon+sisusb, move scrolldelta to a common helper
      tty: vt, compute vc offsets in advance
      tty: vt, rename variables to sane names
      vgacon: switch boolean variables to bool
      vgacon: remove prehistoric macros

Johan Hovold (3):
      tty: amiserial: fix invalid user-pointer check
      tty: rocket: fix invalid user-pointer checks
      serial: crisv10: fix invalid user-pointer check

Josh Cartwright (1):
      sc16is7xx: Drop bogus use of IRQF_ONESHOT

Julia Lawall (1):
      tty: nozomi: use permission-specific DEVICE_ATTR variants

Kefeng Wang (1):
      tty: amba-pl011: Add earlycon support for SBSA UART

Liwei Song (1):
      serial: 8250_mid fix calltrace when hotplug 8250 serial controller

Maciej S. Szmigiero (1):
      vt: fix Scroll Lock LED trigger name

Masahiro Yamada (2):
      serial: 8250_uniphier: hardcode regshift to avoid unneeded memory read
      serial: 8250_uniphier: avoid locking for FCR register write

Nicolae Rosia (2):
      tty: serial: fsl_lpuart: add polled console functions
      tty: serial: Makefile: move kgdb to be initialized last

Paul Gortmaker (1):
      tty: serial: make crisv10 explicitly non-modular

Peter Robinson (1):
      tty: serial: Make the STM32 serial port depend on it's arch

Robert Jarzmik (1):
      serial: 8250: pxa: add devicetree earlyconsole

Sergey Yanovich (1):
      serial: rewrite pxa2xx-uart to use 8250_core

Souptick Joarder (4):
      serial: ioc4_serial: Free memory when kzalloc fails during probe
      serial: ifx6x60: Free memory when probe fails
      serial: sunhv: Free memory when remove() is called
      serial: sunsu: Free memory when probe fails

Takatoshi Akiyama (1):
      serial: sh-sci: Fix deadlock caused by serial output request

Waiman Long (1):
      console: Move userspace I/O out of console_lock to fix lockdep warning

Wolfgang Ocker (1):
      mxs-auart: count FIFO overrun errors

 Documentation/VGA-softcursor.txt        |  12 +-
 arch/x86/platform/ce4100/ce4100.c       |   2 +-
 drivers/tty/amiserial.c                 |   2 -
 drivers/tty/nozomi.c                    |  51 ++-----
 drivers/tty/rocket.c                    |   4 -
 drivers/tty/serial/8250/8250.h          |   6 +
 drivers/tty/serial/8250/8250_core.c     |   7 +-
 drivers/tty/serial/8250/8250_dma.c      |   9 +-
 drivers/tty/serial/8250/8250_dw.c       |  22 +++
 drivers/tty/serial/8250/8250_fintek.c   | 231 ++++++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_lpss.c     |   7 +-
 drivers/tty/serial/8250/8250_mid.c      |   4 +-
 drivers/tty/serial/8250/8250_of.c       |   2 -
 drivers/tty/serial/8250/8250_pci.c      |  57 +++++++-
 drivers/tty/serial/8250/8250_port.c     |  18 ++-
 drivers/tty/serial/8250/8250_pxa.c      | 190 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_uniphier.c |  46 ++++---
 drivers/tty/serial/8250/Kconfig         |  10 ++
 drivers/tty/serial/8250/Makefile        |   1 +
 drivers/tty/serial/Kconfig              |  19 ++-
 drivers/tty/serial/Makefile             |   7 +-
 drivers/tty/serial/amba-pl011.c         |  56 ++++++++
 drivers/tty/serial/crisv10.c            |   8 +-
 drivers/tty/serial/fsl_lpuart.c         |  64 +++++++++
 drivers/tty/serial/ifx6x60.c            |   1 +
 drivers/tty/serial/ioc4_serial.c        |   7 +-
 drivers/tty/serial/mxs-auart.c          |   2 +-
 drivers/tty/serial/pxa.c                |   2 +
 drivers/tty/serial/sc16is7xx.c          |   2 +-
 drivers/tty/serial/serial_core.c        |  17 ++-
 drivers/tty/serial/sh-sci.c             |  20 +--
 drivers/tty/serial/sunhv.c              |   3 +-
 drivers/tty/serial/sunsu.c              |   1 +
 drivers/tty/vt/consolemap.c             | 115 ++++++++++------
 drivers/tty/vt/keyboard.c               |   4 +-
 drivers/tty/vt/vt.c                     |  85 ++++++++----
 drivers/usb/misc/sisusbvga/sisusb_con.c |  55 ++------
 drivers/video/console/fbcon.c           |  18 ++-
 drivers/video/console/mdacon.c          |   7 +-
 drivers/video/console/newport_con.c     |   8 +-
 drivers/video/console/sticon.c          |   7 +-
 drivers/video/console/vgacon.c          | 133 +++++-------------
 include/linux/console.h                 |  16 ++-
 include/linux/serial_8250.h             |   8 +-
 include/linux/serial_core.h             |   2 +
 include/linux/vt_kern.h                 |   2 +
 46 files changed, 921 insertions(+), 429 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pxa.c
