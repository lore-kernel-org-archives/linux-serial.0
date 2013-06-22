From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/Serial fixes for 3.10-rc7
Date: Sat, 22 Jun 2013 07:31:06 -0700
Message-ID: <20130622143106.GA10869@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40887 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab3FVOaY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 Jun 2013 10:30:24 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.10-rc6

for you to fetch changes up to 7c61c3d8f44d5d822f758754287af644307b4af9:

  tty: Fix transient pty write() EIO (2013-06-17 12:37:29 -0700)

----------------------------------------------------------------
TTY fixes for 3.10-rc7

Here are two tty core fixes that resolve some regressions that have been
reported recently.  Both tiny fixes, but needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Peter Hurley (1):
      tty: Fix transient pty write() EIO

Ross Lagerwall (1):
      tty/vt: Return EBUSY if deallocating VT1 and it is busy

 drivers/tty/pty.c         | 13 +++++--------
 drivers/tty/vt/vt_ioctl.c |  5 +----
 2 files changed, 6 insertions(+), 12 deletions(-)
