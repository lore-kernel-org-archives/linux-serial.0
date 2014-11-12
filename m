From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH/RFC 2/8] serial: core: Add big_endian flag
Date: Wed, 12 Nov 2014 00:46:27 -0800
Message-ID: <1415781993-7755-3-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38037 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbaKLIrJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:47:09 -0500
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Add a big_endian flag alongside membase, regshift, and iotype.  Most
drivers currently use readl/writel, but if it is necessary to support
a BE SoC, the driver can check this field to see which MMIO accessor
functions to use.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 21c2e05..ae372f4 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -138,7 +138,7 @@ struct uart_port {
 	unsigned char		x_char;			/* xon/xoff char */
 	unsigned char		regshift;		/* reg offset shift */
 	unsigned char		iotype;			/* io access style */
-	unsigned char		unused1;
+	unsigned char		big_endian;		/* BE registers */
 
 #define UPIO_PORT		(0)
 #define UPIO_HUB6		(1)
-- 
2.1.1

