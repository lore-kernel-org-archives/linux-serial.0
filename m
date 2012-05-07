From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 1/5] tty: serial: imx: adopt pinctrl support
Date: Mon,  7 May 2012 08:53:56 +0800
Message-ID: <1336352040-28447-2-git-send-email-shawn.guo@linaro.org>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33196 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab2EGAxw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 May 2012 20:53:52 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so591064dad.19
        for <linux-serial@vger.kernel.org>; Sun, 06 May 2012 17:53:52 -0700 (PDT)
In-Reply-To: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <dong.aisheng@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7fecee..ec20673 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -47,6 +47,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1464,6 +1465,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret = 0;
 	struct resource *res;
+	struct pinctrl *pinctrl;
 
 	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
 	if (!sport)
@@ -1503,6 +1505,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->timer.function = imx_timeout;
 	sport->timer.data     = (unsigned long)sport;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto unmap;
+	}
+
 	sport->clk = clk_get(&pdev->dev, "uart");
 	if (IS_ERR(sport->clk)) {
 		ret = PTR_ERR(sport->clk);
-- 
1.7.5.4

