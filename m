From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.0-rc6
Date: Fri, 8 Feb 2019 09:38:08 +0100
Message-ID: <20190208083808.GA26882@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc6

for you to fetch changes up to fedb5760648a291e949f2380d383b5b2d2749b5e:

  serial: fix race between flush_to_ldisc and tty_open (2019-01-31 19:43:04 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.0-rc6

Here are some small tty and serial fixes for 5.0-rc6.

Nothing huge, just a few small fixes for reported issues.  The speakup
fix is in here as it is a tty operation issue.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_pci: Make PCI class test non fatal

Chris Brandt (1):
      serial: sh-sci: Do not free irqs that have already been freed

Greg Kroah-Hartman (1):
      serial: fix race between flush_to_ldisc and tty_open

Gustavo A. R. Silva (1):
      tty: serial: 8250_mtk: Fix potential NULL pointer dereference

Johan Hovold (1):
      staging: speakup: fix tty-operation NULL derefs

 drivers/staging/speakup/spk_ttyio.c | 6 ++++--
 drivers/tty/serial/8250/8250_mtk.c  | 3 +++
 drivers/tty/serial/8250/8250_pci.c  | 9 +++++----
 drivers/tty/serial/serial_core.c    | 6 ++++++
 drivers/tty/serial/sh-sci.c         | 9 ++++++++-
 5 files changed, 26 insertions(+), 7 deletions(-)
