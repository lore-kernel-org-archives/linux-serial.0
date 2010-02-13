From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 02/12] Serial: sc26xx fix build errors.
Date: Sat, 13 Feb 2010 17:09:56 +0100
Message-ID: <20100213160956.22311.29105.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0BMQJ6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:09:58 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:09:58 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

Add missing include.
Use __devexit rather than __exit to allow building in kernel.

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
 

