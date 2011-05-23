From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/48] Char: nozomi, use GFP_KERNEL for kfifo allocation
Date: Mon, 23 May 2011 12:10:32 -0700
Message-ID: <1306177854-18172-26-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42066 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTLR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:17 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0E64B93987
	for <linux-serial@vger.kernel.org>; Mon, 23 May 2011 21:11:17 +0200 (CEST)
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

The allocation was moved to probe function in 9842c38e9176. And we can
sleep there. So allocate the 4*8192 bytes as GFP_KERNEL to mitigate
the allocation failure.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Gerald Pfeifer <gerald@pfeifer.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/nozomi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index fd0a9852..acaecc1 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1431,8 +1431,8 @@ static int __devinit nozomi_card_init(struct pci_dev *pdev,
 	}
 
 	for (i = PORT_MDM; i < MAX_PORT; i++) {
-		if (kfifo_alloc(&dc->port[i].fifo_ul,
-		      FIFO_BUFFER_SIZE_UL, GFP_ATOMIC)) {
+		if (kfifo_alloc(&dc->port[i].fifo_ul, FIFO_BUFFER_SIZE_UL,
+					GFP_KERNEL)) {
 			dev_err(&pdev->dev,
 					"Could not allocate kfifo buffer\n");
 			ret = -ENOMEM;
-- 
1.7.4.2

