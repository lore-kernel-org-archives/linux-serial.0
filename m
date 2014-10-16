From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next] n_tty: Remove stale read lock comment
Date: Thu, 16 Oct 2014 15:36:38 -0400
Message-ID: <1413488198-13754-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:47091 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751477AbaJPTgx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 15:36:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

The stale comment refers to lock behavior which was eliminated in
commit 6d76bd2618535c581f1673047b8341fd291abc67,
n_tty: Make N_TTY ldisc receive path lockless.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 379f60c..38ac7b9 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2248,8 +2248,6 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 				nr--;
 			}
 
-			/* The copy function takes the read lock and handles
-			   locking internally for this case */
 			uncopied = copy_from_read_buf(tty, &b, &nr);
 			uncopied += copy_from_read_buf(tty, &b, &nr);
 			if (uncopied) {
-- 
2.1.1

