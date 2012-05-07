From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 2/9] serial: amba-pl011: adopt pinctrl support
Date: Mon,  7 May 2012 09:16:07 +0800
Message-ID: <1336353374-28939-3-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44353 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab2EGBQa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 May 2012 21:16:30 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so606413dad.19
        for <linux-serial@vger.kernel.org>; Sun, 06 May 2012 18:16:29 -0700 (PDT)
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3d569cd..062ef8c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -52,6 +52,7 @@
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -1916,6 +1917,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct uart_amba_port *uap;
 	struct vendor_data *vendor = id->data;
+	struct pinctrl *pinctrl;
 	void __iomem *base;
 	int i, ret;
 
@@ -1940,6 +1942,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto free;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&dev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		goto unmap;
+	}
+
 	uap->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(uap->clk)) {
 		ret = PTR_ERR(uap->clk);
-- 
1.7.5.4

