From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] pch_uart: Add uart device to irq name
Date: Tue, 25 Mar 2014 14:05:08 +0100
Message-ID: <1395752708-3748-1-git-send-email-alexander.stein@systec-electronic.com>
References: <20140325125249.GA6360@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:57469 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752878AbaCYNGS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 09:06:18 -0400
In-Reply-To: <20140325125249.GA6360@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This will additionally show the specific UART device instead of the
general module name. This cames in handy so check for the interupts of
a specific device if there are several of them.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v2:
* Add actual commit message
* Fix checkpatch errors

 drivers/tty/serial/pch_uart.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 8fa1134..7763507 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -257,6 +257,8 @@ struct eg20t_port {
 	dma_addr_t			rx_buf_dma;
 
 	struct dentry	*debugfs;
+#define IRQ_NAME_SIZE 17
+	char				irq_name[IRQ_NAME_SIZE];
 
 	/* protect the eg20t_port private structure and io access to membase */
 	spinlock_t lock;
@@ -1343,7 +1345,7 @@ static int pch_uart_startup(struct uart_port *port)
 		return ret;
 
 	ret = request_irq(priv->port.irq, pch_uart_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, priv);
+			priv->irq_name, priv);
 	if (ret < 0)
 		return ret;
 
@@ -1816,6 +1818,10 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	priv->port.line = board->line_no;
 	priv->trigger = PCH_UART_HAL_TRIGGER_M;
 
+	snprintf(priv->irq_name, IRQ_NAME_SIZE,
+		 KBUILD_MODNAME ":" PCH_UART_DRIVER_DEVICE "%d",
+		 priv->port.line);
+
 	spin_lock_init(&priv->port.lock);
 
 	pci_set_drvdata(pdev, priv);
-- 
1.8.3.2

