From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.1-rc6
Date: Fri, 19 Apr 2019 21:17:03 +0200
Message-ID: <20190419191703.GA4077@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc6

for you to fetch changes up to c53051128bb0e8754e13345d782ca69e5e1ce36d:

  sc16is7xx: put err_spi and err_i2c into correct #ifdef (2019-04-19 14:09:23 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.1-rc6

Here are 5 small fixes for some tty/serial/vt issues that have been
reported.

The vt one has been around for a while, it is good to finally get that
resolved.  The others fix a build warning that showed up in 5.1-rc1, and
resolve a problem in the sh-sci driver.

Note, the second patch for build warning fix for the sc16is7xx driver
was just applied to the tree, as it resolves a problem with the previous
patch to try to solve the issue.  It has not shown up in linux-next yet,
unlike all of the other patches, but it has passed 0-day testing and
everyone seems to agree that it is correct.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (2):
      serial: sh-sci: Fix HSCIF RX sampling point calculation
      serial: sh-sci: Fix HSCIF RX sampling point adjustment

Guoqing Jiang (2):
      sc16is7xx: move label 'err_spi' to correct section
      sc16is7xx: put err_spi and err_i2c into correct #ifdef

Mikulas Patocka (1):
      vt: fix cursor when clearing the screen

 drivers/tty/serial/sc16is7xx.c | 4 +++-
 drivers/tty/serial/sh-sci.c    | 6 ++++--
 drivers/tty/vt/vt.c            | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)
