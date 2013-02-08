From: George Spelvin <linux@horizon.com>
Subject: [PATCH 7/7] tty/tty_ldisc.c: use test_and_clear_bit in
 tty_ldisc_close
Date: Fri, 8 Feb 2013 01:50:18 -0500
Message-ID: <faa581736ab4fb46db012cdc42abccaa0bcc16a5.1360307140.git.linux@horizon.com>
References: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36262 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946111Ab3BHJQh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:37 -0500
In-Reply-To: <cover.1360307140.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

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
1.8.1.2

