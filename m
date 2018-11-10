From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc2
Date: Sat, 10 Nov 2018 10:57:08 -0800
Message-ID: <20181110185708.GA13637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc2

for you to fetch changes up to 641a41dbba217ee5bd26abe6be77f8cead9cd00e:

  serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout (2018-11-09 09:34:50 -0800)

----------------------------------------------------------------
TTY/Serial fixes for 4.20-rc2

Here are some small tty fixes for 4.20-rc2

One of these missed the original 4.19-final release, I missed that I
hadn't done a pull request for it as it was in linux-next and my branch
for a long time, that's my fault.

The others are small, fixing some reported issues and finally fixing the
termios mess for alpha so that glibc has a chance to implement some
missing functionality that has been pending for many years now.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA

H. Peter Anvin (1):
      termios, tty/tty_baudrate.c: fix buffer overrun

H. Peter Anvin (Intel) (1):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

Mikulas Patocka (1):
      vt: fix broken display when running aptitude

Yoshihiro Shimoda (1):
      serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout

 arch/alpha/include/asm/termios.h       |  8 +++++++-
 arch/alpha/include/uapi/asm/ioctls.h   |  5 +++++
 arch/alpha/include/uapi/asm/termbits.h | 17 +++++++++++++++++
 drivers/tty/serial/sh-sci.c            |  8 ++++----
 drivers/tty/tty_baudrate.c             |  4 ++--
 drivers/tty/vt/vt.c                    |  2 +-
 6 files changed, 36 insertions(+), 8 deletions(-)
