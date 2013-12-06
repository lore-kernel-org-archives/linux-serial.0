From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/Serial fixes for 3.13-rc3
Date: Fri, 6 Dec 2013 10:25:53 -0800
Message-ID: <20131206182553.GA30323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56938 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3LFSZy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Dec 2013 13:25:54 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit c42b4e6501cdaabee8cc292ae1ef0f66bf4825c1:

  Revert "n_gsm: race between ld close and gsmtty open" (2013-11-25 18:30:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.13-rc3

for you to fetch changes up to 39434abd942c8e4b9c14c06a03b3245beaf8467f:

  n_tty: Fix missing newline echo (2013-11-29 12:53:19 -0800)

----------------------------------------------------------------
tty fix for 3.13-rc3

Here is a single n_tty fix for 3.13-rc3 that resolves a regression in 3.12 that
has been reported.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Peter Hurley (1):
      n_tty: Fix missing newline echo

 drivers/tty/n_tty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
