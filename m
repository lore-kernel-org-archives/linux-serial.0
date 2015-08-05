From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH 1/1] serial: 8250_pci: fix mode after S3/S4 resume for F81504/508/512
Date: Wed,  5 Aug 2015 14:44:53 +0800
Message-ID: <1438757093-10050-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fix RS232/485 mode incorrect setting after S3/S4 resume for F81504/508/512

We had add RS232/485 RTS control with fecf27a373f5. But when it
resume from S3/S4, the mode register 0x40 + 0x08 * idx + 7 will
rewrite to 0x01 (RS232 mode).

This patch will modify 2 sections.

One is pci_fintek_init(), if it called when first init, it will
write mode register with 0x01. If it called from S3/S4 resume,
it's will get the relative port data and pass it to
pci_fintek_rs485_config() with NULL rs485 parameter.

The another modification is in pci_fintek_rs485_config(). It'll
re-apply old configuration when the parameter rs485 is NULL.

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e12e911..68042dd 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1705,7 +1705,9 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 
 	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
 
-	if (rs485->flags & SER_RS485_ENABLED)
+	if (!rs485)
+		rs485 = &port->rs485;
+	else if (rs485->flags & SER_RS485_ENABLED)
 		memset(rs485->padding, 0, sizeof(rs485->padding));
 	else
 		memset(rs485, 0, sizeof(*rs485));
@@ -1733,7 +1735,10 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 	}
 
 	pci_write_config_byte(pci_dev, 0x40 + 8 * *index + 7, setting);
-	port->rs485 = *rs485;
+
+	if (rs485 != &port->rs485)
+		port->rs485 = *rs485;
+
 	return 0;
 }
 
@@ -1774,6 +1779,8 @@ static int pci_fintek_init(struct pci_dev *dev)
 	u32 max_port, i;
 	u32 bar_data[3];
 	u8 config_base;
+	struct serial_private *priv = pci_get_drvdata(dev);
+	struct uart_8250_port *port;
 
 	switch (dev->device) {
 	case 0x1104: /* 4 ports */
@@ -1815,8 +1822,18 @@ static int pci_fintek_init(struct pci_dev *dev)
 
 		pci_write_config_byte(dev, config_base + 0x06, dev->irq);
 
-		/* force init to RS232 Mode */
-		pci_write_config_byte(dev, config_base + 0x07, 0x01);
+		if (priv) {
+			/* re-apply RS232/485 mode when
+			 * pciserial_resume_ports()
+			 */
+			port = serial8250_get_port(priv->line[i]);
+			pci_fintek_rs485_config(&port->port, NULL);
+		} else {
+			/* First init without port data
+			 * force init to RS232 Mode
+			 */
+			pci_write_config_byte(dev, config_base + 0x07, 0x01);
+		}
 	}
 
 	return max_port;
-- 
1.9.1
