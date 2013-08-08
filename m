From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 10/10] serial: sirf: Staticize local symbols
Date: Thu, 08 Aug 2013 17:41:43 +0900
Message-ID: <006601ce9413$1bd386e0$537a94a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30448 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933833Ab3HHIlo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:41:44 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR7000DOET3LKF0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:41:43 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Barry Song <baohua.song@csr.com>, Jingoo Han <jg1.han@samsung.com>

>From 0170294084877d365fbd1b369cd4dedfc3749ee5 Mon Sep 17 00:00:00 2001
From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 8 Aug 2013 17:24:38 +0900
Subject: [PATCH 10/10] serial: sirf: Staticize local symbols

These local symbols are used only in this file.
Fix the following sparse warnings:

drivers/tty/serial/sirfsoc_uart.c:147:6: warning: symbol 'sirfsoc_uart_start_tx' was not declared. Should it be static?
drivers/tty/serial/sirfsoc_uart.c:636:5: warning: symbol 'sirfsoc_uart_probe' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/sirfsoc_uart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 67a0d1b..3b38137 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -144,7 +144,7 @@ static void sirfsoc_uart_stop_tx(struct uart_port *port)
 	wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_TX_INT_EN);
 }
 
-void sirfsoc_uart_start_tx(struct uart_port *port)
+static void sirfsoc_uart_start_tx(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	unsigned long regv;
@@ -633,7 +633,7 @@ static struct uart_driver sirfsoc_uart_drv = {
 #endif
 };
 
-int sirfsoc_uart_probe(struct platform_device *pdev)
+static int sirfsoc_uart_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_uart_port *sirfport;
 	struct uart_port *port;
-- 
1.7.10.4


