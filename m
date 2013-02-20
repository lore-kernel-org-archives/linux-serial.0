From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 23/32] tty: Locate get/put ldisc functions together
Date: Wed, 20 Feb 2013 15:03:10 -0500
Message-ID: <1361390599-15195-24-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index f26ef1a..4e46c17 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -179,6 +179,29 @@ static struct tty_ldisc *tty_ldisc_get(int disc)
 	return ld;
 }
 
+/**
+ *	tty_ldisc_put		-	release the ldisc
+ *
+ *	Complement of tty_ldisc_get().
+ */
+static inline void tty_ldisc_put(struct tty_ldisc *ld)
+{
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
+}
+
 static void *tty_ldiscs_seq_start(struct seq_file *m, loff_t *pos)
 {
 	return (*pos < NR_LDISCS) ? pos : NULL;
@@ -329,29 +352,6 @@ void tty_ldisc_deref(struct tty_ldisc *ld)
 EXPORT_SYMBOL_GPL(tty_ldisc_deref);
 
 /**
- *	tty_ldisc_put		-	release the ldisc
- *
- *	Complement of tty_ldisc_get().
- */
-static inline void tty_ldisc_put(struct tty_ldisc *ld)
-{
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!ld))
-		return;
-
-	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
-
-	/* unreleased reader reference(s) will cause this WARN */
-	WARN_ON(!atomic_dec_and_test(&ld->users));
-
-	ld->ops->refcount--;
-	module_put(ld->ops->owner);
-	kfree(ld);
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
-}
-
-/**
  *	tty_ldisc_enable	-	allow ldisc use
  *	@tty: terminal to activate ldisc on
  *
-- 
1.8.1.2
