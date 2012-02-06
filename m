From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 3/3] serial: pch_uart: trivail cleanup by removing the pch_uart_hal_request()
Date: Mon,  6 Feb 2012 17:24:45 +0800
Message-ID: <1328520285-10826-3-git-send-email-feng.tang@intel.com>
References: <1328520285-10826-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34694 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205Ab2BFJZp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Feb 2012 04:25:45 -0500
In-Reply-To: <1328520285-10826-1-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, tomoya.rohm@gmail.com
Cc: Feng Tang <feng.tang@intel.com>

pch_uart_hal_request() has parameters which it never uses, also
it is very short, so merge it with its caller to make code cleaner.
No functional changes at all.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/pch_uart.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 811edcb..aa4d07b 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -364,15 +364,6 @@ static const struct file_operations port_regs_ops = {
 };
 #endif	/* CONFIG_DEBUG_FS */
 
-static void pch_uart_hal_request(struct pci_dev *pdev, int fifosize,
-				 int base_baud)
-{
-	struct eg20t_port *priv = pci_get_drvdata(pdev);
-
-	priv->trigger_level = 1;
-	priv->fcr = 0;
-}
-
 static void pch_uart_hal_enable_interrupt(struct eg20t_port *priv,
 					  unsigned int flag)
 {
@@ -1674,7 +1665,8 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	spin_lock_init(&priv->port.lock);
 
 	pci_set_drvdata(pdev, priv);
-	pch_uart_hal_request(pdev, fifosize, base_baud);
+	priv->trigger_level = 1;
+	priv->fcr = 0;
 
 #ifdef CONFIG_SERIAL_PCH_UART_CONSOLE
 	pch_uart_ports[board->line_no] = priv;
@@ -1717,9 +1709,7 @@ static void pch_uart_exit_port(struct eg20t_port *priv)
 
 static void pch_uart_pci_remove(struct pci_dev *pdev)
 {
-	struct eg20t_port *priv;
-
-	priv = (struct eg20t_port *)pci_get_drvdata(pdev);
+	struct eg20t_port *priv = pci_get_drvdata(pdev);
 
 	pci_disable_msi(pdev);
 
-- 
1.7.1

