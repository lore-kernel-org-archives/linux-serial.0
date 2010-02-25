From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH V2 02/14] Serial: sc26xx fix build errors.
Date: Thu, 25 Feb 2010 14:35:00 +0100
Message-ID: <20100225133459.12331.35614.stgit@srv002.fuzzey.net>
References: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f212.google.com ([209.85.219.212]:34503 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504Ab0BYNfI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 08:35:08 -0500
Received: by mail-ew0-f212.google.com with SMTP id 4so1510191ewy.28
        for <linux-serial@vger.kernel.org>; Thu, 25 Feb 2010 05:35:08 -0800 (PST)
In-Reply-To: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de

Add missing include.
Use __devexit rather than __exit to allow building in kernel.

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 75038ad..dc09682 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
+#include <linux/io.h>
 
 #if defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -709,7 +710,7 @@ out_free_port:
 }
 
 
-static int __exit sc26xx_driver_remove(struct platform_device *dev)
+static int __devexit sc26xx_driver_remove(struct platform_device *dev)
 {
 	struct uart_sc26xx_port *up = dev_get_drvdata(&dev->dev);
 

