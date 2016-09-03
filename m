From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver fixes for 4.8-rc5
Date: Sat, 3 Sep 2016 16:49:15 +0200
Message-ID: <20160903144915.GA10764@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.8-rc5

for you to fetch changes up to c8d192428f52f244130b84650ad616df09f2b1e1:

  serial: 8250: added acces i/o products quad and octal serial cards (2016-08-31 16:28:26 +0200)

----------------------------------------------------------------
Serial driver fixes for 4.8-rc5

Here are some small serial driver fixes for 4.8-rc5.  One fixes an
oft-reported build issue with the fintek driver, another reverts a patch
that was causing problems, one fixes a crash, and some new device ids
were added.

All of these have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      Revert "tty/serial/8250: use mctrl_gpio helpers"
      serial: 8250_mid: fix divide error bug if baud rate is 0

Arnd Bergmann (1):
      8250/fintek: rename IRQ_MODE macro

Jimi Damon (1):
      serial: 8250: added acces i/o products quad and octal serial cards

 Documentation/devicetree/bindings/serial/8250.txt |  19 ---
 drivers/tty/serial/8250/8250.h                    |  35 +-----
 drivers/tty/serial/8250/8250_core.c               |   9 --
 drivers/tty/serial/8250/8250_fintek.c             |   4 +-
 drivers/tty/serial/8250/8250_mid.c                |   3 +
 drivers/tty/serial/8250/8250_omap.c               |  31 ++---
 drivers/tty/serial/8250/8250_pci.c                | 139 ++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c               |   7 +-
 drivers/tty/serial/8250/Kconfig                   |   1 -
 include/linux/serial_8250.h                       |   1 -
 10 files changed, 159 insertions(+), 90 deletions(-)
