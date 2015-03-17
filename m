From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V2 RESEND 2/2] serial: 8250_pci: port failed after wakeup from S3
Date: Tue, 17 Mar 2015 18:02:15 +0800
Message-ID: <1426586535-6900-3-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1426586535-6900-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426586535-6900-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Serial ports of F81504/F81508/F81512 will failed when wakeup from S3(STR).

It's due to when the system wakeup from S3(STR), this PCI device's
configuration space from 0x40 to 0x40 + max_port * 0x08 should be
re-configured.

We move all initialization from pci_fintek_setup() to pci_fintek_init() and
set it to pci_serial_quirks .init section. It's will re-init this device when
system wakeup from pciserial_resume_ports().

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 114 ++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 64 deletions(-)
 mode change 100644 => 100755 drivers/tty/serial/8250/8250_pci.c

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 701b7b1..6f4cb3e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1550,88 +1550,71 @@ static int pci_fintek_setup(struct serial_private *priv,
 			    struct uart_8250_port *port, int idx)
 {
 	struct pci_dev *pdev = priv->dev;
-	unsigned long iobase;
 	u8 config_base;
+	u16 iobase;
+
+	config_base = 0x40 + 0x08 * idx;
+
+	/* Get the io address from configuration space */
+	pci_read_config_word(pdev, config_base + 4, &iobase);
+
+	dev_dbg(&pdev->dev, "%s: idx=%d iobase=0x%x", __func__, idx, iobase);
+
+	port->port.iotype = UPIO_PORT;
+	port->port.iobase = iobase;
+
+	return 0;
+}
+
+static int pci_fintek_init(struct pci_dev *dev)
+{
+	unsigned long iobase;
+	u32 max_port, i;
 	u32 bar_data[3];
+	u8 config_base;
 
-	/*
-	 * Find each UARTs offset in PCI configuraion space
-	 */
-	switch (idx) {
-	case 0:
-		config_base = 0x40;
+	switch (dev->device) {
+	case 0x1104: /* 4 ports */
+	case 0x1108: /* 8 ports */
+		max_port = dev->device & 0xff;
 		break;
-	case 1:
-		config_base = 0x48;
-		break;
-	case 2:
-		config_base = 0x50;
-		break;
-	case 3:
-		config_base = 0x58;
-		break;
-	case 4:
-		config_base = 0x60;
-		break;
-	case 5:
-		config_base = 0x68;
-		break;
-	case 6:
-		config_base = 0x70;
-		break;
-	case 7:
-		config_base = 0x78;
-		break;
-	case 8:
-		config_base = 0x80;
-		break;
-	case 9:
-		config_base = 0x88;
-		break;
-	case 10:
-		config_base = 0x90;
-		break;
-	case 11:
-		config_base = 0x98;
+	case 0x1112: /* 12 ports */
+		max_port = 12;
 		break;
 	default:
-		/* Unknown number of ports, get out of here */
 		return -EINVAL;
 	}
 
 	/* Get the io address dispatch from the BIOS */
-	pci_read_config_dword(pdev, 0x24, &bar_data[0]);
-	pci_read_config_dword(pdev, 0x20, &bar_data[1]);
-	pci_read_config_dword(pdev, 0x1c, &bar_data[2]);
-
-	/* Calculate Real IO Port */
-	iobase = (bar_data[idx/4] & 0xffffffe0) + (idx % 4) * 8;
+	pci_read_config_dword(dev, 0x24, &bar_data[0]);
+	pci_read_config_dword(dev, 0x20, &bar_data[1]);
+	pci_read_config_dword(dev, 0x1c, &bar_data[2]);
 
-	dev_dbg(&pdev->dev, "%s: idx=%d iobase=0x%lx config_base=0x%2x\n",
-		__func__, idx, iobase, config_base);
+	for (i = 0; i < max_port; ++i) {
+		/* UART0 configuration offset start from 0x40 */
+		config_base = 0x40 + 0x08 * i;
 
-	/* Enable UART I/O port */
-	pci_write_config_byte(pdev, config_base + 0x00, 0x01);
+		/* Calculate Real IO Port */
+		iobase = (bar_data[i / 4] & 0xffffffe0) + (i % 4) * 8;
 
-	/* Select 128-byte FIFO and 8x FIFO threshold */
-	pci_write_config_byte(pdev, config_base + 0x01, 0x33);
+		/* Enable UART I/O port */
+		pci_write_config_byte(dev, config_base + 0x00, 0x01);
 
-	/* LSB UART */
-	pci_write_config_byte(pdev, config_base + 0x04, (u8)(iobase & 0xff));
+		/* Select 128-byte FIFO and 8x FIFO threshold */
+		pci_write_config_byte(dev, config_base + 0x01, 0x33);
 
-	/* MSB UART */
-	pci_write_config_byte(pdev, config_base + 0x05, (u8)((iobase & 0xff00) >> 8));
+		/* LSB UART */
+		pci_write_config_byte(dev, config_base + 0x04,
+				(u8)(iobase & 0xff));
 
-	/* irq number, this usually fails, but the spec says to do it anyway. */
-	pci_write_config_byte(pdev, config_base + 0x06, pdev->irq);
+		/* MSB UART */
+		pci_write_config_byte(dev, config_base + 0x05,
+				(u8)((iobase & 0xff00) >> 8));
 
-	port->port.iotype = UPIO_PORT;
-	port->port.iobase = iobase;
-	port->port.mapbase = 0;
-	port->port.membase = NULL;
-	port->port.regshift = 0;
+		pci_write_config_byte(dev, config_base + 0x06, dev->irq);
+	}
 
-	return 0;
+	return max_port;
 }
 
 static int skip_tx_en_setup(struct serial_private *priv,
@@ -2646,6 +2629,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_fintek_setup,
+		.init		= pci_fintek_init,
 	},
 	{
 		.vendor		= 0x1c29,
@@ -2653,6 +2637,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_fintek_setup,
+		.init		= pci_fintek_init,
 	},
 	{
 		.vendor		= 0x1c29,
@@ -2660,6 +2645,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_fintek_setup,
+		.init		= pci_fintek_init,
 	},
 
 	/*
-- 
1.9.1
