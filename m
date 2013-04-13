From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: sccnxp: Replace pdata.init/exit with regulator API
Date: Sat, 13 Apr 2013 08:46:58 +0400
Message-ID: <1365828418-1920-2-git-send-email-shc_work@mail.ru>
References: <1365828418-1920-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp3.mail.ru ([94.100.176.131]:52958 "EHLO smtp3.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab3DMErH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 00:47:07 -0400
In-Reply-To: <1365828418-1920-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Typical usage of pdata.init/exit is enable/disable power and/or toggle
reset for the target chip.
This patch replaces these callbacks with regulator API.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c                 | 21 +++++++++++++++------
 include/linux/platform_data/serial-sccnxp.h |  4 ----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index b1d04aa..c773041 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/serial-sccnxp.h>
+#include <linux/regulator/consumer.h>
 
 #define SCCNXP_NAME			"uart-sccnxp"
 #define SCCNXP_MAJOR			204
@@ -131,6 +132,8 @@ struct sccnxp_port {
 	struct timer_list	timer;
 
 	struct sccnxp_pdata	pdata;
+
+	struct regulator	*regulator;
 };
 
 static inline u8 sccnxp_raw_read(void __iomem *base, u8 reg, u8 shift)
@@ -916,6 +919,16 @@ static int sccnxp_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	s->regulator = devm_regulator_get(&pdev->dev, "VCC");
+	if (!IS_ERR(s->regulator)) {
+		ret = regulator_enable(s->regulator);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable regulator: %i\n", ret);
+			return ret;
+		}
+	}
+
 	membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(membase)) {
 		ret = PTR_ERR(membase);
@@ -965,10 +978,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 	s->imr = 0;
 	sccnxp_write(&s->port[0], SCCNXP_IMR_REG, 0);
 
-	/* Board specific configure */
-	if (s->pdata.init)
-		s->pdata.init();
-
 	if (!s->poll) {
 		ret = devm_request_threaded_irq(&pdev->dev, s->irq, NULL,
 						sccnxp_ist,
@@ -1009,8 +1018,8 @@ static int sccnxp_remove(struct platform_device *pdev)
 	uart_unregister_driver(&s->uart);
 	platform_set_drvdata(pdev, NULL);
 
-	if (s->pdata.exit)
-		s->pdata.exit();
+	if (!IS_ERR(s->regulator))
+		return regulator_disable(s->regulator);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/serial-sccnxp.h b/include/linux/platform_data/serial-sccnxp.h
index 215574d..bdc510d 100644
--- a/include/linux/platform_data/serial-sccnxp.h
+++ b/include/linux/platform_data/serial-sccnxp.h
@@ -86,10 +86,6 @@ struct sccnxp_pdata {
 	const u32		mctrl_cfg[SCCNXP_MAX_UARTS];
 	/* Timer value for polling mode (usecs) */
 	const unsigned int	poll_time_us;
-	/* Called during startup */
-	void (*init)(void);
-	/* Called before finish */
-	void (*exit)(void);
 };
 
 #endif
-- 
1.8.1.5

