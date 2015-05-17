From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.1-rc4
Date: Sat, 16 May 2015 17:33:50 -0700
Message-ID: <20150517003350.GA18001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.1-rc4

for you to fetch changes up to 1a48632ffed61352a7810ce089dc5a8bcd505a60:

  pty: Fix input race when closing (2015-05-10 19:26:37 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.1-rc4

Here's some TTY and serial driver fixes for reported issues.  All of
these have been in linux-next successfully.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dave Martin (1):
      Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is not open"

Pan Xinhui (1):
      tty/n_gsm.c: fix a memory leak when gsmtty is removed

Peter Hurley (2):
      earlycon: Revert log warnings
      pty: Fix input race when closing

Semen Protsenko (1):
      serial: omap: Fix error handling in probe

 Documentation/serial/tty.txt     |  3 +++
 drivers/tty/n_gsm.c              |  5 ++---
 drivers/tty/n_hdlc.c             |  4 ++--
 drivers/tty/n_tty.c              | 22 +++++++++++++++++----
 drivers/tty/pty.c                |  5 +++--
 drivers/tty/serial/amba-pl011.c  |  5 ++++-
 drivers/tty/serial/earlycon.c    |  9 ++-------
 drivers/tty/serial/omap-serial.c |  2 ++
 drivers/tty/tty_buffer.c         | 41 ++++++++++++++++++++++++++--------------
 include/linux/tty.h              |  2 +-
 10 files changed, 64 insertions(+), 34 deletions(-)
