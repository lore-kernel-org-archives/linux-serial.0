From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: pl010: increase UART_NR to allow for more than two pl010 UARTs
Date: Tue, 4 Apr 2006 12:18:22 +0200
Message-ID: <20060404101822.GD24060@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:32159 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751827AbWDDKSY
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Apr 2006 06:18:24 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk@arm.linux.org.uk, Manfred Gruber <manfred.gruber@contec.at>

On the cirrus ep93xx, there are three pl010 UARTs, while the pl010
driver only allows for two by default.  Increase UART_NR to eight to
allow these extra ports to be used.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Index: linux-2.6.17-rc1/drivers/serial/amba-pl010.c
===================================================================
--- linux-2.6.17-rc1.orig/drivers/serial/amba-pl010.c
+++ linux-2.6.17-rc1/drivers/serial/amba-pl010.c
@@ -52,7 +52,7 @@
 
 #include <asm/io.h>
 
-#define UART_NR		2
+#define UART_NR		8
 
 #define SERIAL_AMBA_MAJOR	204
 #define SERIAL_AMBA_MINOR	16
