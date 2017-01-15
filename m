From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver changes for 4.10-rc4
Date: Sun, 15 Jan 2017 13:40:14 +0100
Message-ID: <20170115124014.GA8090@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.10-rc4

for you to fetch changes up to 802c03881f29844af0252b6e22be5d2f65f93fd0:

  sysrq: attach sysrq handler correctly for 32-bit kernel (2017-01-11 09:22:54 +0100)

----------------------------------------------------------------
TTY/serial fixes for 4.10-rc4

Here are some small tty/serial driver fixes for 4.10-rc4 to resolve a
number of reported issues.

Nothing major here at all, one revert of a problematic patch, and some
other tiny bugfixes.  Full details are in the shortlog below.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akinobu Mita (1):
      sysrq: attach sysrq handler correctly for 32-bit kernel

Daniel Jedrychowski (1):
      Clearing FIFOs in RS485 emulation mode causes subsequent transmits to break

Gabriel Krisman Bertazi (1):
      8250_pci: Fix potential use-after-free in error path

Herbert Xu (1):
      Revert "tty: serial: 8250: add CON_CONSDEV to flags"

Richard Genoud (2):
      tty/serial: atmel_serial: BUG: stop DMA from transmitting in stop_tx
      tty/serial: atmel: RS485 half duplex w/DMA: enable RX after TX is done

 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/8250/8250_pci.c  | 12 +++++-------
 drivers/tty/serial/8250/8250_port.c |  2 +-
 drivers/tty/serial/atmel_serial.c   | 22 ++++++++++++++++------
 drivers/tty/sysrq.c                 |  4 ++--
 5 files changed, 25 insertions(+), 17 deletions(-)
