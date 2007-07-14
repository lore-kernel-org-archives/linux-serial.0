From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH][1/3] serial: fix section mismatch vr41xx_siu
Date: Sat, 14 Jul 2007 21:19:04 +0900
Message-ID: <20070714211904.13d0a53b.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mfo31.po.2iij.NET ([210.128.50.52]:8384 "EHLO mfo31.po.2iij.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758238AbXGNMd6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2007 08:33:58 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: yoichi_yuasa@tripeaks.co.jp, Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>

Fix section mismatch vr41xx_siu.

WARNING: drivers/built-in.o(.text+0x2ce4c): Section mismatch: reference to .init.text:uart_parse_options (between 'siu_console_setup' and 'siu_request_port')
WARNING: drivers/built-in.o(.text+0x2ce70): Section mismatch: reference to .init.text:uart_set_options (between 'siu_console_setup' and 'siu_request_port')

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X siu/Documentation/dontdiff siu-orig/drivers/serial/vr41xx_siu.c siu/drivers/serial/vr41xx_siu.c
--- siu-orig/drivers/serial/vr41xx_siu.c	2007-05-29 10:12:55.803195750 +0900
+++ siu/drivers/serial/vr41xx_siu.c	2007-05-29 10:11:07.752443000 +0900
@@ -782,7 +782,7 @@ static void siu_console_write(struct con
 	siu_write(port, UART_IER, ier);
 }
 
-static int siu_console_setup(struct console *con, char *options)
+static int __init siu_console_setup(struct console *con, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
