From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/48] TTY: fix fail path in tty_open
Date: Mon, 23 May 2011 12:10:21 -0700
Message-ID: <1306177854-18172-15-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47289 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:39 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

When tty_add_file fails we omit to clean up. Fix that by calling
tty_release appropriatelly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8540f2b..55bb456 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1894,6 +1894,7 @@ got_driver:
 	retval = tty_add_file(tty, filp);
 	if (retval) {
 		tty_unlock();
+		tty_release(inode, filp);
 		return retval;
 	}
 
-- 
1.7.4.2

