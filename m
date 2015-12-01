From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH RESEND 1/1] serial: 8250_pci: Fix real serial port count for F81504/508/512
Date: Tue,  1 Dec 2015 14:54:41 +0800
Message-ID: <1448952881-7871-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fix real serial port count for F81504/508/512 with multi-function mode.

Fintek F81504/508/512 are multi-function boards. It could be configurated
via PCI configuration space register F0h/F3h with external EEPROM that
programmed by customer.

F0h bit0~5: Enable GPIO0~5
    bit6~7: Reserve

F3h bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
        bit0: UART2 pin out for UART2 / GPIO0
        bit1: UART3 pin out for UART3 / GPIO1
        bit2: UART8 pin out for UART8 / GPIO2
        bit3: UART9 pin out for UART9 / GPIO3
        bit4: UART10 pin out for UART10 / GPIO4
        bit5: UART11 pin out for UART11 / GPIO5
    bit6~7: Reserve

It'll use (F0h & ~F3h) & 0x3f union set to find max set of GPIOs.
If a port is indicated as GPIO, it'll not report as serial port and reserve
for userspace to manipulate.

F81504: Max for 4 serial ports.
        UART2/3 is multi-function.

F81508: Max for 8 serial ports.
        UART2/3 is multi-function.
        8/9/10/11 is GPIO only

F81512: Max for 12 serial ports.
        UART2/3/8/9/10/11 is multi-function.

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 114 +++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4097f3f..8a639cb 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1532,6 +1532,9 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 /* only worked with FINTEK_RTS_CONTROL_BY_HW on */
 #define FINTEK_RTS_INVERT		BIT(5)
 
+/* The device is multi-function with UART & GPIO */
+static u8 fintek_gpio_mapping[] = {2, 3, 8, 9, 10, 11};
+
 /* We should do proper H/W transceiver setting before change to RS485 mode */
 static int pci_fintek_rs485_config(struct uart_port *port,
 			       struct serial_rs485 *rs485)
@@ -1586,10 +1589,41 @@ static int pci_fintek_setup(struct serial_private *priv,
 {
 	struct pci_dev *pdev = priv->dev;
 	u8 *data;
-	u8 config_base;
-	u16 iobase;
+	u8 tmp;
+	u8 config_base = 0;
+	u16 iobase, i, max_port, count = 0;
 
-	config_base = 0x40 + 0x08 * idx;
+	switch (pdev->device) {
+	case 0x1104: /* 4 ports */
+	case 0x1108: /* 8 ports */
+		max_port = pdev->device & 0xff;
+		break;
+	case 0x1112: /* 12 ports */
+		max_port = 12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* find real serial port index from logic idx */
+	for (i = 0; i < max_port; ++i) {
+		config_base = 0x40 + 0x08 * i;
+
+		pci_read_config_byte(pdev, config_base, &tmp);
+		if (!tmp)
+			continue;
+
+		if (count == idx)
+			break;
+
+		++count;
+	}
+
+	if (i >= max_port) {
+		dev_err(&pdev->dev, "%s: mapping error! i=%d, idx=%d\n",
+				__func__, i, idx);
+		return -ENODEV;
+	}
 
 	/* Get the io address from configuration space */
 	pci_read_config_word(pdev, config_base + 4, &iobase);
@@ -1604,8 +1638,8 @@ static int pci_fintek_setup(struct serial_private *priv,
 	if (!data)
 		return -ENOMEM;
 
-	/* preserve index in PCI configuration space */
-	*data = idx;
+	/* preserve real index in PCI configuration space */
+	*data = i;
 	port->port.private_data = data;
 
 	return 0;
@@ -1614,12 +1648,40 @@ static int pci_fintek_setup(struct serial_private *priv,
 static int pci_fintek_init(struct pci_dev *dev)
 {
 	unsigned long iobase;
-	u32 max_port, i;
+	u32 max_port, i, j;
 	u32 bar_data[3];
 	u8 config_base;
+	u8 tmp, f0h_data, f3h_data;
+	bool skip_init;
 	struct serial_private *priv = pci_get_drvdata(dev);
 	struct uart_8250_port *port;
 
+	/*
+	 * The PCI board is multi-function, some serial port can converts to
+	 * GPIO function. Customers could changes the F0/F3h values in EEPROM
+	 *
+	 * F0h bit0~5: Enable GPIO0~5
+	 *     bit6~7: Reserve
+	 *
+	 * F3h bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
+	 *		bit0: UART2 pin out for UART2 / GPIO0
+	 *		bit1: UART3 pin out for UART3 / GPIO1
+	 *		bit2: UART8 pin out for UART8 / GPIO2
+	 *		bit3: UART9 pin out for UART9 / GPIO3
+	 *		bit4: UART10 pin out for UART10 / GPIO4
+	 *		bit5: UART11 pin out for UART11 / GPIO5
+	 *     bit6~7: Reserve
+	 */
+	pci_read_config_byte(dev, 0xf0, &f0h_data);
+	pci_read_config_byte(dev, 0xf3, &f3h_data);
+
+	/* find the max set of GPIOs */
+	tmp = f0h_data | ~f3h_data;
+
+	/* rewrite GPIO setting */
+	pci_write_config_byte(dev, 0xf0, tmp & 0x3f);
+	pci_write_config_byte(dev, 0xf3, ~tmp & 0x3f);
+
 	switch (dev->device) {
 	case 0x1104: /* 4 ports */
 	case 0x1108: /* 8 ports */
@@ -1641,6 +1703,32 @@ static int pci_fintek_init(struct pci_dev *dev)
 		/* UART0 configuration offset start from 0x40 */
 		config_base = 0x40 + 0x08 * i;
 
+		skip_init = false;
+
+		/* find every port to check is multi-function port? */
+		for (j = 0; j < ARRAY_SIZE(fintek_gpio_mapping); ++j) {
+			if (fintek_gpio_mapping[j] != i || !(tmp & BIT(j)))
+				continue;
+
+			/*
+			 * This port is multi-function and enabled as gpio
+			 * mode. So we'll not configure it as serial port.
+			 */
+			skip_init = true;
+			break;
+		}
+
+		/*
+		 * If the serial port is setting to gpio mode, don't init it.
+		 * Disable the serial port for user-space application to
+		 * control.
+		 */
+		if (skip_init) {
+			/* Disable current serial port */
+			pci_write_config_byte(dev, config_base + 0x00, 0x00);
+			continue;
+		}
+
 		/* Calculate Real IO Port */
 		iobase = (bar_data[i / 4] & 0xffffffe0) + (i % 4) * 8;
 
@@ -1674,6 +1762,20 @@ static int pci_fintek_init(struct pci_dev *dev)
 		}
 	}
 
+	/* Calculate real serial port number */
+	for (i = 0; i < ARRAY_SIZE(fintek_gpio_mapping); ++i) {
+		switch (dev->device) {
+		case 0x1104: /* 4 ports */
+		case 0x1108: /* 8 ports */
+			if (i >= 2) /* Ignore all bits higher than 0 & 1 */
+				break;
+		case 0x1112: /* 12 ports */
+			if (tmp & BIT(i))
+				--max_port;
+			break;
+		}
+	}
+
 	return max_port;
 }
 
-- 
1.9.1
