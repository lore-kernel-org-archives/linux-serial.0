From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.1-rc7
Date: Sat, 6 Jun 2015 16:39:46 -0700
Message-ID: <20150606233946.GA25610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.1-rc7

for you to fetch changes up to 72586c6061ab8c23ffd9f301ed19782a44ff5f04:

  n_tty: Fix auditing support for cannonical mode (2015-06-01 07:11:04 +0900)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.1-rc7

Here are a few TTY and Serial driver fixes for reported regressions and
crashes.  All of these have been in linux-next with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dave Martin (1):
      serial/amba-pl011: Unconditionally poll for FIFO space before each TX char

Laura Abbott (1):
      n_tty: Fix auditing support for cannonical mode

Mark Tomlinson (1):
      n_tty: Fix calculation of size in canon_copy_from_read_buf

Philipp Zabel (1):
      serial: imx: Fix DMA handling for IDLE condition aborts

Sebastian Andrzej Siewior (1):
      serial: 8250_omap: provide complete custom startup & shutdown callbacks

 drivers/tty/n_tty.c                 | 21 +++++++---
 drivers/tty/serial/8250/8250_omap.c | 82 +++++++++++++++++++++++++++++++++----
 drivers/tty/serial/amba-pl011.c     | 16 ++++----
 drivers/tty/serial/imx.c            |  8 ++++
 4 files changed, 105 insertions(+), 22 deletions(-)
