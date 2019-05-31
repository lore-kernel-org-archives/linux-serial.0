From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.2-rc3
Date: Thu, 30 May 2019 18:47:02 -0700
Message-ID: <20190531014702.GA30713@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc3

for you to fetch changes up to a1ad1cc9704f64c169261a76e1aee1cf1ae51832:

  vt/fbcon: deinitialize resources in visual_init() after failed memory allocation (2019-05-24 17:08:18 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.2-rc3

Here are some small serial and TTY driver fixes for 5.2-rc3.

Nothing major, just a number of fixes for reported issues.  The fbcon
core fix also resolves an issue, and was acked by the relevant
maintainer to go through this tree.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
George G. Davis (1):
      serial: sh-sci: disable DMA for uart_console

Grzegorz Halat (1):
      vt/fbcon: deinitialize resources in visual_init() after failed memory allocation

Joe Burmeister (1):
      tty: max310x: Fix external crystal register setup

Jorge Ramirez-Ortiz (1):
      tty: serial: msm_serial: Fix XON/XOFF

Sascha Hauer (1):
      serial: imx: remove log spamming error message

 drivers/tty/serial/imx.c         |  1 -
 drivers/tty/serial/max310x.c     |  2 +-
 drivers/tty/serial/msm_serial.c  |  5 ++++-
 drivers/tty/serial/sh-sci.c      |  7 +++++++
 drivers/tty/vt/vt.c              | 11 +++++++++--
 drivers/video/fbdev/core/fbcon.c |  2 +-
 6 files changed, 22 insertions(+), 6 deletions(-)
