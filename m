From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 70/79] TTY: pty, release tty in all ptmx_open fail paths
Date: Wed, 26 Oct 2011 14:13:15 +0200
Message-ID: <1319631204-23262-70-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32867 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932960Ab1JZMOC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:02 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, stable <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Mistakenly, commit 64ba3dc3143d (tty: never hold BTM while getting
tty_mutex) switched one fail path in ptmx_open to not free the newly
allocated tty.

Fix that by jumping to the appropriate place. And rename the labels so
that it's clear what is going on there.

Introduced-in: v2.6.36-rc2
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/pty.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 7613f95..2feea63 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -686,15 +686,15 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 
 	retval = devpts_pty_new(inode, tty->link);
 	if (retval)
-		goto out1;
+		goto err_release;
 
 	retval = ptm_driver->ops->open(tty, filp);
 	if (retval)
-		goto out2;
-out1:
+		goto err_release;
+
 	tty_unlock();
-	return retval;
-out2:
+	return 0;
+err_release:
 	tty_unlock();
 	tty_release(inode, filp);
 	return retval;
-- 
1.7.7

