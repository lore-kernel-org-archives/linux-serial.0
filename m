From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] tty: of_serial: fix return value check in of_platform_serial_setup()
Date: Thu, 1 Nov 2012 13:27:34 +0800
Message-ID: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33368 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab2KAF1f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 01:27:35 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so32347qad.19
        for <linux-serial@vger.kernel.org>; Wed, 31 Oct 2012 22:27:34 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, seth.heasley@intel.com
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/of_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 533ccfe..b9fdccb 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -66,10 +66,10 @@ static int __devinit of_platform_serial_setup(struct platform_device *ofdev,
 
 		/* Get clk rate through clk driver if present */
 		info->clk = clk_get(&ofdev->dev, NULL);
-		if (info->clk == NULL) {
+		if (IS_ERR(info->clk)) {
 			dev_warn(&ofdev->dev,
 				"clk or clock-frequency not defined\n");
-			return -ENODEV;
+			return PTR_ERR(info->clk);
 		}
 
 		clk_prepare_enable(info->clk);


