From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 7/7] serial: mpc512x: Remove casting the return value which is
 a void pointer
Date: Mon, 09 Sep 2013 14:11:17 +0900
Message-ID: <004001cead1b$03561b20$0a025160$%han@samsung.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39048 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3IIFLS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:11:18 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00D91EER7PQ0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:11:18 +0900 (KST)
In-reply-to: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/mpc52xx_uart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 5be1df3..e05a3b1 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1766,7 +1766,7 @@ mpc52xx_uart_of_remove(struct platform_device *op)
 static int
 mpc52xx_uart_of_suspend(struct platform_device *op, pm_message_t state)
 {
-	struct uart_port *port = (struct uart_port *) platform_get_drvdata(op);
+	struct uart_port *port = platform_get_drvdata(op);
 
 	if (port)
 		uart_suspend_port(&mpc52xx_uart_driver, port);
@@ -1777,7 +1777,7 @@ mpc52xx_uart_of_suspend(struct platform_device *op, pm_message_t state)
 static int
 mpc52xx_uart_of_resume(struct platform_device *op)
 {
-	struct uart_port *port = (struct uart_port *) platform_get_drvdata(op);
+	struct uart_port *port = platform_get_drvdata(op);
 
 	if (port)
 		uart_resume_port(&mpc52xx_uart_driver, port);
-- 
1.7.10.4


