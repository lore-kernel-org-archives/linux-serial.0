From: John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 09/14] SERIAL: MIPS: lantiq: convert serial driver to clkdev api
Date: Thu, 23 Feb 2012 17:03:08 +0100
Message-ID: <1330012993-13510-9-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:42867 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab2BWQDg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Feb 2012 11:03:36 -0500
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>, linux-serial@vger.kernel.org

Reference the FPI clock via its new access function.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/lantiq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 96c1cac..99fb70f 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -686,7 +686,7 @@ lqasc_probe(struct platform_device *pdev)
 	if (lqasc_port[pdev->id] != NULL)
 		return -EBUSY;
 
-	clk = clk_get(&pdev->dev, "fpi");
+	clk = clk_get_fpi();
 	if (IS_ERR(clk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
-- 
1.7.7.1

