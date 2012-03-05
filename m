From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/68] XTENSA: iss/console, use setup_timer
Date: Mon,  5 Mar 2012 14:52:05 +0100
Message-ID: <1330955575-26641-19-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Chris Zankel <chris@zankel.net>
List-Id: linux-serial@vger.kernel.org

Use setup_timer instead of explicit assignments.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/xtensa/platforms/iss/console.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 19a802a..01842e4 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -69,11 +69,8 @@ static void rs_poll(unsigned long);
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
 	spin_lock(&timer_lock);
-
 	if (tty->count == 1) {
-		init_timer(&serial_timer);
-		serial_timer.data = (unsigned long) tty;
-		serial_timer.function = rs_poll;
+		setup_timer(&serial_timer, rs_poll, (unsigned long)tty);
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
 	}
 	spin_unlock(&timer_lock);
-- 
1.7.9.2
