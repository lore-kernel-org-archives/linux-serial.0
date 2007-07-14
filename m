From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH][2/3] serial: fix vr41xx_siu serial console support
Date: Sat, 14 Jul 2007 21:27:35 +0900
Message-ID: <20070714212735.4f733eb7.yoichi_yuasa@tripeaks.co.jp>
References: <20070714211904.13d0a53b.yoichi_yuasa@tripeaks.co.jp>
	<20070714212415.4a44aae9.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mfo30.po.2iij.NET ([210.128.50.51]:6214 "EHLO mfo30.po.2iij.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758608AbXGNMeA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2007 08:34:00 -0400
In-Reply-To: <20070714212415.4a44aae9.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@linux-foundation.org, ralf@linux-mips.org

The serial console can select only SERIAL_VR41XX=y.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/serial/Kconfig generic/drivers/serial/Kconfig
--- generic-orig/drivers/serial/Kconfig	2007-07-13 10:01:18.452615000 +0900
+++ generic/drivers/serial/Kconfig	2007-07-13 10:01:01.791573750 +0900
@@ -1123,7 +1123,7 @@ config SERIAL_VR41XX
 
 config SERIAL_VR41XX_CONSOLE
 	bool "Enable NEC VR4100 series Serial Interface Unit console"
-	depends on SERIAL_VR41XX
+	depends on SERIAL_VR41XX=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you have a NEC VR4100 series processor and you want to use
diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/serial/vr41xx_siu.c generic/drivers/serial/vr41xx_siu.c
--- generic-orig/drivers/serial/vr41xx_siu.c	2007-07-13 10:42:04.473481750 +0900
+++ generic/drivers/serial/vr41xx_siu.c	2007-07-13 10:01:01.795574000 +0900
@@ -65,7 +65,9 @@ static struct uart_port siu_uart_ports[S
 	},
 };
 
+#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
 static uint8_t lsr_break_flag[SIU_PORTS_MAX];
+#endif
 
 #define siu_read(port, offset)		readb((port)->membase + (offset))
 #define siu_write(port, offset, value)	writeb((value), (port)->membase + (offset))
