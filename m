From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 20/32] tty: Separate release semantics of ldisc reference
Date: Wed, 20 Feb 2013 15:03:07 -0500
Message-ID: <1361390599-15195-21-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_ldisc_ref()/tty_ldisc_unref() have usage semantics
equivalent to down_read_trylock()/up_read(). Only
callers of tty_ldisc_put() are performing the additional
operations necessary for proper ldisc teardown, and then only
after ensuring no outstanding 'read lock' remains.

Thus, tty_ldisc_unref() should never be the last reference;
WARN if it is. Conversely, tty_ldisc_put() should never be
destructing if the use count != 1.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 69 +++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 328ff5b..9362a10 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -49,37 +49,6 @@ static inline struct tty_ldisc *get_ldisc(struct tty_ldisc *ld)
 	return ld;
 }
 
-static void put_ldisc(struct tty_ldisc *ld)
-{
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!ld))
-		return;
-
-	/*
-	 * If this is the last user, free the ldisc, and
-	 * release the ldisc ops.
-	 *
-	 * We really want an "atomic_dec_and_raw_lock_irqsave()",
-	 * but we don't have it, so this does it by hand.
-	 */
-	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
-	if (atomic_dec_and_test(&ld->users)) {
-		struct tty_ldisc_ops *ldo = ld->ops;
-
-		ldo->refcount--;
-		module_put(ldo->owner);
-		raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
-
-		kfree(ld);
-		return;
-	}
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
-
-	if (waitqueue_active(&ld->wq_idle))
-		wake_up(&ld->wq_idle);
-}
-
 /**
  *	tty_register_ldisc	-	install a line discipline
  *	@disc: ldisc number
@@ -363,13 +332,45 @@ EXPORT_SYMBOL_GPL(tty_ldisc_ref);
 
 void tty_ldisc_deref(struct tty_ldisc *ld)
 {
-	put_ldisc(ld);
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(!ld))
+		return;
+
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+	/*
+	 * WARNs if one-too-many reader references were released
+	 * - the last reference must be released with tty_ldisc_put
+	 */
+	WARN_ON(atomic_dec_and_test(&ld->users));
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+
+	if (waitqueue_active(&ld->wq_idle))
+		wake_up(&ld->wq_idle);
 }
 EXPORT_SYMBOL_GPL(tty_ldisc_deref);
 
+/**
+ *	tty_ldisc_put		-	release the ldisc
+ *
+ *	Complement of tty_ldisc_get().
+ */
 static inline void tty_ldisc_put(struct tty_ldisc *ld)
 {
-	put_ldisc(ld);
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(!ld))
+		return;
+
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+
+	/* unreleased reader reference(s) will cause this WARN */
+	WARN_ON(!atomic_dec_and_test(&ld->users));
+
+	ld->ops->refcount--;
+	module_put(ld->ops->owner);
+	kfree(ld);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 }
 
 /**
@@ -1001,7 +1002,7 @@ void tty_ldisc_init(struct tty_struct *tty)
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
-	put_ldisc(tty->ldisc);
+	tty_ldisc_put(tty->ldisc);
 	tty_ldisc_assign(tty, NULL);
 }
 
-- 
1.8.1.2
