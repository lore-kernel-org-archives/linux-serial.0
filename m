From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/3] serial: 8250_dw: don't limit DMA support to ACPI
Date: Thu,  5 Sep 2013 17:34:53 +0300
Message-ID: <1378391694-28725-3-git-send-email-heikki.krogerus@linux.intel.com>
References: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59118 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab3IEOe7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 10:34:59 -0400
In-Reply-To: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

It should be available for DT users as well. This does not
enable DMA by default except with ACPI. DT users can enable
DMA based on a property.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index daf710f..d7a405b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -56,11 +56,12 @@
 
 
 struct dw8250_data {
-	int		last_lcr;
-	int		last_mcr;
-	int		line;
-	struct clk	*clk;
-	u8		usr_reg;
+	u8			usr_reg;
+	int			last_lcr;
+	int			last_mcr;
+	int			line;
+	struct clk		*clk;
+	struct uart_8250_dma	dma;
 };
 
 static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
@@ -241,7 +242,8 @@ static int dw8250_probe_of(struct uart_port *p,
 }
 
 #ifdef CONFIG_ACPI
-static int dw8250_probe_acpi(struct uart_8250_port *up)
+static int dw8250_probe_acpi(struct uart_8250_port *up,
+			     struct dw8250_data *data)
 {
 	const struct acpi_device_id *id;
 	struct uart_port *p = &up->port;
@@ -260,9 +262,7 @@ static int dw8250_probe_acpi(struct uart_8250_port *up)
 	if (!p->uartclk)
 		p->uartclk = (unsigned int)id->driver_data;
 
-	up->dma = devm_kzalloc(p->dev, sizeof(*up->dma), GFP_KERNEL);
-	if (!up->dma)
-		return -ENOMEM;
+	up->dma = &data->dma;
 
 	up->dma->rxconf.src_maxburst = p->fifosize / 4;
 	up->dma->txconf.dst_maxburst = p->fifosize / 4;
@@ -324,7 +324,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		if (err)
 			return err;
 	} else if (ACPI_HANDLE(&pdev->dev)) {
-		err = dw8250_probe_acpi(&uart);
+		err = dw8250_probe_acpi(&uart, data);
 		if (err)
 			return err;
 	} else {
-- 
1.8.4.rc3

