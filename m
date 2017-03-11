From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver fixes for 4.11-rc2
Date: Sat, 11 Mar 2017 08:18:31 +0100
Message-ID: <20170311071831.GA8363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.11-rc2

for you to fetch changes up to f98c7bce570bdbe344b74ff5daa7dfeef3f22929:

  serial: samsung: Continue to work if DMA request fails (2017-03-07 19:58:37 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 4.11-rc2

Here are 2 bugfixes for tty stuff for 4.11-rc2.  One of them resolves
the pretty bad bug in the n_hdlc code that Alexander Popov found and
fixed and has been reported everywhere.  The other just fixes a samsung
serial driver issue when DMA fails on some systems.

Both have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Popov (1):
      tty: n_hdlc: get rid of racy n_hdlc.tbuf

Krzysztof Kozlowski (1):
      serial: samsung: Continue to work if DMA request fails

 drivers/tty/n_hdlc.c         | 132 ++++++++++++++++++++++---------------------
 drivers/tty/serial/samsung.c |   6 +-
 2 files changed, 73 insertions(+), 65 deletions(-)
