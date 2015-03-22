From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.0-rc5
Date: Sun, 22 Mar 2015 11:36:56 +0100
Message-ID: <20150322103656.GA22097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:

  Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.0-rc5

for you to fetch changes up to 7fd6f640f2dd17dac6ddd6702c378cb0bb9cfa11:

  serial: 8250_dw: Fix deadlock in LCR workaround (2015-03-11 16:39:52 +0100)

----------------------------------------------------------------
TTY/Serial driver fix for 4.0-rc5

Here's a single 8250 serial driver that fixes a reported deadlock with
the serial console and the tty driver.

It's been in linux-next for a while now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Peter Hurley (1):
      serial: 8250_dw: Fix deadlock in LCR workaround

 drivers/tty/serial/8250/8250_dw.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)
