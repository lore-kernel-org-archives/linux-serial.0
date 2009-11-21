From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [RFC PATCH 2/9] Serial: sc26xx fix build errors.
Date: Sat, 21 Nov 2009 14:39:59 +0100
Message-ID: <20091121133959.16090.39414.stgit@srv002.fuzzey.net>
References: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41031 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbZKUNj4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Nov 2009 08:39:56 -0500
In-Reply-To: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: tsbogend@alpha.franken.de, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

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
 

