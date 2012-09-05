From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] serial: Samsung: Silence some checkpatch errors and warnings
Date: Wed,  5 Sep 2012 10:30:11 +0530
Message-ID: <1346821211-23478-2-git-send-email-sachin.kamat@linaro.org>
References: <1346821211-23478-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58765 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab2IEFC7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 01:02:59 -0400
Received: by dady13 with SMTP id y13so87295dad.19
        for <linux-serial@vger.kernel.org>; Tue, 04 Sep 2012 22:02:58 -0700 (PDT)
In-Reply-To: <1346821211-23478-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, patches@linaro.org

Fixes the following errors and warnings:
ERROR: trailing whitespace
ERROR: return is not a function, parentheses are not required
WARNING: suspect code indent for conditional statements (32, 36)

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/samsung.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 8749a07..bdaa06f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -82,7 +82,7 @@ static inline const char *s3c24xx_serial_portname(struct uart_port *port)
 
 static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
 {
-	return (rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE);
+	return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
 }
 
 /*
@@ -268,7 +268,7 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
 				dbg("break!\n");
 				port->icount.brk++;
 				if (uart_handle_break(port))
-				    goto ignore_char;
+					goto ignore_char;
 			}
 
 			if (uerstat & S3C2410_UERSTAT_FRAME)
@@ -1129,7 +1129,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->rx_irq = ret;
 		ourport->tx_irq = ret + 1;
 	}
-	
+
 	ret = platform_get_irq(platdev, 1);
 	if (ret > 0)
 		ourport->tx_irq = ret;
-- 
1.7.4.1

