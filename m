From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.18-rc3
Date: Sun, 1 Jul 2018 10:40:13 +0200
Message-ID: <20180701084013.GA11580@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.18-rc3

for you to fetch changes up to 21eff69aaaa0e766ca0ce445b477698dc6a9f55a:

  vt: prevent leaking uninitialized data to userspace via /dev/vcs* (2018-06-28 21:34:39 +0900)

----------------------------------------------------------------
TTY/Serial fixes for 4.18-rc3

Here are 5 fixes for the tty core and some serial drivers.

The tty core one fix some security and other issues reported by the
syzbot that I have taken too long in responding to (sorry Tetsuo!).  The
8350 serial driver fix resolves an issue of devices that used to work
properly stopping working as they shouldn't have been added to a
blacklist.

All of these have been in linux-next for a few days with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Andy Shevchenko (1):
      serial: 8250_pci: Remove stalled entries in blacklist

Johan Hovold (1):
      serdev: fix memleak on module unload

Tetsuo Handa (2):
      n_tty: Fix stall at n_tty_receive_char_special().
      n_tty: Access echo_* variables carefully.

 drivers/tty/n_tty.c                | 55 ++++++++++++++++++++++----------------
 drivers/tty/serdev/core.c          |  1 +
 drivers/tty/serial/8250/8250_pci.c |  2 --
 drivers/tty/vt/vt.c                |  4 +--
 4 files changed, 35 insertions(+), 27 deletions(-)
