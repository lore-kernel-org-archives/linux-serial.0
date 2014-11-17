From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH V2 2/5] i2c: pxa: prepare/unprepare clocks
Date: Mon, 17 Nov 2014 18:07:40 +0300
Message-ID: <1416236863-20898-2-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33660 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaKQPIE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2014 10:08:04 -0500
In-Reply-To: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unprepare().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index be671f7..2e75375 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1297,7 +1297,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 
 	return 0;
 }
@@ -1307,7 +1307,7 @@ static int i2c_pxa_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
-	clk_enable(i2c->clk);
+	clk_prepare_enable(i2c->clk);
 	i2c_pxa_reset(i2c);
 
 	return 0;
-- 
2.1.1

