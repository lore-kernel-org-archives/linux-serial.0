From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] more TTY/Serial fixes for 3.8-rc4
Date: Wed, 23 Jan 2013 15:55:20 -0800
Message-ID: <20130123235520.GA11415@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33665 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3AWXz0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 18:55:26 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so5004806pbc.33
        for <linux-serial@vger.kernel.org>; Wed, 23 Jan 2013 15:55:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit 248152b60209874b1707a23d336b137486756a29:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k (2013-01-23 13:31:15 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.8-rc4

for you to fetch changes up to 5e30bbb723415fb94a098e314d1908a39a7e50a2:

  MAINTAINERS: Someone needs to watch over the serial drivers (2013-01-23 15:45:23 -0800)

----------------------------------------------------------------
TTY patches for 3.8-rc4

Just a MAINTAINERS update, now that Alan has left for a bit, I'll
continue to watch over the serial drivers.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      MAINTAINERS: Someone needs to watch over the serial drivers

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)
