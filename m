From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/3] serial: pch_uart: add debugfs hook for register dump
Date: Mon,  6 Feb 2012 17:24:43 +0800
Message-ID: <1328520285-10826-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34694 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075Ab2BFJZn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Feb 2012 04:25:43 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, tomoya.rohm@gmail.com
Cc: Feng Tang <feng.tang@intel.com>

This driver will be use as interfaces for multiple kinds of
devices like Bluetooth/GPS etc, this debug hook will make driver
debugging much easier.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/pch_uart.c |   84 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 17ae657..6d9ca29 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -29,6 +29,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 
+#include <linux/debugfs.h>
 #include <linux/dmaengine.h>
 #include <linux/pch_dma.h>
 
@@ -144,6 +145,8 @@ enum {
 #define PCH_UART_DLL		0x00
 #define PCH_UART_DLM		0x01
 
+#define PCH_UART_BRCSR		0x0E
+
 #define PCH_UART_IID_RLS	(PCH_UART_IIR_REI)
 #define PCH_UART_IID_RDR	(PCH_UART_IIR_RRI)
 #define PCH_UART_IID_RDR_TO	(PCH_UART_IIR_RRI | PCH_UART_IIR_TOI)
@@ -243,6 +246,8 @@ struct eg20t_port {
 	int				tx_dma_use;
 	void				*rx_buf_virt;
 	dma_addr_t			rx_buf_dma;
+
+	struct dentry	*debugfs;
 };
 
 /**
@@ -292,6 +297,73 @@ static const int trigger_level_64[4] = { 1, 16, 32, 56 };
 static const int trigger_level_16[4] = { 1, 4, 8, 14 };
 static const int trigger_level_1[4] = { 1, 1, 1, 1 };
 
+#ifdef CONFIG_DEBUG_FS
+
+#define PCH_REGS_BUFSIZE	1024
+static int pch_show_regs_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t port_show_regs(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct eg20t_port *priv = file->private_data;
+	char *buf;
+	u32 len = 0;
+	ssize_t ret;
+	unsigned char lcr;
+
+	buf = kzalloc(PCH_REGS_BUFSIZE, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"PCH EG20T port[%d] regs:\n", priv->port.line);
+
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"=================================\n");
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"IER: \t0x%02x\n", ioread8(priv->membase + UART_IER));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"IIR: \t0x%02x\n", ioread8(priv->membase + UART_IIR));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"LCR: \t0x%02x\n", ioread8(priv->membase + UART_LCR));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"MCR: \t0x%02x\n", ioread8(priv->membase + UART_MCR));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"LSR: \t0x%02x\n", ioread8(priv->membase + UART_LSR));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"MSR: \t0x%02x\n", ioread8(priv->membase + UART_MSR));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"BRCSR: \t0x%02x\n",
+			ioread8(priv->membase + PCH_UART_BRCSR));
+
+	lcr = ioread8(priv->membase + UART_LCR);
+	iowrite8(PCH_UART_LCR_DLAB, priv->membase + UART_LCR);
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"DLL: \t0x%02x\n", ioread8(priv->membase + UART_DLL));
+	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+			"DLM: \t0x%02x\n", ioread8(priv->membase + UART_DLM));
+	iowrite8(lcr, priv->membase + UART_LCR);
+
+	if (len > PCH_REGS_BUFSIZE)
+		len = PCH_REGS_BUFSIZE;
+
+	ret =  simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations port_regs_ops = {
+	.owner		= THIS_MODULE,
+	.open		= pch_show_regs_open,
+	.read		= port_show_regs,
+	.llseek		= default_llseek,
+};
+#endif	/* CONFIG_DEBUG_FS */
+
 static void pch_uart_hal_request(struct pci_dev *pdev, int fifosize,
 				 int base_baud)
 {
@@ -1554,6 +1626,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	int port_type;
 	struct pch_uart_driver_data *board;
 	const char *board_name;
+	char name[32];	/* for debugfs file name */
 
 	board = &drv_dat[id->driver_data];
 	port_type = board->port_type;
@@ -1623,6 +1696,12 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (ret < 0)
 		goto init_port_hal_free;
 
+#ifdef CONFIG_DEBUG_FS
+	snprintf(name, sizeof(name), "uart%d_regs", board->line_no);
+	priv->debugfs = debugfs_create_file(name, S_IFREG | S_IRUGO,
+				NULL, priv, &port_regs_ops);
+#endif
+
 	return priv;
 
 init_port_hal_free:
@@ -1639,6 +1718,11 @@ init_port_alloc_err:
 
 static void pch_uart_exit_port(struct eg20t_port *priv)
 {
+
+#ifdef CONFIG_DEBUG_FS
+	if (priv->debugfs)
+		debugfs_remove(priv->debugfs);
+#endif
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
 	pci_set_drvdata(priv->pdev, NULL);
 	free_page((unsigned long)priv->rxbuf.buf);
-- 
1.7.1

