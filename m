From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.12-rc3
Date: Sat, 27 May 2017 12:01:43 +0200
Message-ID: <20170527100143.GA15406@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.12-rc3

for you to fetch changes up to 59fe2cc8b1c32dd139da80fc8222b5b3290b7a09:

  serial: altera_uart: call iounmap() at driver remove (2017-05-25 14:36:37 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.12-rc3

Here are some serial and tty fixes for 4.12-rc3.  They are a bit
"bigger" than normal, which is why I had them "bake" in linux-next for a
few weeks and didn't send them to you for -rc2.

They revert a few of the serdev patches from 4.12-rc1, and bring things
back to how they were in 4.11, to try to make things a bit more stable
there.  Rob and Johan both agree that this is the way forward, so this
isn't people squabbling over semantics.  Other than that, just a few
minor serial driver fixes that people have had problems with.

All of these have been in linux-next for a few weeks with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Khoroshilov (1):
      serial: altera_jtaguart: adding iounmap()

Ard Biesheuvel (1):
      drivers/tty: 8250: only call fintek_8250_probe when doing port I/O

Christophe JAILLET (1):
      serial: efm32: Fix parity management in 'efm32_uart_console_get_options()'

Guilherme G. Piccoli (1):
      MAINTAINERS/serial: Change maintainer of jsm driver

Jan Kiszka (1):
      serial: exar: Fix stuck MSIs

Johan Hovold (6):
      Revert "tty_port: register tty ports with serdev bus"
      serdev: fix tty-port client deregistration
      serial: ifx6x60: fix use-after-free on module unload
      tty: ehv_bytechan: clean up init error handling
      tty/serdev: add serdev registration interface
      serial: enable serdev support

Lucas Stach (1):
      serial: core: fix crash in uart_suspend_port

Stefan Wahren (1):
      serdev: Restore serdev_device_write_buf for atomic context

Tobias Klauser (1):
      serial: altera_uart: call iounmap() at driver remove

Uwe Kleine-König (1):
      serial: imx: ensure UCR3 and UFCR are setup correctly

Vegard Nossum (1):
      tty: fix port buffer locking

 MAINTAINERS                          |  2 +-
 drivers/tty/ehv_bytechan.c           | 17 ++++----
 drivers/tty/serdev/core.c            | 12 ++++++
 drivers/tty/serdev/serdev-ttyport.c  | 21 ++++++----
 drivers/tty/serial/8250/8250_port.c  | 21 +++++-----
 drivers/tty/serial/altera_jtaguart.c |  1 +
 drivers/tty/serial/altera_uart.c     |  1 +
 drivers/tty/serial/efm32-uart.c      | 11 ++++--
 drivers/tty/serial/ifx6x60.c         |  2 +-
 drivers/tty/serial/imx.c             | 14 ++++++-
 drivers/tty/serial/serial_core.c     |  6 +--
 drivers/tty/tty_port.c               | 75 +++++++++++++++++++++++++++++++++---
 include/linux/serdev.h               | 19 +++++----
 include/linux/tty.h                  |  9 +++++
 14 files changed, 162 insertions(+), 49 deletions(-)
