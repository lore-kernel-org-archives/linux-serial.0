From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 13/32] tty: Don't reenable already enabled ldisc
Date: Wed, 20 Feb 2013 15:03:00 -0500
Message-ID: <1361390599-15195-14-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_ldisc_hangup() guarantees the ldisc is enabled (or that there
is no ldisc). Since __tty_hangup() was the only user, re-define
tty_ldisc_enable() in file-scope.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c    | 1 -
 drivers/tty/tty_ldisc.c | 2 +-
 include/linux/tty.h     | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8f44d62..4f8a06e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -666,7 +666,6 @@ static void __tty_hangup(struct tty_struct *tty)
 	 */
 	set_bit(TTY_HUPPED, &tty->flags);
 	clear_bit(TTY_HUPPING, &tty->flags);
-	tty_ldisc_enable(tty);
 
 	tty_unlock(tty);
 
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 37671fcc..9c727da 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -373,7 +373,7 @@ static inline void tty_ldisc_put(struct tty_ldisc *ld)
  *	Clearing directly is allowed.
  */
 
-void tty_ldisc_enable(struct tty_struct *tty)
+static void tty_ldisc_enable(struct tty_struct *tty)
 {
 	clear_bit(TTY_LDISC_HALTED, &tty->flags);
 	set_bit(TTY_LDISC, &tty->flags);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7aa4be6..bfa6fca 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -527,8 +527,6 @@ extern void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern void tty_ldisc_begin(void);
-/* This last one is just for the tty layer internals and shouldn't be used elsewhere */
-extern void tty_ldisc_enable(struct tty_struct *tty);
 
 
 /* n_tty.c */
-- 
1.8.1.2
