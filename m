From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] serial: mxs-auart: Remove unneeded goto label
Date: Thu, 27 Nov 2014 17:08:30 -0200
Message-ID: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:55725 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaK0TIw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 14:08:52 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so4325840qcw.37
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2014 11:08:51 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j.uzycki@elproma.com.pl, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of jumping to the 'out' label, let's return the error immediately, which
makes the code shorter and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec553f8..a9e7fa6 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1232,10 +1232,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	struct resource *r;
 
 	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
-	if (!s) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!s)
+		return -ENOMEM;
 
 	ret = serial_mxs_probe_dt(s, pdev);
 	if (ret > 0)
@@ -1314,7 +1312,6 @@ out_free_clk:
 	clk_put(s->clk);
 out_free:
 	kfree(s);
-out:
 	return ret;
 }
 
-- 
1.9.1

