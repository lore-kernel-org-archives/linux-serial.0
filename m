From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: samsung: Use %pa to print 'resource_size_t' type
Date: Wed,  4 Jun 2014 20:06:41 -0300
Message-ID: <1401923201-5477-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:59423 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaFDXHE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jun 2014 19:07:04 -0400
Received: by mail-yh0-f50.google.com with SMTP id 29so181232yhl.23
        for <linux-serial@vger.kernel.org>; Wed, 04 Jun 2014 16:07:03 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jg1.han@samsung.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

When building multi_v7_defconfig with CONFIG_ARM_LPAE=y the following warning
is seen:

drivers/tty/serial/samsung.c: In function 's3c24xx_serial_init_port':
drivers/tty/serial/samsung.c:1229:2: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' [-Wformat]

Use %pa to print 'resource_size_t' type to fix the warning.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 3293377..b7b8185 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1226,8 +1226,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
 	}
 
-	dbg("port: map=%08x, mem=%p, irq=%d (%d,%d), clock=%u\n",
-	    port->mapbase, port->membase, port->irq,
+	dbg("port: map=%pa, mem=%p, irq=%d (%d,%d), clock=%u\n",
+	    &port->mapbase, port->membase, port->irq,
 	    ourport->rx_irq, ourport->tx_irq, port->uartclk);
 
 	/* reset the fifos (and setup the uart) */
-- 
1.8.3.2

