From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.15-rc3
Date: Tue, 5 Dec 2017 16:45:20 +0100
Message-ID: <20171205154520.GA4498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.15-rc3

for you to fetch changes up to c8ec2041f549e7f2dee0c34d25381be6f7805f99:

  MIPS: Add custom serial.h with BASE_BAUD override for generic kernel (2017-11-28 16:53:24 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.15-rc3

Here are some small serdev and serial fixes for 4.15-rc3.  They resolve
some reported problems:
	- a number of serdev fixes to resolve crashes
	- MIPS build fixes for their serial port
	- a new 8250 device id

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Johan Hovold (4):
      serdev: ttyport: add missing receive_buf sanity checks
      serdev: fix receive_buf return value when no callback
      serdev: ttyport: fix NULL-deref on hangup
      serdev: ttyport: fix tty locking in close

Matt Redfearn (2):
      serial: 8250_early: Only set divisor if valid clk & baud
      MIPS: Add custom serial.h with BASE_BAUD override for generic kernel

Matt Wilson (1):
      serial: 8250_pci: Add Amazon PCI serial device ID

 arch/mips/include/asm/Kbuild         |  1 -
 arch/mips/include/asm/serial.h       | 22 ++++++++++++++++++++++
 drivers/tty/serdev/serdev-ttyport.c  | 26 +++++++++++++++++++++++---
 drivers/tty/serial/8250/8250_early.c | 14 ++++++++------
 drivers/tty/serial/8250/8250_pci.c   |  3 +++
 include/linux/serdev.h               |  2 +-
 6 files changed, 57 insertions(+), 11 deletions(-)
 create mode 100644 arch/mips/include/asm/serial.h
