From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.3-rc2
Date: Sun, 28 Jul 2019 14:01:33 +0200
Message-ID: <20190728120133.GA16163@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc2

for you to fetch changes up to 61d51456f35760a09e8aa1e6ddd247f1547015d3:

  vt: Grab console_lock around con_is_bound in show_bind (2019-07-25 13:47:35 +0200)

----------------------------------------------------------------
TTY fixes for 5.3-rc2

Here are 2 tty/vt patches for 5.3-rc2
  - delete the netx-serial driver as the arch has been removed, no need
    to keep the serial driver for it around either.
  - vt console_lock fix to resolve a reported noisy warning at runtime

Both of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daniel Vetter (1):
      vt: Grab console_lock around con_is_bound in show_bind

Linus Walleij (1):
      tty: serial: netx: Delete driver

 drivers/tty/serial/Kconfig       |  19 -
 drivers/tty/serial/Makefile      |   1 -
 drivers/tty/serial/netx-serial.c | 733 ---------------------------------------
 drivers/tty/vt/vt.c              |   6 +-
 include/uapi/linux/serial_core.h |   3 -
 5 files changed, 5 insertions(+), 757 deletions(-)
 delete mode 100644 drivers/tty/serial/netx-serial.c
