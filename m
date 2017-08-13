From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.13-rc5
Date: Sat, 12 Aug 2017 19:20:43 -0700
Message-ID: <20170813022043.GA27049@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:

  Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.13-rc5

for you to fetch changes up to 9527b82ae3af1ebf465506868fb55e7f862cd9da:

  Revert "serial: Delete dead code for CIR serial ports" (2017-08-01 09:50:18 -0700)

----------------------------------------------------------------
tty/serial fixes for 4.13-rc5

Here are two tty serial driver fixes for 4.13-rc5.  One is a revert of a
-rc1 patch that turned out to not be a good idea, and the other is a fix
for the pl011 serial driver.

Both have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Sean Young (1):
      Revert "serial: Delete dead code for CIR serial ports"

Timur Tabi (1):
      tty: pl011: fix initialization order of QDF2400 E44

 drivers/acpi/spcr.c                 | 36 ++++++++++++++++++++++++++++++++++--
 drivers/tty/serial/8250/8250_core.c | 23 +++++++++++++++++------
 drivers/tty/serial/amba-pl011.c     | 37 +++++++++++++++++++------------------
 include/linux/acpi.h                |  1 +
 4 files changed, 71 insertions(+), 26 deletions(-)
