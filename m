From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: sccnxp: Fix possible crash if no platform data supplied
Date: Thu, 17 Jan 2013 18:34:45 +0400
Message-ID: <1358433285-18790-1-git-send-email-shc_work@mail.ru>
References: <20130117065938.GF16282@mwanda>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback4.mail.ru ([94.100.176.42]:49336 "EHLO
	fallback4.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3AQPCV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jan 2013 10:02:21 -0500
Received: from smtp31.i.mail.ru (smtp31.i.mail.ru [94.100.177.91])
	by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id EB32914C2C8
	for <linux-serial@vger.kernel.org>; Thu, 17 Jan 2013 18:35:24 +0400 (MSK)
In-Reply-To: <20130117065938.GF16282@mwanda>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Alexander Shiyan <shc_work@mail.ru>

This patch fix possible kernel crash if no platform data supplied.
We should not use platform data in this case, instead we will use
default values from private driver structure.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 0c86a0b..3fd83e3 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -897,9 +897,9 @@ static int sccnxp_probe(struct platform_device *pdev)
 	} else
 		memcpy(&s->pdata, pdata, sizeof(struct sccnxp_pdata));
 
-	if (pdata->poll_time_us) {
+	if (s->pdata.poll_time_us) {
 		dev_info(&pdev->dev, "Using poll mode, resolution %u usecs\n",
-			 pdata->poll_time_us);
+			 s->pdata.poll_time_us);
 		s->poll = 1;
 	}
 
-- 
1.7.8.6

