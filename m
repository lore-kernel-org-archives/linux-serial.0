From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] add vr41xx_siu_early_setup() for serial console
Date: Sat, 15 Mar 2008 20:00:44 +0900
Message-ID: <20080315200044.07bf9103.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mfo32.po.2iij.NET ([210.128.50.15]:16318 "EHLO
	mfo32.po.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYCOLGK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Mar 2008 07:06:10 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-serial@vger.kernel.org

Add vr41xx_siu_early_setup() for serial console

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/serial/vr41xx_siu.c linux/drivers/serial/vr41xx_siu.c
--- linux-orig/drivers/serial/vr41xx_siu.c	2008-03-12 17:03:43.420462106 +0900
+++ linux/drivers/serial/vr41xx_siu.c	2008-03-12 17:03:38.730540709 +0900
@@ -1,7 +1,7 @@
 /*
  *  Driver for NEC VR4100 series Serial Interface Unit.
  *
- *  Copyright (C) 2004-2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2004-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  Based on drivers/serial/8250.c, by Russell King.
  *
@@ -840,6 +840,19 @@ static int __devinit siu_console_init(vo
 
 console_initcall(siu_console_init);
 
+void __init vr41xx_siu_early_setup(struct uart_port *port)
+{
+	if (port->type == PORT_UNKNOWN)
+		return;
+
+	siu_uart_ports[port->line].line = port->line;
+	siu_uart_ports[port->line].type = port->type;
+	siu_uart_ports[port->line].uartclk = SIU_BAUD_BASE * 16;
+	siu_uart_ports[port->line].mapbase = port->mapbase;
+	siu_uart_ports[port->line].mapbase = port->mapbase;
+	siu_uart_ports[port->line].ops = &siu_uart_ops;
+}
+
 #define SERIAL_VR41XX_CONSOLE	&siu_console
 #else
 #define SERIAL_VR41XX_CONSOLE	NULL
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/vr41xx/siu.h linux/include/asm-mips/vr41xx/siu.h
--- linux-orig/include/asm-mips/vr41xx/siu.h	2008-03-12 17:04:01.248560582 +0900
+++ linux/include/asm-mips/vr41xx/siu.h	2008-03-12 17:03:38.730540709 +0900
@@ -1,7 +1,7 @@
 /*
  *  Include file for NEC VR4100 series Serial Interface Unit.
  *
- *  Copyright (C) 2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2005-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -49,4 +49,10 @@ typedef enum {
 
 extern void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed);
 
+#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
+extern void vr41xx_siu_early_setup(struct uart_port *port);
+#else
+static inline void vr41xx_siu_early_setup(struct uart_port *port) {}
+#endif
+
 #endif /* __NEC_VR41XX_SIU_H */
