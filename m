From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/8] serial: max310x: Add missing mutex_destroy() on driver exit
Date: Mon, 10 Feb 2014 22:18:33 +0400
Message-ID: <1392056316-13844-5-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:53040 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbaBJSTQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:19:16 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id 17A6030E3A13
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:11 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2a12cbc..c180576 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1134,8 +1134,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
-	mutex_init(&s->mutex);
-
 	/* Check device to ensure we are talking to what we expect */
 	ret = devtype->detect(dev);
 	if (ret)
@@ -1193,6 +1191,8 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		goto out_uart;
 #endif
 
+	mutex_init(&s->mutex);
+
 	for (i = 0; i < devtype->nr; i++) {
 		/* Initialize port data */
 		s->p[i].port.line	= i;
@@ -1233,6 +1233,8 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 
 	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
 
+	mutex_destroy(&s->mutex);
+
 #ifdef CONFIG_GPIOLIB
 	WARN_ON(gpiochip_remove(&s->gpio));
 #endif
@@ -1264,6 +1266,7 @@ static int max310x_remove(struct device *dev)
 		s->devtype->power(&s->p[i].port, 0);
 	}
 
+	mutex_destroy(&s->mutex);
 	uart_unregister_driver(&s->uart);
 	clk_disable_unprepare(s->clk);
 
-- 
1.8.3.2

