From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/Serial fix for 3.7-rc3
Date: Fri, 26 Oct 2012 10:16:57 -0700
Message-ID: <20121026171657.GA11406@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.7-rc3

for you to fetch changes up to a4f743851f74fc3e0cc40c13082e65c24139f481:

  Revert "serial: omap: fix software flow control" (2012-10-24 11:57:21 -0700)

----------------------------------------------------------------
Serial fix for 3.7-rc3

Here is one patch, a revert of a omap serial driver patch that was causing
problems, for your 3.7-rc tree.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Felipe Balbi (1):
      Revert "serial: omap: fix software flow control"

 arch/arm/plat-omap/include/plat/omap-serial.h |  4 ++--
 drivers/tty/serial/omap-serial.c              | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)
