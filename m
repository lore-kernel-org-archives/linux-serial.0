From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/5] serial: imx: Fix coding style issue
Date: Mon,  7 Jan 2013 10:25:04 +0530
Message-ID: <1357534506-30206-4-git-send-email-sachin.kamat@linaro.org>
References: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:46045 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab3AGFD1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 00:03:27 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so10383498pbb.29
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 21:03:26 -0800 (PST)
In-Reply-To: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, s.hauer@pengutronix.de, sachin.kamat@linaro.org, patches@linaro.org

Silences the following checkpatch error:
ERROR: that open brace { should be on the previous line

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/imx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 426253c..9bec8a2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -491,8 +491,7 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-	if (sport->port.x_char)
-	{
+	if (sport->port.x_char) {
 		/* Send next char */
 		writel(sport->port.x_char, sport->port.membase + URTX0);
 		goto out;
-- 
1.7.4.1

