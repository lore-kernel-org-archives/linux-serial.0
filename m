From: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch] tty: Re-add external interface for tty_set_termios()
Date: Fri,  3 Apr 2015 12:03:15 +0200
Message-ID: <1428055395-10648-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is a partial revert of patch "tty: Remove external interface for
tty_set_termios()" from Peter Hurley (2015-01-25 SHA1 632f32e2107) to
set tty_set_termios() publicly available.

This will be needed by Bluetooth hci_uart module to be able to change
Bluetooth controller and local UART speed during vendor specific
initialization.

Signed-off-by: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/tty/tty_ioctl.c | 3 ++-
 include/linux/tty.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 632fc81..8e53fe4 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -536,7 +536,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *	Locking: termios_rwsem
  */
 
-static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
+int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
 	struct tty_ldisc *ld;
@@ -569,6 +569,7 @@ static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	up_write(&tty->termios_rwsem);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tty_set_termios);
 
 /**
  *	set_termios		-	set termios values for a tty
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 358a337..fe5623c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -491,6 +491,7 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(struct ktermios *a, struct ktermios *b);
+extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
-- 
1.9.1
