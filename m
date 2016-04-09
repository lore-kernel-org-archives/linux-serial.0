From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.6-rc3
Date: Sat, 9 Apr 2016 10:10:12 -0700
Message-ID: <20160409171012.GA24079@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.6-rc3

for you to fetch changes up to 5e00bbfbc5ec21e87d24e206bba9fc2cbe6631a1:

  tty: Fix merge of "tty: Refactor tty_open()" (2016-03-31 20:49:39 -0700)

----------------------------------------------------------------
TTY fixes for 4.6-rc3

Here are two tty fixes for issues found.  One was due to a merge error
in 4.6-rc1, and the other a regression fix for UML consoles that broke
in 4.6-rc1.

Both have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Peter Hurley (2):
      tty: Fix UML console breakage
      tty: Fix merge of "tty: Refactor tty_open()"

 drivers/tty/tty_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
