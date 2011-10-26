From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 77/79] Revert "TTY: call tty_driver_lookup_tty unconditionally"
Date: Wed, 26 Oct 2011 14:13:22 +0200
Message-ID: <1319631204-23262-77-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32886 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975Ab1JZMOF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:05 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jiri Slaby <jslaby@suse.cz>, stable <stable@vger.kernel.org>, Sukadev Bhattiprolu <sukadev@us.ibm.com>, Alan Cox <alan@redhat.com>

This reverts commit 631180aca723cb92e128fdac5fd144e913ca84e5.

It caused problems when /dev/tty is a pty:
	https://lkml.org/lkml/2011/10/12/401

Cc: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0425170..767ecbb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1821,7 +1821,7 @@ int tty_release(struct inode *inode, struct file *filp)
 
 static int tty_open(struct inode *inode, struct file *filp)
 {
-	struct tty_struct *tty;
+	struct tty_struct *tty = NULL;
 	int noctty, retval;
 	struct tty_driver *driver;
 	int index;
@@ -1892,14 +1892,17 @@ retry_open:
 		return -ENODEV;
 	}
 got_driver:
-	/* check whether we're reopening an existing tty */
-	tty = tty_driver_lookup_tty(driver, inode, index);
-	if (IS_ERR(tty)) {
-		tty_unlock();
-		mutex_unlock(&tty_mutex);
-		tty_driver_kref_put(driver);
-		tty_free_file(filp);
-		return PTR_ERR(tty);
+	if (!tty) {
+		/* check whether we're reopening an existing tty */
+		tty = tty_driver_lookup_tty(driver, inode, index);
+
+		if (IS_ERR(tty)) {
+			tty_unlock();
+			mutex_unlock(&tty_mutex);
+			tty_driver_kref_put(driver);
+			tty_free_file(filp);
+			return PTR_ERR(tty);
+		}
 	}
 
 	if (tty) {
-- 
1.7.7

