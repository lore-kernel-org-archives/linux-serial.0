From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc8
Date: Thu, 20 Dec 2018 13:39:10 +0100
Message-ID: <20181220123910.GA18277@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc8

for you to fetch changes up to 3c9dc275dba1124c1e16e7037226038451286813:

  Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again" (2018-12-17 16:18:29 +0100)

----------------------------------------------------------------
TTY/Serial fix for 4.20-rc8

Here is a single fix, a revert, for the 8250 serial driver to resolve a
reported problem.  There was some attempted patches to fix the issue,
but people are arguing about them, so reverting the patch to revert back
to the 4.19 and older behavior is the best thing to do at this late in
the release cycle.

The revert has been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Paul Burton (1):
      Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"

 drivers/tty/serial/8250/8250_port.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)
