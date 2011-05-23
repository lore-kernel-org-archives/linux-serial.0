From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/48] Char: cyclades, fix unused variable
Date: Mon, 23 May 2011 12:10:12 -0700
Message-ID: <1306177854-18172-6-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47263 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573Ab1EWTKI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:08 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id DB4368F54B
	for <linux-serial@vger.kernel.org>; Mon, 23 May 2011 21:10:07 +0200 (CEST)
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

drivers/tty/cyclades.c:1454:2: warning: Value stored to 'channel' is never read
	channel = info->line - card->first_line;
	^         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by moving it to the appropriate debug section where it is used.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/cyclades.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index c99728f..e6f20d2 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1445,13 +1445,11 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 {
 	struct cyclades_card *card;
 	unsigned long flags;
-	int channel;
 
 	if (!(info->port.flags & ASYNC_INITIALIZED))
 		return;
 
 	card = info->card;
-	channel = info->line - card->first_line;
 	if (!cy_is_Z(card)) {
 		spin_lock_irqsave(&card->card_lock, flags);
 
@@ -1476,6 +1474,7 @@ static void cy_shutdown(struct cyclades_port *info, struct tty_struct *tty)
 		spin_unlock_irqrestore(&card->card_lock, flags);
 	} else {
 #ifdef CY_DEBUG_OPEN
+		int channel = info->line - card->first_line;
 		printk(KERN_DEBUG "cyc shutdown Z card %d, channel %d, "
 			"base_addr %p\n", card, channel, card->base_addr);
 #endif
-- 
1.7.4.2

