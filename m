From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 6/6] serial: max310x: Remove IRQ validation
Date: Fri,  7 Feb 2014 18:16:08 +0400
Message-ID: <1391782568-19442-7-git-send-email-shc_work@mail.ru>
References: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:37325 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbaBGOQj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:16:39 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 76C86F7E21ED
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:38 +0400 (MSK)
In-Reply-To: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch removes excess IRQ checks at driver probe().
IRQ validation is already provided by request_threaded_irq().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3c93814..ac1d54c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1081,12 +1081,6 @@ static int max310x_probe(struct device *dev, int is_spi,
 	struct max310x_pdata *pdata = dev_get_platdata(dev);
 	int i, ret, uartclk;
 
-	/* Check for IRQ */
-	if (irq <= 0) {
-		dev_err(dev, "No IRQ specified\n");
-		return -ENOTSUPP;
-	}
-
 	if (!pdata) {
 		dev_err(dev, "No platform data supplied\n");
 		return -EINVAL;
-- 
1.8.3.2

