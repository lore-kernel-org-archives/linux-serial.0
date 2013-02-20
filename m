From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 07/32] tty: Relocate tty_ldisc_halt() to avoid forward declaration
Date: Wed, 20 Feb 2013 15:02:54 -0500
Message-ID: <1361390599-15195-8-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_ldisc_halt() will use the file-scoped function, tty_ldisc_wait_idle(),
in the following patch.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 15667c0..f691c76 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -499,29 +499,6 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 }
 
 /**
- *	tty_ldisc_halt		-	shut down the line discipline
- *	@tty: tty device
- *
- *	Shut down the line discipline and work queue for this tty device.
- *	The TTY_LDISC flag being cleared ensures no further references can
- *	be obtained while the delayed work queue halt ensures that no more
- *	data is fed to the ldisc.
- *
- *	You need to do a 'flush_scheduled_work()' (outside the ldisc_mutex)
- *	in order to make sure any currently executing ldisc work is also
- *	flushed.
- */
-
-static int tty_ldisc_halt(struct tty_struct *tty)
-{
-	int scheduled;
-	clear_bit(TTY_LDISC, &tty->flags);
-	scheduled = cancel_work_sync(&tty->port->buf.work);
-	set_bit(TTY_LDISC_HALTED, &tty->flags);
-	return scheduled;
-}
-
-/**
  *	tty_ldisc_flush_works	-	flush all works of a tty
  *	@tty: tty device to flush works for
  *
@@ -551,6 +528,29 @@ static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
 }
 
 /**
+ *	tty_ldisc_halt		-	shut down the line discipline
+ *	@tty: tty device
+ *
+ *	Shut down the line discipline and work queue for this tty device.
+ *	The TTY_LDISC flag being cleared ensures no further references can
+ *	be obtained while the delayed work queue halt ensures that no more
+ *	data is fed to the ldisc.
+ *
+ *	You need to do a 'flush_scheduled_work()' (outside the ldisc_mutex)
+ *	in order to make sure any currently executing ldisc work is also
+ *	flushed.
+ */
+
+static int tty_ldisc_halt(struct tty_struct *tty)
+{
+	int scheduled;
+	clear_bit(TTY_LDISC, &tty->flags);
+	scheduled = cancel_work_sync(&tty->port->buf.work);
+	set_bit(TTY_LDISC_HALTED, &tty->flags);
+	return scheduled;
+}
+
+/**
  *	tty_ldisc_hangup_halt - halt the line discipline for hangup
  *	@tty: tty being hung up
  *
-- 
1.8.1.2
