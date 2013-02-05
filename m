From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 09/23] tty: Remove unnecessary buffer work flush
Date: Tue,  5 Feb 2013 15:20:24 -0500
Message-ID: <1360095638-6624-10-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

In order to safely call tty_ldisc_flush_works(), the ldisc must
already have been halted, so any pending buffer work has already
been cancelled or flushed as part of the halt.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 8d3eec1..7e26e7f 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -508,7 +508,6 @@ static void tty_ldisc_flush_works(struct tty_struct *tty)
 {
 	flush_work(&tty->hangup_work);
 	flush_work(&tty->SAK_work);
-	flush_work(&tty->port->buf.work);
 }
 
 /**
@@ -721,7 +720,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 	retval = tty_ldisc_halt(tty, o_tty, &work, &o_work, 5 * HZ);
 
 	/*
-	 * Wait for ->hangup_work and ->buf.work handlers to terminate.
+	 * Wait for ->hangup_work to terminate.
 	 * We must drop the mutex here in case a hangup is also in process.
 	 */
 
-- 
1.8.1.2
