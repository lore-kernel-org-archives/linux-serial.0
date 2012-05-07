From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 3/9] serial: mxs-auart: adopt pinctrl support
Date: Mon,  7 May 2012 09:16:08 +0800
Message-ID: <1336353374-28939-4-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44353 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab2EGBQf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 May 2012 21:16:35 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so606413dad.19
        for <linux-serial@vger.kernel.org>; Sun, 06 May 2012 18:16:35 -0700 (PDT)
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/mxs-auart.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 55fd362..7081600 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/cacheflush.h>
 
@@ -678,6 +679,7 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 	u32 version;
 	int ret = 0;
 	struct resource *r;
+	struct pinctrl *pinctrl;
 
 	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
 	if (!s) {
@@ -685,6 +687,12 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto out_free;
+	}
+
 	s->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(s->clk)) {
 		ret = PTR_ERR(s->clk);
-- 
1.7.5.4

