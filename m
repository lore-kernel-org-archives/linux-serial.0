From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 5/5] mfd: tc6387xb: prepare/unprepare clocks
Date: Mon, 17 Nov 2014 18:07:43 +0300
Message-ID: <1416236863-20898-5-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416236863-20898-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unprepare().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mfd/tc6387xb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index e71f880..85fab37 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -52,7 +52,7 @@ static int tc6387xb_suspend(struct platform_device *dev, pm_message_t state)
 
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
-	clk_disable(tc6387xb->clk32k);
+	clk_disable_unprepare(tc6387xb->clk32k);
 
 	return 0;
 }
@@ -62,7 +62,7 @@ static int tc6387xb_resume(struct platform_device *dev)
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
 	struct tc6387xb_platform_data *pdata = dev_get_platdata(&dev->dev);
 
-	clk_enable(tc6387xb->clk32k);
+	clk_prepare_enable(tc6387xb->clk32k);
 	if (pdata && pdata->resume)
 		pdata->resume(dev);
 
@@ -100,7 +100,7 @@ static int tc6387xb_mmc_enable(struct platform_device *mmc)
 	struct platform_device *dev      = to_platform_device(mmc->dev.parent);
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
 
-	clk_enable(tc6387xb->clk32k);
+	clk_prepare_enable(tc6387xb->clk32k);
 
 	tmio_core_mmc_enable(tc6387xb->scr + 0x200, 0,
 		tc6387xb_mmc_resources[0].start & 0xfffe);
@@ -113,7 +113,7 @@ static int tc6387xb_mmc_disable(struct platform_device *mmc)
 	struct platform_device *dev      = to_platform_device(mmc->dev.parent);
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
 
-	clk_disable(tc6387xb->clk32k);
+	clk_disable_unprepare(tc6387xb->clk32k);
 
 	return 0;
 }
@@ -214,7 +214,7 @@ static int tc6387xb_remove(struct platform_device *dev)
 	mfd_remove_devices(&dev->dev);
 	iounmap(tc6387xb->scr);
 	release_resource(&tc6387xb->rscr);
-	clk_disable(tc6387xb->clk32k);
+	clk_disable_unprepare(tc6387xb->clk32k);
 	clk_put(tc6387xb->clk32k);
 	kfree(tc6387xb);
 
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
