From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.0-rc4
Date: Fri, 25 Jan 2019 13:22:44 +0100
Message-ID: <20190125122244.GA7566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc4

for you to fetch changes up to 815d835b7ba46685c316b000013367dacb2b461b:

  serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling (2019-01-22 09:32:08 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.0-rc4

Here are a number of small tty core and serial driver fixes for 5.0-rc4
to resolve some reported issues.

Nothing major, the small serial driver fixes, a tty core fixup for a
crash that was reported, and some good vt fixes from Nicolas Pitre as he
seems to be auditing that chunk of code a lot lately.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      tty: Handle problem if line discipline does not have receive_buf

He Zhe (1):
      serial: 8250: Fix serial8250 initialization crash

Matthias Kaehlcke (1):
      tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled

Nicolas Pitre (4):
      vt: make vt_console_print() compatible with the unicode screen buffer
      vt: always call notifier with the console lock held
      vt: invoke notifier on screen size change
      vgacon: unconfuse vc_origin when using soft scrollback

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling

 drivers/tty/n_hdlc.c                  |  1 +
 drivers/tty/serial/8250/8250_core.c   | 17 ++++++------
 drivers/tty/serial/fsl_lpuart.c       |  2 +-
 drivers/tty/serial/qcom_geni_serial.c |  4 +--
 drivers/tty/serial/serial_core.c      | 12 ++++++---
 drivers/tty/tty_io.c                  |  3 ++-
 drivers/tty/vt/vt.c                   | 50 ++++++++++++-----------------------
 drivers/video/console/vgacon.c        |  7 ++---
 8 files changed, 44 insertions(+), 52 deletions(-)
