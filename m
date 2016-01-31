From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.5-rc2
Date: Sun, 31 Jan 2016 11:00:38 -0800
Message-ID: <20160131190038.GA28194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.5-rc2

for you to fetch changes up to 6c55d9b98335f7f6bd5f061866ff1633401f3a44:

  serial: 8250_pci: Add Intel Broadwell ports (2016-01-29 08:15:33 -0800)

----------------------------------------------------------------
TTY/Serial fixes for 4.5-rc2

Here are some small tty/serial driver fixes for 4.5-rc2.

They resolve a number of reported problems (the ioctl one specifically
has been pointed out by numerous people) and one patch adds some new
device ids for the 8250_pci driver.  All have been in linux-next
successfully.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Mika Westerberg (1):
      serial: 8250_pci: Add Intel Broadwell ports

Peter Hurley (5):
      tty: Wait interruptibly for tty lock on reopen
      tty: Retry failed reopen if tty teardown in-progress
      tty: Fix unsafe ldisc reference via ioctl(TIOCGETD)
      n_tty: Fix unsafe reference to "other" ldisc
      staging/speakup: Use tty_ldisc_ref() for paste kworker

 drivers/staging/speakup/selection.c |  5 ++++-
 drivers/tty/n_tty.c                 |  7 ++----
 drivers/tty/serial/8250/8250_pci.c  | 29 ++++++++++++++++++++++++
 drivers/tty/tty_io.c                | 44 ++++++++++++++++++++++++++++++++-----
 drivers/tty/tty_mutex.c             |  8 +++++++
 include/linux/tty.h                 |  1 +
 6 files changed, 82 insertions(+), 12 deletions(-)
