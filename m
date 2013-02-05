From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 20/23] tty: Remove stale comment re: locking in tty_ldisc_release()
Date: Tue,  5 Feb 2013 15:20:35 -0500
Message-ID: <1360095638-6624-21-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

This comment pre-dates the obvious locking used in the function;
delete it.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index d7ebe79..92629c1 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -968,7 +968,7 @@ void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty)
 	tty_ldisc_halt(tty, o_tty, NULL, NULL, MAX_SCHEDULE_TIMEOUT);
 
 	tty_lock_pair(tty, o_tty);
-	/* This will need doing differently if we need to lock */
+
 	tty_ldisc_kill(tty);
 	if (o_tty)
 		tty_ldisc_kill(o_tty);
-- 
1.8.1.2
