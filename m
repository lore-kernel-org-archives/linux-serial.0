From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.1-rc2
Date: Thu, 30 Apr 2015 15:46:48 +0200
Message-ID: <20150430134648.GA32285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.1-rc2

for you to fetch changes up to 96a5d18bc1338786fecac73599f1681f59a59a8e:

  serial: 8250_pci: Add support for 16 port Exar boards (2015-04-28 20:22:31 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.1-rc2

Here are some small tty/serial driver fixes for 4.1-rc2.

They include some minor fixes that resolve reported issues, and a new
device quirk.

All have been in linux-next succesfully.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Frederic Danis (1):
      tty: Re-add external interface for tty_set_termios()

Ludovic Desroches (1):
      tty/serial: at91: maxburst was missing for dma transfers

Michal Simek (2):
      serial: xilinx: Use platform_get_irq to get irq description structure
      serial: of-serial: Remove device_type = "serial" registration

Peter Hurley (1):
      serial: core: Fix kernel-doc build warnings

Robert Baldyga (1):
      serial: samsung: fix serial console break

Soeren Grunewald (1):
      serial: 8250_pci: Add support for 16 port Exar boards

 drivers/tty/serial/8250/8250_pci.c | 25 +++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.c  |  2 ++
 drivers/tty/serial/of_serial.c     |  1 -
 drivers/tty/serial/samsung.c       |  5 +++--
 drivers/tty/serial/serial_core.c   |  2 +-
 drivers/tty/serial/uartlite.c      | 11 ++++++-----
 drivers/tty/serial/xilinx_uartps.c | 12 ++++++------
 drivers/tty/tty_ioctl.c            |  3 ++-
 include/linux/tty.h                |  1 +
 9 files changed, 44 insertions(+), 18 deletions(-)
