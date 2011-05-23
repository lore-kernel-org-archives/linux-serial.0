From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/48] vt: remove uneeded retval check before tty->ops->open inside tty_open
Date: Mon, 23 May 2011 12:10:07 -0700
Message-ID: <1306177854-18172-1-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47252 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756215Ab1EWTJv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:09:51 -0400
In-Reply-To: <20110523190539.GA17519@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>

The current check is uneeded, since !retval will always returns true,
as retval returned from tty_add_file is checked earlier and tty_open
exits if it's not zero.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d7d50b4..188632e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1902,12 +1902,10 @@ got_driver:
 #ifdef TTY_DEBUG_HANGUP
 	printk(KERN_DEBUG "opening %s...", tty->name);
 #endif
-	if (!retval) {
-		if (tty->ops->open)
-			retval = tty->ops->open(tty, filp);
-		else
-			retval = -ENODEV;
-	}
+	if (tty->ops->open)
+		retval = tty->ops->open(tty, filp);
+	else
+		retval = -ENODEV;
 	filp->f_flags = saved_flags;
 
 	if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) &&
-- 
1.7.4.2

