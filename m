From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY fixes for 4.15-rc6
Date: Sun, 31 Dec 2017 12:47:04 +0100
Message-ID: <20171231114704.GA28360@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.15-rc6

for you to fetch changes up to 966031f340185eddd05affcf72b740549f056348:

  n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD) (2017-12-21 11:19:22 +0100)

----------------------------------------------------------------
TTY fix for 4.15-rc6

Here is a single tty fix for a reported issue that you wrote the patch
for :)

It's been in linux-next for a week or so with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Linus Torvalds (1):
      n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)

 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
