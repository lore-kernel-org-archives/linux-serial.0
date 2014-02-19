From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/4] tty: serial: bcm63xx_uart: include linux/io.h
Date: Wed, 19 Feb 2014 15:22:44 -0800
Message-ID: <1392852167-26243-2-git-send-email-f.fainelli@gmail.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:6795 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaBSXXY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 18:23:24 -0500
In-Reply-To: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, gregkh@linuxfoundation.org, Florian Fainelli <f.fainelli@gmail.com>

Include linux/io.h which provides the definition for
__raw_{readl,writel}, this is not necessary on MIPS since there is an
implicit inclusion, but it is on ARM for instance.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 78e82b0..d71143e 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -30,6 +30,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/serial_bcm63xx.h>
+#include <linux/io.h>
 
 #define BCM63XX_NR_UARTS	2
 
-- 
1.8.3.2

