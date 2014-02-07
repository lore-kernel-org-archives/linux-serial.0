From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/6] serial: max310x: Remove init() and exit() callbacks
Date: Fri,  7 Feb 2014 18:16:05 +0400
Message-ID: <1391782568-19442-4-git-send-email-shc_work@mail.ru>
References: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.176.18]:59561 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbaBGOQk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:16:40 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id 95ED333A7EF7
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:38 +0400 (MSK)
In-Reply-To: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

These callbacks were previously used for the IC power initialization.
If this initialization will be needed in the future, it should be
implemented with the regulator API.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c          | 7 -------
 include/linux/platform_data/max310x.h | 4 ----
 2 files changed, 11 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 313bdf0..202c1fb 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1135,10 +1135,6 @@ static int max310x_probe(struct device *dev, int is_spi,
 		return PTR_ERR(s->regmap);
 	}
 
-	/* Board specific configure */
-	if (s->pdata->init)
-		s->pdata->init();
-
 	/* Check device to ensure we are talking to what we expect */
 	ret = devtype->detect(dev);
 	if (ret)
@@ -1265,9 +1261,6 @@ static int max310x_remove(struct device *dev)
 		ret = gpiochip_remove(&s->gpio);
 #endif
 
-	if (s->pdata->exit)
-		s->pdata->exit();
-
 	return ret;
 }
 
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index dd11dcd..5f4b35d 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -55,10 +55,6 @@ struct max310x_pdata {
 	const int		frequency;
 	/* GPIO base number (can be negative) */
 	const int		gpio_base;
-	/* Called during startup */
-	void (*init)(void);
-	/* Called before finish */
-	void (*exit)(void);
 };
 
 #endif
-- 
1.8.3.2

