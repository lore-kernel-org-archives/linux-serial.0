From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY fix for 4.12-rc4
Date: Sun, 4 Jun 2017 17:41:05 +0200
Message-ID: <20170604154105.GA10583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.12-rc4

for you to fetch changes up to fc098af16b9ff6d470d779d8ddcfb2d91869045a:

  Revert "tty: fix port buffer locking" (2017-06-04 10:23:25 +0200)

----------------------------------------------------------------
TTY fix for 4.12-rc4

Here is a single tty core fix for 4.12-rc4.  It reverts a patch that a
lot of people reported as causing lockdep and other warnings.  Right
after I reverted this in my tree, it seems like another "correct" fix
might have shown up, but it's too late in the release cycle to be
messing with tty core locking, so let's just revert this for now to go
back how things always have been and try it again for 4.13.

This has not been in linux-next as I only reverted it a few hours ago.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "tty: fix port buffer locking"

 drivers/tty/tty_port.c | 2 --
 1 file changed, 2 deletions(-)
