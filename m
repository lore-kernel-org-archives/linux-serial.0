From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY fix for 4.11-rc7
Date: Sun, 16 Apr 2017 09:56:10 +0200
Message-ID: <20170416075609.GA24726@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit a71c9a1c779f2499fb2afc0553e543f18aff6edf:

  Linux 4.11-rc5 (2017-04-02 17:23:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.11-rc7

for you to fetch changes up to a8983d01f9b7d600fbdb3916899edf395954cc83:

  Revert "tty: don't panic on OOM in tty_set_ldisc()" (2017-04-14 10:59:56 +0200)

----------------------------------------------------------------
TTY fix for 4.11-rc7

Here is a single tty core revert for a patch that was reported to cause
problems.  The original issue is one that we have lived with for
decades, so trying to scramble to fix the fix in time for 4.11-final
does not make sense due to the fragility of the tty ldisc layer.  Just
reverting it makes sense for now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "tty: don't panic on OOM in tty_set_ldisc()"

 drivers/tty/tty_ldisc.c | 85 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 16 deletions(-)
