From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 24/27] tty: Prefix tty_ldisc_{lock,lock_nested,unlock} functions
Date: Thu, 16 Oct 2014 16:25:22 -0400
Message-ID: <1413491125-20134-25-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_ldisc_lock(), tty_ldisc_unlock(), and tty_ldisc_lock_nested()
are low-level aliases for the underlying lock mechanism. Rename
with double underscore to allow for new, higher level functions
with those names.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 1c4d7b6..5bdc241 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -308,19 +308,19 @@ EXPORT_SYMBOL_GPL(tty_ldisc_deref);
 
 
 static inline int __lockfunc
-tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
+__tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
 {
 	return ldsem_down_write(&tty->ldisc_sem, timeout);
 }
 
 static inline int __lockfunc
-tty_ldisc_lock_nested(struct tty_struct *tty, unsigned long timeout)
+__tty_ldisc_lock_nested(struct tty_struct *tty, unsigned long timeout)
 {
 	return ldsem_down_write_nested(&tty->ldisc_sem,
 				       LDISC_SEM_OTHER, timeout);
 }
 
-static inline void tty_ldisc_unlock(struct tty_struct *tty)
+static inline void __tty_ldisc_unlock(struct tty_struct *tty)
 {
 	return ldsem_up_write(&tty->ldisc_sem);
 }
@@ -332,24 +332,24 @@ tty_ldisc_lock_pair_timeout(struct tty_struct *tty, struct tty_struct *tty2,
 	int ret;
 
 	if (tty < tty2) {
-		ret = tty_ldisc_lock(tty, timeout);
+		ret = __tty_ldisc_lock(tty, timeout);
 		if (ret) {
-			ret = tty_ldisc_lock_nested(tty2, timeout);
+			ret = __tty_ldisc_lock_nested(tty2, timeout);
 			if (!ret)
-				tty_ldisc_unlock(tty);
+				__tty_ldisc_unlock(tty);
 		}
 	} else {
 		/* if this is possible, it has lots of implications */
 		WARN_ON_ONCE(tty == tty2);
 		if (tty2 && tty != tty2) {
-			ret = tty_ldisc_lock(tty2, timeout);
+			ret = __tty_ldisc_lock(tty2, timeout);
 			if (ret) {
-				ret = tty_ldisc_lock_nested(tty, timeout);
+				ret = __tty_ldisc_lock_nested(tty, timeout);
 				if (!ret)
-					tty_ldisc_unlock(tty2);
+					__tty_ldisc_unlock(tty2);
 			}
 		} else
-			ret = tty_ldisc_lock(tty, timeout);
+			ret = __tty_ldisc_lock(tty, timeout);
 	}
 
 	if (!ret)
@@ -370,9 +370,9 @@ tty_ldisc_lock_pair(struct tty_struct *tty, struct tty_struct *tty2)
 static void __lockfunc tty_ldisc_unlock_pair(struct tty_struct *tty,
 					     struct tty_struct *tty2)
 {
-	tty_ldisc_unlock(tty);
+	__tty_ldisc_unlock(tty);
 	if (tty2)
-		tty_ldisc_unlock(tty2);
+		__tty_ldisc_unlock(tty2);
 }
 
 static void __lockfunc tty_ldisc_enable_pair(struct tty_struct *tty,
-- 
2.1.1
