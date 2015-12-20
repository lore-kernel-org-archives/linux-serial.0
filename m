From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.4-rc6
Date: Sat, 19 Dec 2015 16:38:28 -0800
Message-ID: <20151220003828.GA17513@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52bb9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.4-rc6

for you to fetch changes up to 9ce119f318ba1a07c29149301f1544b6c4bea52a:

  tty: Fix GPF in flush_to_ldisc() (2015-12-12 23:05:28 -0800)

----------------------------------------------------------------
TTY/Serial fixes for 4.4-rc6

Here are some tty/serial driver fixes for 4.4-rc6 that resolve some
reported problems.  All of these have been in linux-next.  The details
are in the shortlog.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      serial: earlycon: Add missing spinlock initialization

Masahiro Yamada (1):
      serial: 8250_uniphier: fix dl_read and dl_write functions

Peter Hurley (2):
      n_tty: Fix poll() after buffer-limited eof push read
      tty: Fix GPF in flush_to_ldisc()

Yoshihiro Shimoda (1):
      serial: sh-sci: Fix length of scatterlist

 drivers/tty/n_tty.c                     | 22 +++++++++-------------
 drivers/tty/serial/8250/8250_uniphier.c |  8 ++++++--
 drivers/tty/serial/earlycon.c           |  2 ++
 drivers/tty/serial/sh-sci.c             |  2 +-
 drivers/tty/tty_buffer.c                |  2 +-
 5 files changed, 19 insertions(+), 17 deletions(-)
