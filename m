From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 3.19-rc5
Date: Fri, 16 Jan 2015 10:34:36 -0800
Message-ID: <20150116183436.GA28337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:

  Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.19-rc5

for you to fetch changes up to 31ec77aca72ee5920ed3ec3d047734dc0bc43342:

  serial: samsung: Add the support for Exynos5433 SoC (2015-01-09 13:46:02 -0800)

----------------------------------------------------------------
TTY/Serial driver fixes for 3.19-rc5

Here are some tty and serial driver fixes for 3.19-rc5 that resolve some
reported issues, and add a new device id to the 8250 serial port driver.

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chanwoo Choi (1):
      serial: samsung: Add the support for Exynos5433 SoC

James Bottomley (1):
      serial: fix parisc boot hang

Peter Hurley (2):
      tty: Prevent hw state corruption in exclusive mode reopen
      Revert "tty: Fix pty master poll() after slave closes v2"

Sergej Pupykin (1):
      tty: Add support for the WCH384 4S multi-IO card

 drivers/tty/n_tty.c                |  9 ++----
 drivers/tty/serial/8250/8250_pci.c | 29 ++++++++++++++++++--
 drivers/tty/serial/samsung.c       | 56 ++++++++++++++++++++++++--------------
 drivers/tty/serial/serial_core.c   |  4 ++-
 drivers/tty/tty_io.c               |  7 ++---
 5 files changed, 70 insertions(+), 35 deletions(-)
