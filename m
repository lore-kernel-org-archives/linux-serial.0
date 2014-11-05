From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 16/26] tty: Simplify tty_release_checks() interface
Date: Wed,  5 Nov 2014 12:12:59 -0500
Message-ID: <1415207589-15967-17-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:52246 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbaKERtd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 12:49:33 -0500
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

Passing the 'other' tty to tty_release_checks() only makes sense
for a pty pair; make o_tty scope local instead.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 4034e5e..c765260 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1702,8 +1702,7 @@ static void release_tty(struct tty_struct *tty, int idx)
  *	Performs some paranoid checking before true release of the @tty.
  *	This is a no-op unless TTY_PARANOIA_CHECK is defined.
  */
-static int tty_release_checks(struct tty_struct *tty, struct tty_struct *o_tty,
-		int idx)
+static int tty_release_checks(struct tty_struct *tty, int idx)
 {
 #ifdef TTY_PARANOIA_CHECK
 	if (idx < 0 || idx >= tty->driver->num) {
@@ -1722,6 +1721,8 @@ static int tty_release_checks(struct tty_struct *tty, struct tty_struct *o_tty,
 		return -1;
 	}
 	if (tty->driver->other) {
+		struct tty_struct *o_tty = tty->link;
+
 		if (o_tty != tty->driver->other->ttys[idx]) {
 			printk(KERN_DEBUG "%s: other->table[%d] not o_tty for (%s)\n",
 					__func__, idx, tty->name);
@@ -1779,7 +1780,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	/* Review: parallel close */
 	o_tty = tty->link;
 
-	if (tty_release_checks(tty, o_tty, idx)) {
+	if (tty_release_checks(tty, idx)) {
 		tty_unlock(tty);
 		return 0;
 	}
-- 
2.1.3

