From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.16-rc6
Date: Wed, 14 Mar 2018 12:30:10 +0100
Message-ID: <20180314113010.GA23819@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.16-rc6

for you to fetch changes up to 5d7f77ec72d10c421bc33958f06a5583f2d27ed6:

  serial: imx: fix bogus dev_err (2018-02-28 13:48:21 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.16-rc6

Here are some small TTY core and Serial driver fixes for 4.16-rc6.

They resolve some newly reported bugs, as well as some very old ones,
which is always nice to see.  There is also a new device id added in
here for good measure.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_pci: Don't fail on multiport card class

Greentime Hu (1):
      earlycon: add reg-offset to physical address before mapping

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized in autoconfig

Tejun Heo (1):
      tty: make n_tty_read() always abort if hangup is in progress

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

phil eichinger (1):
      serial: imx: fix bogus dev_err

 drivers/tty/n_tty.c                |  6 ++++++
 drivers/tty/serial/8250/8250_pci.c | 21 ++++++++++++++++++---
 drivers/tty/serial/atmel_serial.c  |  1 +
 drivers/tty/serial/earlycon.c      |  3 ++-
 drivers/tty/serial/imx.c           |  2 +-
 drivers/tty/serial/serial_core.c   |  2 ++
 drivers/tty/serial/sh-sci.c        |  2 ++
 drivers/tty/tty_io.c               |  9 +++++++++
 include/linux/tty.h                |  1 +
 9 files changed, 42 insertions(+), 5 deletions(-)
