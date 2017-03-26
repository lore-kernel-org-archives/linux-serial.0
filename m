From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Sun, 26 Mar 2017 13:04:32 +0200
Message-ID: <20170326110432.GA9241@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.11-rc4

for you to fetch changes up to a4a3e061149f09c075f108b6f1cf04d9739a6bc2:

  tty: fix data race in tty_ldisc_ref_wait() (2017-03-17 14:07:10 +0900)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.11-rc4

Here are some tty and serial driver fixes for 4.11-rc4.  One of these
fix a long-standing issue in the ldisc code that was found by Dmitry
Vyukov with his great fuzzing work.  The other fixes resolve other
reported issues, and there is one revert of a patch in 4.11-rc1 that
wasn't correct.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksey Makarov (1):
      Revert "tty: serial: pl011: add ttyAMA for matching pl011 console"

Dmitry Vyukov (2):
      tty: don't panic on OOM in tty_set_ldisc()
      tty: fix data race in tty_ldisc_ref_wait()

Heiko Stuebner (1):
      serial: 8250_dw: Honor clk_round_rate errors in dw8250_set_termios

James Hogan (1):
      serial: 8250_dw: Fix breakage when HAVE_CLK=n

Timur Tabi (1):
      tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision

 drivers/acpi/spcr.c               |  2 +-
 drivers/tty/serial/8250/8250_dw.c |  9 +++-
 drivers/tty/serial/amba-pl011.c   |  2 +-
 drivers/tty/tty_ldisc.c           | 92 +++++++++------------------------------
 4 files changed, 30 insertions(+), 75 deletions(-)
