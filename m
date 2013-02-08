From: George Spelvin <linux@horizon.com>
Subject: [PATCH v2 9/9] tty/tty_ldisc.c: use test_and_clear_bit in
 tty_ldisc_close
Date: Fri, 8 Feb 2013 01:50:18 -0500
Message-ID: <ba7ad5b9cd57cae807823676f5a386ca57e997fe.1360677367.git.linux@horizon.com>
References: <cover.1360677367.git.linux@horizon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1360677367.git.linux@horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, giometti@linux.it, linux@horizon.com
List-Id: linux-serial@vger.kernel.org

We have a function to test and clear a bit in one step, so use it.

Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/tty/tty_ldisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index c578229..4606ab9 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -453,8 +453,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
-	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
-	clear_bit(TTY_LDISC_OPEN, &tty->flags);
+	WARN_ON(!test_and_clear_bit(TTY_LDISC_OPEN, &tty->flags));
 	if (ld->ops->close)
 		ld->ops->close(tty);
 }
-- 
1.8.1.3
