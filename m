From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 29/48] Char: moxa, fix locking in moxa_write
Date: Mon, 23 May 2011 12:10:35 -0700
Message-ID: <1306177854-18172-29-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42073 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634Ab1EWTL1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:27 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

moxa_write can be called from atomic context with irqs disabled (from
ppp_async_push). Don't enable interrupts by spin_unlock_bh as this
might cause deadlocks in the ppp layer.

Instead, use irqsave/irqrestore spin_lock functions.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/moxa.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index a290e9e..6255561 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1202,14 +1202,15 @@ static int moxa_write(struct tty_struct *tty,
 		      const unsigned char *buf, int count)
 {
 	struct moxa_port *ch = tty->driver_data;
+	unsigned long flags;
 	int len;
 
 	if (ch == NULL)
 		return 0;
 
-	spin_lock_bh(&moxa_lock);
+	spin_lock_irqsave(&moxa_lock, flags);
 	len = MoxaPortWriteData(tty, buf, count);
-	spin_unlock_bh(&moxa_lock);
+	spin_unlock_irqrestore(&moxa_lock, flags);
 
 	set_bit(LOWWAIT, &ch->statusflags);
 	return len;
-- 
1.7.4.2

