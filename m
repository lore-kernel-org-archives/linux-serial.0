From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.5-rc4
Date: Sun, 14 Feb 2016 11:02:05 -0800
Message-ID: <20160214190205.GA23761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.5-rc4

for you to fetch changes up to c8053b58762745d93930826b60a4073854a15ce5:

  Revert "8250: uniphier: allow modular build with 8250 console" (2016-02-07 18:22:54 -0800)

----------------------------------------------------------------
tty/serial fixes for 4.5-rc4

Here are a number of small tty and serial driver fixes for 4.5-rc4 that
resolve some reported issues.

One of them got reverted as it wasn't correct based on testing, and all
have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (2):
      8250: uniphier: allow modular build with 8250 console
      serial/omap: mark wait_for_xmitr as __maybe_unused

Greg Kroah-Hartman (1):
      Revert "8250: uniphier: allow modular build with 8250 console"

Herton R. Krzesinski (2):
      pty: fix possible use after free of tty->driver_data
      pty: make sure super_block is still valid in final /dev/tty close

Jeremy McNicoll (1):
      tty: Add support for PCIe WCH382 2S multi-IO card

Peter Hurley (2):
      tty: Drop krefs for interrupted tty lock
      serial: omap: Prevent DoS using unprivileged ioctl(TIOCSRS485)

 drivers/tty/pty.c                  | 21 ++++++++++++++++++++-
 drivers/tty/serial/8250/8250_pci.c | 21 +++++++++++++++++++++
 drivers/tty/serial/omap-serial.c   | 10 +++++++---
 drivers/tty/tty_io.c               |  3 +--
 drivers/tty/tty_mutex.c            |  7 ++++++-
 fs/devpts/inode.c                  | 20 ++++++++++++++++++++
 include/linux/devpts_fs.h          |  4 ++++
 7 files changed, 79 insertions(+), 7 deletions(-)
