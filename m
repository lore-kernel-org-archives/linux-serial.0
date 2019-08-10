From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.3-rc4
Date: Sat, 10 Aug 2019 13:52:35 +0200
Message-ID: <20190810115235.GA5930@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc4

for you to fetch changes up to 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1:

  kgdboc: disable the console lock when in kgdb (2019-07-30 17:39:39 +0200)

----------------------------------------------------------------
TTY fix for 5.3-rc4

Here is a single tty kgdb fix for 5.3-rc4.

It fixes an annoying log message that has caused kdb to become useless.
It's another fallout from ddde3c18b700 ("vt: More locking checks") which
tries to enforce locking checks more strictly in the tty layer,
unfortunatly when kdb is stopped, there's no need for locks :)

This patch has been linux-next for a while with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Douglas Anderson (1):
      kgdboc: disable the console lock when in kgdb

 drivers/tty/serial/kgdboc.c | 4 ++++
 1 file changed, 4 insertions(+)
