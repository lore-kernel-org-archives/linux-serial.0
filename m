From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.3-rc3
Date: Sat, 26 Sep 2015 09:52:19 -0700
Message-ID: <20150926165219.GA25243@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.3-rc3

for you to fetch changes up to f7a7651fcd40a2bf29357ffeaee176fb159bcddb:

  tty: serial: Add missing module license for 8250_base.ko (2015-09-22 09:09:15 -0700)

----------------------------------------------------------------
TTY/Serial driver fix for 4.3-rc3

Here is one serial driver fix for 4.3-rc3 that resolves a module loading
issue due to splitting up of the 8250 driver into smaller pieces.  It's
been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jonathan McDowell (1):
      tty: serial: Add missing module license for 8250_base.ko

 drivers/tty/serial/8250/8250_port.c | 2 ++
 1 file changed, 2 insertions(+)
