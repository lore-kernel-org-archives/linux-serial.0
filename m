From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH 1/1] serial: 8250_pci: add RS485 for F81504/508/512
Date: Fri, 24 Jul 2015 13:55:39 +0800
Message-ID: <1437717339-28881-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Add RS485 control for Fintek F81504/508/512

F81504/508/512 can control their RTS with H/W mode.
PCI configuration space for each port is 0x40 + idx * 8 + 7.

When it set with 0x01, it's configured with RS232 mode.
RTS is controlled by MCR.

When it set with 0x11, it's configured with RS485 mode.
RTS is controlled by H/W, RTS high with idle & RX, low with TX.

When it set with 0x31, it's configured with RS485 mode.
RTS is controlled by H/W, RTS low with idle & RX, high with TX.

We will force 0x01 on pci_fintek_setup().

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e55f18b..36280fa 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1685,11 +1685,43 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 	return ret;
 }
 
+static int pci_fintek_rs485_config(struct uart_port *port,
+			       struct serial_rs485 *rs485)
+{
+	u8 setting;
+	u8 *index = (u8 *) port->private_data;
+	struct pci_dev *pci_dev = container_of(port->dev, struct pci_dev,
+									dev);
+
+	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Enable RTS H/W control mode */
+		setting |= BIT(4);
+
+		if (rs485->flags & SER_RS485_RTS_ON_SEND) {
+			/* RTS driving high on TX */
+			setting |= BIT(5);
+		} else {
+			/* RTS driving low on TX */
+			setting &= ~BIT(5);
+		}
+	} else {
+		/* Disable RTS H/W control mode */
+		setting &= ~(BIT(4) | BIT(5));
+	}
+
+	pci_write_config_byte(pci_dev, 0x40 + 8 * *index + 7, setting);
+	port->rs485 = *rs485;
+	return 0;
+}
+
 static int pci_fintek_setup(struct serial_private *priv,
 			    const struct pciserial_board *board,
 			    struct uart_8250_port *port, int idx)
 {
 	struct pci_dev *pdev = priv->dev;
+	u8 *data;
 	u8 config_base;
 	u16 iobase;
 
@@ -1702,6 +1734,15 @@ static int pci_fintek_setup(struct serial_private *priv,
 
 	port->port.iotype = UPIO_PORT;
 	port->port.iobase = iobase;
+	port->port.rs485_config = pci_fintek_rs485_config;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(u8), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* preserve index in PCI configuration space */
+	*data = idx;
+	port->port.private_data = data;
 
 	return 0;
 }
@@ -1752,6 +1793,9 @@ static int pci_fintek_init(struct pci_dev *dev)
 				(u8)((iobase & 0xff00) >> 8));
 
 		pci_write_config_byte(dev, config_base + 0x06, dev->irq);
+
+		/* force init to RS232 Mode */
+		pci_write_config_byte(dev, config_base + 0x07, 0x01);
 	}
 
 	return max_port;
-- 
1.9.1
