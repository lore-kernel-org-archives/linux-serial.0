From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc6
Date: Sun, 9 Dec 2018 12:17:17 +0100
Message-ID: <20181209111717.GA9735@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc6

for you to fetch changes up to dada6a43b0402eba438a17ac86fdc64ac56a4607:

  kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var() (2018-12-06 15:59:07 +0100)

----------------------------------------------------------------
TTY driver fixes for 4.20-rc6

Here are three small tty driver fixes for 4.20-rc6

Nothing major, just some bug fixes for reported issues.  Full details
are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chanho Park (1):
      tty: do not set TTY_IO_ERROR flag if console port

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Peter Shih (1):
      tty: serial: 8250_mtk: always resume the device in probe.

 drivers/tty/serial/8250/8250_mtk.c | 16 +++++++---------
 drivers/tty/serial/kgdboc.c        |  4 ++--
 drivers/tty/tty_port.c             |  3 ++-
 3 files changed, 11 insertions(+), 12 deletions(-)
