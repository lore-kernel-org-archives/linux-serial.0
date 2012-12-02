From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] serial: xilinx_uartps: fix return value check in xuartps_probe()
Date: Sun, 2 Dec 2012 05:12:43 -0500
Message-ID: <CAPgLHd-upT_0ThHxU9rXtsw6CP4vU8zvOnLp6u0ZC_2unpDbTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40897 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab2LBKMo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Dec 2012 05:12:44 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1017598qcr.19
        for <linux-serial@vger.kernel.org>; Sun, 02 Dec 2012 02:12:43 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, function of_clk_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2be22a2..1eb4657 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -948,9 +948,9 @@ static int xuartps_probe(struct platform_device *pdev)
 	struct clk *clk;
 
 	clk = of_clk_get(pdev->dev.of_node, 0);
-	if (!clk) {
+	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "no clock specified\n");
-		return -ENODEV;
+		return PTR_ERR(clk);
 	}
 
 	rc = clk_prepare_enable(clk);


