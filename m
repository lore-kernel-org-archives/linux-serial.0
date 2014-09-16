From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] tty: sc16is7xx: remove retval from gpiochip_remove()
Date: Tue, 16 Sep 2014 15:16:55 -0700
Message-ID: <1410905815-22970-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48773 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbaIPWRC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Sep 2014 18:17:02 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so683320pdj.22
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2014 15:17:01 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

We are trying to smoke out the use of the return value from
gpiochip_remove() from the kernel, this has been missed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Greg, can you ACK this so I can merge it into the GPIO tree along
with the removal of the actual return value.
---
 drivers/tty/serial/sc16is7xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3284c31085a7..b534396b9568 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1157,7 +1157,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio)
-		WARN_ON(gpiochip_remove(&s->gpio));
+		gpiochip_remove(&s->gpio);
 
 out_uart:
 #endif
@@ -1176,11 +1176,8 @@ static int sc16is7xx_remove(struct device *dev)
 	int i, ret = 0;
 
 #ifdef CONFIG_GPIOLIB
-	if (s->devtype->nr_gpio) {
-		ret = gpiochip_remove(&s->gpio);
-		if (ret)
-			return ret;
-	}
+	if (s->devtype->nr_gpio)
+		gpiochip_remove(&s->gpio);
 #endif
 
 	for (i = 0; i < s->uart.nr; i++) {
-- 
1.9.3

