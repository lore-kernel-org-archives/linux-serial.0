From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/Serial fixes for 3.12-rc4
Date: Sat, 5 Oct 2013 10:34:03 -0700
Message-ID: <20131005173403.GA4811@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.12-rc4

for you to fetch changes up to a9fbf4d591da6cd1d3eaab826c7c15f77fc8f6a3:

  xen/hvc: allow xenboot console to be used again (2013-10-03 16:12:58 -0700)

----------------------------------------------------------------
TTY fixes for 3.12-rc4

Here are 2 tty driver fixes for 3.12-rc4.

One fixes the reported regression in the n_tty code that a number of
people found recently, and the other one fixes an issue with xen
consoles that broke in 3.10.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
David Vrabel (1):
      xen/hvc: allow xenboot console to be used again

Peter Hurley (1):
      tty: Fix pty master read() after slave closes

 drivers/tty/hvc/hvc_xen.c |  1 +
 drivers/tty/n_tty.c       | 46 ++++++++++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 20 deletions(-)
