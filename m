From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] serial: Samsung: Replace printk with dev_* functions
Date: Wed,  5 Sep 2012 10:30:10 +0530
Message-ID: <1346821211-23478-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33931 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab2IEFCz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 01:02:55 -0400
Received: by pbbrr13 with SMTP id rr13so312166pbb.19
        for <linux-serial@vger.kernel.org>; Tue, 04 Sep 2012 22:02:55 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, patches@linaro.org

Silences checkpatch warnings regarding use of printks.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/samsung.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 5c5e7e0..8749a07 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -459,7 +459,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 			  s3c24xx_serial_portname(port), ourport);
 
 	if (ret != 0) {
-		printk(KERN_ERR "cannot get irq %d\n", ourport->rx_irq);
+		dev_err(port->dev, "cannot get irq %d\n", ourport->rx_irq);
 		return ret;
 	}
 
@@ -473,7 +473,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 			  s3c24xx_serial_portname(port), ourport);
 
 	if (ret) {
-		printk(KERN_ERR "cannot get irq %d\n", ourport->tx_irq);
+		dev_err(port->dev, "cannot get irq %d\n", ourport->tx_irq);
 		goto err;
 	}
 
@@ -502,7 +502,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	ret = request_irq(port->irq, s3c64xx_serial_handle_irq, IRQF_SHARED,
 			  s3c24xx_serial_portname(port), ourport);
 	if (ret) {
-		printk(KERN_ERR "cannot get irq %d\n", port->irq);
+		dev_err(port->dev, "cannot get irq %d\n", port->irq);
 		return ret;
 	}
 
@@ -543,7 +543,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 
 		break;
 	default:
-		printk(KERN_ERR "s3c24xx_serial: unknown pm %d\n", level);
+		dev_err(port->dev, "s3c24xx_serial: unknown pm %d\n", level);
 	}
 }
 
@@ -1038,7 +1038,7 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 		termios = &tty->termios;
 
 		if (termios == NULL) {
-			printk(KERN_WARNING "%s: no termios?\n", __func__);
+			dev_warn(uport->dev, "%s: no termios?\n", __func__);
 			goto exit;
 		}
 
@@ -1113,7 +1113,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	res = platform_get_resource(platdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-		printk(KERN_ERR "failed to find memory resource for uart\n");
+		dev_err(port->dev, "failed to find memory resource for uart\n");
 		return -EINVAL;
 	}
 
@@ -1683,7 +1683,7 @@ static int __init s3c24xx_serial_modinit(void)
 
 	ret = uart_register_driver(&s3c24xx_uart_drv);
 	if (ret < 0) {
-		printk(KERN_ERR "failed to register UART driver\n");
+		pr_err("Failed to register Samsung UART driver\n");
 		return -1;
 	}
 
-- 
1.7.4.1

