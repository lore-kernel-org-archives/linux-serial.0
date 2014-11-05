From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 14/26] tty: Fold pty pair handling into tty_flush_works()
Date: Wed,  5 Nov 2014 12:12:57 -0500
Message-ID: <1415207589-15967-15-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Perform work flush for both ends of a pty pair within tty_flush_works(),
rather than calling twice.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7b91007..563ab37 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1584,15 +1584,19 @@ void tty_free_termios(struct tty_struct *tty)
 EXPORT_SYMBOL(tty_free_termios);
 
 /**
- *	tty_flush_works		-	flush all works of a tty
- *	@tty: tty device to flush works for
+ *	tty_flush_works		-	flush all works of a tty/pty pair
+ *	@tty: tty device to flush works for (or either end of a pty pair)
  *
- *	Sync flush all works belonging to @tty.
+ *	Sync flush all works belonging to @tty (and the 'other' tty).
  */
 static void tty_flush_works(struct tty_struct *tty)
 {
 	flush_work(&tty->SAK_work);
 	flush_work(&tty->hangup_work);
+	if (tty->link) {
+		flush_work(&tty->link->SAK_work);
+		flush_work(&tty->link->hangup_work);
+	}
 }
 
 /**
@@ -1901,8 +1905,6 @@ int tty_release(struct inode *inode, struct file *filp)
 
 	/* Wait for pending work before tty destruction commmences */
 	tty_flush_works(tty);
-	if (o_tty)
-		tty_flush_works(o_tty);
 
 #ifdef TTY_DEBUG_HANGUP
 	printk(KERN_DEBUG "%s: %s: freeing structure...\n", __func__, tty_name(tty, buf));
-- 
2.1.3
