From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.0-rc2
Date: Sun, 13 Jan 2019 11:23:16 +0100
Message-ID: <20190113102316.GA17169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc2

for you to fetch changes up to d3736d82e8169768218ee0ef68718875918091a0:

  tty: Don't hold ldisc lock in tty_reopen() if ldisc present (2019-01-11 17:03:42 +0100)

----------------------------------------------------------------
tty/serial fixes for 5.0-rc2

Here are 2 tty and serial fixes for 5.0-rc2 that resolve some reported
issues.

The first is a simple serial driver fix for a regression that showed up
in 5.0-rc1.  The second one resolves a number of reported issues with
the recent tty locking fixes that went into 5.0-rc1.  Lots of people
have tested the second one and say it resolves their issues.

Both have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Safonov (1):
      tty: Don't hold ldisc lock in tty_reopen() if ldisc present

Hauke Mehrtens (1):
      serial: lantiq: Do not swap register read/writes

 drivers/tty/serial/lantiq.c | 36 +++++++++++++++++++-----------------
 drivers/tty/tty_io.c        | 20 +++++++++++++-------
 2 files changed, 32 insertions(+), 24 deletions(-)
