From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.6-rc5
Date: Sat, 23 Apr 2016 19:05:48 +0900
Message-ID: <20160423100548.GA20156@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.6-rc5

for you to fetch changes up to f077b73682910bc7dc9439e50e7b1ad97f28f3f1:

  Revert "serial: 8250: Add hardware dependency to RT288X option" (2016-04-19 15:17:37 +0900)

----------------------------------------------------------------
Serial fixes for 4.6-rc6

Here are 3 serial driver fixes for issues that have been reported.  Two
are reverts, fixing problems that were in the big TTY/Serial driver
merge in 4.6-rc1, and the last one is a simple bugfix for a regression
that showed up in 4.6-rc1 as well.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "serial: 8250: Add hardware dependency to RT288X option"

Sudip Mukherjee (1):
      Revert "serial-uartlite: Constify uartlite_be/uartlite_le"

Yegor Yefremov (1):
      tty/serial/8250: fix RS485 half-duplex RX

 drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
 drivers/tty/serial/8250/Kconfig     |  1 -
 drivers/tty/serial/uartlite.c       |  8 ++++----
 3 files changed, 14 insertions(+), 6 deletions(-)
