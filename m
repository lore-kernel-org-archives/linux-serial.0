From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.4-rc2
Date: Sun, 22 Nov 2015 14:30:17 -0800
Message-ID: <20151122223017.GA22988@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.4-rc2

for you to fetch changes up to bd63acf9e9a6b48e9c6c15f0f413f85a481cb5ef:

  serial: export fsl8250_handle_irq (2015-11-20 16:19:54 -0800)

----------------------------------------------------------------
TTY/Serial fixes for 4.4-rc2

Here are a few small tty/serial driver fixes for 4.4-rc2 that resolve
some reported problems.

All have been in linux-next, full details are in the shortlog below.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      serial: export fsl8250_handle_irq

Guenter Roeck (1):
      serial: etraxfs-uart: Fix crash

Heikki Krogerus (1):
      serial: 8250_mid: Add missing dependency

Peter Hurley (4):
      tty: Fix tty_send_xchar() lock order inversion
      tty: Fix direct use of tty buffer work
      serial: fsl_lpuart: Fix earlycon support
      tty: audit: Fix audit source

Simon Arlott (1):
      bcm63xx_uart: Use the device name when registering an interrupt

 drivers/tty/n_tty.c                | 2 +-
 drivers/tty/serial/8250/8250_fsl.c | 1 +
 drivers/tty/serial/8250/Kconfig    | 1 +
 drivers/tty/serial/Kconfig         | 2 +-
 drivers/tty/serial/bcm63xx_uart.c  | 2 +-
 drivers/tty/serial/etraxfs-uart.c  | 2 +-
 drivers/tty/tty_audit.c            | 2 +-
 drivers/tty/tty_io.c               | 4 ++++
 drivers/tty/tty_ioctl.c            | 4 ----
 drivers/tty/tty_ldisc.c            | 2 +-
 include/linux/tty.h                | 6 +++---
 11 files changed, 15 insertions(+), 13 deletions(-)
