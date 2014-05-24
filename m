From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: sccnxp: Remove useless timer_pending() check
Date: Sat, 24 May 2014 12:50:26 +0400
Message-ID: <1400921427-17365-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.181.169]:44556 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaEXI5S (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 24 May 2014 04:57:18 -0400
Received: from smtp9.mail.ru (smtp9.mail.ru [94.100.181.97])
	by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id 3B8E733287D0
	for <linux-serial@vger.kernel.org>; Sat, 24 May 2014 12:50:54 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

sccnxp_timer() is triggered only by timer, so there are no need to
check for timer_pending().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index a447f71..3f5d40a 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -474,9 +474,7 @@ static void sccnxp_timer(unsigned long data)
 	sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
 
-	if (!timer_pending(&s->timer))
-		mod_timer(&s->timer, jiffies +
-			  usecs_to_jiffies(s->pdata.poll_time_us));
+	mod_timer(&s->timer, jiffies + usecs_to_jiffies(s->pdata.poll_time_us));
 }
 
 static irqreturn_t sccnxp_ist(int irq, void *dev_id)
-- 
1.8.5.5

