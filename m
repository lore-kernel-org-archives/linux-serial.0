From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 71/79] TTY: call tty_driver_lookup_tty unconditionally
Date: Wed, 26 Oct 2011 14:13:16 +0200
Message-ID: <1319631204-23262-71-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32871 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932966Ab1JZMOC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:02 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, stable <stable@vger.kernel.org>, Sukadev Bhattiprolu <sukadev@us.ibm.com>, Alan Cox <alan@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Commit 4a2b5fddd5 (Move tty lookup/reopen to caller) made the call to
tty_driver_lookup_tty conditional in tty_open. It doesn't look like it
was an intention. Or if it was, it was not documented in the changelog
and the code now looks weird. For example there would be no need to
remember the tty driver and tty index. Further the condition depends
on a tty which we drop a reference of already.

If I'm looking correctly, this should not matter thanks to the locking
currently done there. Thus, tty_driver->ttys[idx] cannot change under
our hands. But anyway, it makes sense to change that to the old
behaviour.

Introduced-in: v2.6.28-rc2
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 767ecbb..0425170 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1821,7 +1821,7 @@ int tty_release(struct inode *inode, struct file *filp)
 
 static int tty_open(struct inode *inode, struct file *filp)
 {
-	struct tty_struct *tty = NULL;
+	struct tty_struct *tty;
 	int noctty, retval;
 	struct tty_driver *driver;
 	int index;
@@ -1892,17 +1892,14 @@ retry_open:
 		return -ENODEV;
 	}
 got_driver:
-	if (!tty) {
-		/* check whether we're reopening an existing tty */
-		tty = tty_driver_lookup_tty(driver, inode, index);
-
-		if (IS_ERR(tty)) {
-			tty_unlock();
-			mutex_unlock(&tty_mutex);
-			tty_driver_kref_put(driver);
-			tty_free_file(filp);
-			return PTR_ERR(tty);
-		}
+	/* check whether we're reopening an existing tty */
+	tty = tty_driver_lookup_tty(driver, inode, index);
+	if (IS_ERR(tty)) {
+		tty_unlock();
+		mutex_unlock(&tty_mutex);
+		tty_driver_kref_put(driver);
+		tty_free_file(filp);
+		return PTR_ERR(tty);
 	}
 
 	if (tty) {
-- 
1.7.7

