From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 34/44] tty: Fix tty_ldisc_lock name collision
Date: Mon, 11 Mar 2013 16:44:54 -0400
Message-ID: <1363034704-28036-35-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 9725c94..ba49c0e 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -44,7 +44,7 @@ enum {
  *	callers who will do ldisc lookups and cannot sleep.
  */
 
-static DEFINE_RAW_SPINLOCK(tty_ldisc_lock);
+static DEFINE_RAW_SPINLOCK(tty_ldiscs_lock);
 /* Line disc dispatch table */
 static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
@@ -58,7 +58,7 @@ static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
  *	from this point onwards.
  *
  *	Locking:
- *		takes tty_ldisc_lock to guard against ldisc races
+ *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
 int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
@@ -69,11 +69,11 @@ int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	tty_ldiscs[disc] = new_ldisc;
 	new_ldisc->num = disc;
 	new_ldisc->refcount = 0;
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
 	return ret;
 }
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(tty_register_ldisc);
  *	currently in use.
  *
  *	Locking:
- *		takes tty_ldisc_lock to guard against ldisc races
+ *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
 int tty_unregister_ldisc(int disc)
@@ -99,12 +99,12 @@ int tty_unregister_ldisc(int disc)
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	if (tty_ldiscs[disc]->refcount)
 		ret = -EBUSY;
 	else
 		tty_ldiscs[disc] = NULL;
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
 	return ret;
 }
@@ -115,7 +115,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 	unsigned long flags;
 	struct tty_ldisc_ops *ldops, *ret;
 
-	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	ret = ERR_PTR(-EINVAL);
 	ldops = tty_ldiscs[disc];
 	if (ldops) {
@@ -125,7 +125,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 			ret = ldops;
 		}
 	}
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 	return ret;
 }
 
@@ -133,10 +133,10 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 {
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	ldops->refcount--;
 	module_put(ldops->owner);
-	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 }
 
 /**
@@ -149,7 +149,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  *	available
  *
  *	Locking:
- *		takes tty_ldisc_lock to guard against ldisc races
+ *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
-- 
1.8.1.2
