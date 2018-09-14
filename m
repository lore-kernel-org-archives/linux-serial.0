From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.19-rc4
Date: Fri, 14 Sep 2018 13:26:20 +0200
Message-ID: <20180914112620.GA27809@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.19-rc4

for you to fetch changes up to 7f2bf7840b74a160f908db83bc8829f8de10629b:

  tty: hvc: hvc_write() fix break condition (2018-09-10 18:04:31 +0200)

----------------------------------------------------------------
TTY fixes for 4.19-rc4

Here are 3 small HVC tty driver fixes to resolve a reported regression
from 4.19-rc1.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Nicholas Piggin (3):
      tty: hvc: hvc_poll() fix read loop hang
      tty: hvc: hvc_poll() fix read loop batching
      tty: hvc: hvc_write() fix break condition

 drivers/tty/hvc/hvc_console.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)
