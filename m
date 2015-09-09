From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY driver revert for 4.3-rc1
Date: Tue, 8 Sep 2015 21:36:21 -0700
Message-ID: <20150909043621.GA4170@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit a4fdb2a46f617b8b2cd47acec026ec16532edbc6:

  Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2015-09-04 07:18:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.3-rc1

for you to fetch changes up to 0de6cfb9f314db230c47b2158e7725208b3b4728:

  Revert "uart: pl011: Rename regs with enumeration" (2015-09-04 09:14:43 -0700)

----------------------------------------------------------------
TTY driver revert for 4.3-rc1

Here are some reverts for some tty patches (specifically the pl011
driver) that ended up breaking a bunch of machines (i.e. almost all of
the ones with this chip.)  People are working on a fix for this, but in
the meantime, it's best to just revert all 5 patches to restore people's
serial consoles.

These reverts have been in linux-next for many days now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (5):
      Revert "uart: pl011: Add support to ZTE ZX296702 uart"
      Revert "uart: pl011: Improve LCRH register access decision"
      Revert "uart: pl011: Introduce register look up table"
      Revert "uart: pl011: Introduce register accessor"
      Revert "uart: pl011: Rename regs with enumeration"

 drivers/tty/serial/Kconfig      |   4 +-
 drivers/tty/serial/amba-pl011.c | 503 ++++++++++------------------------------
 include/linux/amba/serial.h     |  14 --
 3 files changed, 125 insertions(+), 396 deletions(-)
