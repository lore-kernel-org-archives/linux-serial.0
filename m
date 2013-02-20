From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 21/32] tty: Document unsafe ldisc reference acquire
Date: Wed, 20 Feb 2013 15:03:08 -0500
Message-ID: <1361390599-15195-22-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Merge get_ldisc() into its only call site.
Note how, after merging, the unsafe acquire of an ldisc reference
is obvious.

   CPU 0 in tty_ldisc_try()         |  CPU 1 in tty_ldisc_halt()
                                    |
test_bit(TTY_LDISC, &tty_flags)     |
if (true)                           |  clear_bit(TTY_LDISC, &tty_flags)
  tty->ldisc != 0?                  |  atomic_read(&tty->ldisc->users)
  if (true)                         |  ret_val == 1?
    atomic_inc(&tty->ldisc->users)  |  if (false)
                                    |    wait
                                    |
<goes on assuming safe ldisc use>   |  <doesn't wait - proceeds w/ close>
                                    |

The spin lock in tty_ldisc_try() does nothing wrt synchronizing
the ldisc halt since it's not acquired as part of halting.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 9362a10..5ee0b2b 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -42,13 +42,6 @@ static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
 /* Line disc dispatch table */
 static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
-static inline struct tty_ldisc *get_ldisc(struct tty_ldisc *ld)
-{
-	if (ld)
-		atomic_inc(&ld->users);
-	return ld;
-}
-
 /**
  *	tty_register_ldisc	-	install a line discipline
  *	@disc: ldisc number
@@ -269,10 +262,13 @@ static struct tty_ldisc *tty_ldisc_try(struct tty_struct *tty)
 	unsigned long flags;
 	struct tty_ldisc *ld;
 
+	/* FIXME: this allows reference acquire after TTY_LDISC is cleared */
 	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	ld = NULL;
-	if (test_bit(TTY_LDISC, &tty->flags))
-		ld = get_ldisc(tty->ldisc);
+	if (test_bit(TTY_LDISC, &tty->flags) && tty->ldisc) {
+		ld = tty->ldisc;
+		atomic_inc(&ld->users);
+	}
 	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	return ld;
 }
-- 
1.8.1.2
