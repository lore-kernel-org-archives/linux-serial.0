From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] serial: pxa: add clk_prepare/clk_unprepare calls
Date: Thu, 15 Mar 2012 19:15:15 +0100
Message-ID: <1331835315.14662.7.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36137 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab2COSPS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Mar 2012 14:15:18 -0400
Received: by eaaq12 with SMTP id q12so1805528eaa.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Mar 2012 11:15:17 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Alan Cox <alan@linux.intel.com>, GregKroah-Hartman <gregkh@linuxfoundation.org>

This patch adds clk_prepare/clk_unprepare calls to the serial/pxa
driver by using the helper functions clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/pxa.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5c8e3bb..e2fd3d8 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -579,9 +579,9 @@ serial_pxa_pm(struct uart_port *port, unsigned int state,
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
 
 	if (!state)
-		clk_enable(up->clk);
+		clk_prepare_enable(up->clk);
 	else
-		clk_disable(up->clk);
+		clk_disable_unprepare(up->clk);
 }
 
 static void serial_pxa_release_port(struct uart_port *port)
@@ -668,7 +668,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	struct uart_pxa_port *up = serial_pxa_ports[co->index];
 	unsigned int ier;
 
-	clk_enable(up->clk);
+	clk_prepare_enable(up->clk);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -685,7 +685,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	wait_for_xmitr(up);
 	serial_out(up, UART_IER, ier);
 
-	clk_disable(up->clk);
+	clk_disable_unprepare(up->clk);
 }
 
 static int __init
-- 
1.7.9.1


