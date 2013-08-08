From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 08/10] serial: pxa: Staticize local symbols
Date: Thu, 08 Aug 2013 17:39:51 +0900
Message-ID: <006401ce9412$d97a34b0$8c6e9e10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39606 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab3HHIjx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:39:53 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR700D7LEPIKEH0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:39:52 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Yi Zhang' <yizhang@marvell.com>, 'Haojun Bao' <hjbao@marvell.com>, Jingoo Han <jg1.han@samsung.com>

>From 954e4e864408be296bad2488fb133c2ea163f90f Mon Sep 17 00:00:00 2001
From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 8 Aug 2013 17:15:08 +0900
Subject: [PATCH 08/10] serial: pxa: Staticize local symbols

These local symbols are used only in this file.
Fix the following sparse warnings:

drivers/tty/serial/pxa.c:793:17: warning: symbol 'serial_pxa_pops' was not declared. Should it be static?
drivers/tty/serial/pxa.c:971:12: warning: symbol 'serial_pxa_init' was not declared. Should it be static?
drivers/tty/serial/pxa.c:986:13: warning: symbol 'serial_pxa_exit' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/pxa.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index ac8b2f5..290f514 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -790,7 +790,7 @@ static struct console serial_pxa_console = {
 #define PXA_CONSOLE	NULL
 #endif
 
-struct uart_ops serial_pxa_pops = {
+static struct uart_ops serial_pxa_pops = {
 	.tx_empty	= serial_pxa_tx_empty,
 	.set_mctrl	= serial_pxa_set_mctrl,
 	.get_mctrl	= serial_pxa_get_mctrl,
@@ -968,7 +968,7 @@ static struct platform_driver serial_pxa_driver = {
 	},
 };
 
-int __init serial_pxa_init(void)
+static int __init serial_pxa_init(void)
 {
 	int ret;
 
@@ -983,7 +983,7 @@ int __init serial_pxa_init(void)
 	return ret;
 }
 
-void __exit serial_pxa_exit(void)
+static void __exit serial_pxa_exit(void)
 {
 	platform_driver_unregister(&serial_pxa_driver);
 	uart_unregister_driver(&serial_pxa_reg);
-- 
1.7.10.4


