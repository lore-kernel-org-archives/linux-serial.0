From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.3-rc7
Date: Fri, 23 Oct 2015 14:26:24 -0700
Message-ID: <20151023212624.GA5097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.3-rc7

for you to fetch changes up to f235f664a8afabccf863a5dee4777d2d7b676fda:

  fbcon: initialize blink interval before calling fb_set_par (2015-10-17 22:00:39 -0700)

----------------------------------------------------------------
tty/serial fixes for 4.3-rc7

Here are two fixes that resolve reported issues, one with the 8250
driver, and the other with the generic fbcon driver.

Both have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Frederic Danis (1):
      Revert "serial: 8250_dma: don't bother DMA with small transfers"

Scot Doyle (1):
      fbcon: initialize blink interval before calling fb_set_par

 drivers/tty/serial/8250/8250_dma.c | 4 ----
 drivers/video/console/fbcon.c      | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)
