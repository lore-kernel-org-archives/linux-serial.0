From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: max310x: Setup missing "can_sleep" field for GPIO
Date: Thu, 22 Nov 2012 00:07:32 +0400
Message-ID: <1353528452-27801-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:46304 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783Ab2KUUo6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 15:44:58 -0500
Received: from smtp36.i.mail.ru (smtp36.i.mail.ru [94.100.177.96])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 19D11BCEFF18
	for <linux-serial@vger.kernel.org>; Thu, 22 Nov 2012 00:07:59 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 1ab1d2c..343becb 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1178,6 +1178,7 @@ static int __devinit max310x_probe(struct spi_device *spi)
 		s->gpio.set		= max310x_gpio_set;
 		s->gpio.base		= pdata->gpio_base;
 		s->gpio.ngpio		= s->nr_gpio;
+		s->gpio.can_sleep	= 1;
 		if (gpiochip_add(&s->gpio)) {
 			/* Indicate that we should not call gpiochip_remove */
 			s->gpio.base = 0;
-- 
1.7.8.6

