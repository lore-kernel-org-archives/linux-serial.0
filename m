From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.19-rc6
Date: Tue, 25 Sep 2018 16:24:35 +0200
Message-ID: <20180925142435.GA27225@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.19-rc6

for you to fetch changes up to 7e620984b62532783912312e334f3c48cdacbd5d:

  serial: imx: restore handshaking irq for imx1 (2018-09-20 14:51:31 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.19-rc6

Here are a number of small tty and serial driver fixes for reported
issues for 4.19-rc6.

One should hopefully resolve a much-reported issue that syzbot has found
in the tty layer.  Although there are still more issues there, getting
this fixed is nice to see finally happen.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Dmitry Safonov (1):
      tty: Drop tty->count on tty_reopen() failure

Gustavo A. R. Silva (1):
      tty: vt_ioctl: fix potential Spectre v1

Jan Kiszka (1):
      serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Stefan Agner (1):
      tty: serial: lpuart: avoid leaking struct tty_struct

Uwe Kleine-König (1):
      serial: imx: restore handshaking irq for imx1

 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 10 +++++++---
 drivers/tty/serial/fsl_lpuart.c             |  3 ++-
 drivers/tty/serial/imx.c                    |  8 ++++++++
 drivers/tty/serial/mvebu-uart.c             |  1 +
 drivers/tty/tty_io.c                        | 11 ++++++++---
 drivers/tty/vt/vt_ioctl.c                   |  4 ++++
 6 files changed, 30 insertions(+), 7 deletions(-)
