From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.13-rc2
Date: Sat, 22 Jul 2017 11:54:49 +0200
Message-ID: <20170722095449.GA5821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.13-rc2

for you to fetch changes up to c6325179238f1d4683edbec53d8322575d76d7e2:

  tty: Fix TIOCGPTPEER ioctl definition (2017-07-17 17:04:41 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.13-rc2

Here are some small tty and serial driver fixes for 4.13-rc2.  Nothing
huge at all, a revert of a patch that turned out to break things, a fix
up for a new tty ioctl we added in 4.13-rc1 to get the uapi definition
correct, and a few minor serial driver fixes for reported issues.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      tty: hide unused pty_get_peer function

Dan Carpenter (2):
      serial: st-asc: Potential error pointer dereference
      serial: sh-sci: Uninitialized variables in sysfs files

Fabio Estevam (1):
      tty: serial: lpuart: Fix the logic for detecting the 32-bit type UART

Gleb Fotengauer-Malinovskiy (1):
      tty: Fix TIOCGPTPEER ioctl definition

Greg Kroah-Hartman (1):
      Revert "serial: imx-serial - move DMA buffer configuration to DT"

Ian Jamison (1):
      serial: imx: Prevent TX buffer PIO write when a DMA has been started

 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  2 -
 arch/alpha/include/uapi/asm/ioctls.h               |  2 +-
 arch/mips/include/uapi/asm/ioctls.h                |  2 +-
 arch/parisc/include/uapi/asm/ioctls.h              |  2 +-
 arch/powerpc/include/uapi/asm/ioctls.h             |  2 +-
 arch/sh/include/uapi/asm/ioctls.h                  |  2 +-
 arch/sparc/include/uapi/asm/ioctls.h               |  2 +-
 arch/xtensa/include/uapi/asm/ioctls.h              |  2 +-
 drivers/tty/pty.c                                  | 85 +++++++++++-----------
 drivers/tty/serial/fsl_lpuart.c                    | 24 +++---
 drivers/tty/serial/imx.c                           | 27 +++----
 drivers/tty/serial/sh-sci.c                        | 12 ++-
 drivers/tty/serial/st-asc.c                        |  1 +
 include/uapi/asm-generic/ioctls.h                  |  2 +-
 14 files changed, 83 insertions(+), 84 deletions(-)
