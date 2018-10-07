From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.19-rc7
Date: Sun, 7 Oct 2018 08:07:37 +0200
Message-ID: <20181007060737.GB13878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.19-rc7

for you to fetch changes up to 5b162cc4ac27ba76e576abc9090c54cf90a17980:

  Revert "serial: sh-sci: Allow for compressed SCIF address" (2018-10-02 14:38:16 -0700)

----------------------------------------------------------------
Serial driver fixes for 4.19-rc7

Here are 3 small serial driver fixes for 4.19-rc7
  - 2 sh-sci bugfixes for reported issues
  - a revert of the PM handling for the 8250_dw code

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (2):
      Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
      Revert "serial: sh-sci: Allow for compressed SCIF address"

Guenter Roeck (1):
      Revert "serial: 8250_dw: Fix runtime PM handling"

 drivers/tty/serial/8250/8250_dw.c |  4 ---
 drivers/tty/serial/sh-sci.c       | 56 ++++++++++++++++++++++++++++-----------
 include/linux/serial_sci.h        |  1 +
 3 files changed, 42 insertions(+), 19 deletions(-)
