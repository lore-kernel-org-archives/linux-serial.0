From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V4 4/4] serial: 8250_pci: Remove Fintek F81504/508/512 UART driver
Date: Tue, 23 Feb 2016 14:30:03 +0800
Message-ID: <1456209003-22396-5-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Remove Fintek F81504/508/512 PCIE-to-UART device driver from 8250_pci.c

Paul recommed us do less code deletion to avoid confusing problem when
bisect.
https://lkml.org/lkml/2016/1/18/646

But this patch is sent after with following patch.
8250: 8250_f81504: Add Fintek F81504/508/512 PCIE-to-UART/GPIO UART support
mfd: f81504-core: Add Fintek F81504/508/512 PCIE-to-UART/GPIO core support

We must remove F81504/508/512 support in 8250_pci.c and migrate to
f81504-core/8250_f81504 to enable MFD support and Andy recommend me to
add these this in blacklist to avoid probed by 8250_pci.c

Suggested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 206 +------------------------------------
 1 file changed, 5 insertions(+), 201 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e71ec78..24a669c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1532,156 +1532,6 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 	return ret;
 }
 
-/* RTS will control by MCR if this bit is 0 */
-#define FINTEK_RTS_CONTROL_BY_HW	BIT(4)
-/* only worked with FINTEK_RTS_CONTROL_BY_HW on */
-#define FINTEK_RTS_INVERT		BIT(5)
-
-/* We should do proper H/W transceiver setting before change to RS485 mode */
-static int pci_fintek_rs485_config(struct uart_port *port,
-			       struct serial_rs485 *rs485)
-{
-	u8 setting;
-	u8 *index = (u8 *) port->private_data;
-	struct pci_dev *pci_dev = container_of(port->dev, struct pci_dev,
-						dev);
-
-	pci_read_config_byte(pci_dev, 0x40 + 8 * *index + 7, &setting);
-
-	if (!rs485)
-		rs485 = &port->rs485;
-	else if (rs485->flags & SER_RS485_ENABLED)
-		memset(rs485->padding, 0, sizeof(rs485->padding));
-	else
-		memset(rs485, 0, sizeof(*rs485));
-
-	/* F81504/508/512 not support RTS delay before or after send */
-	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
-
-	if (rs485->flags & SER_RS485_ENABLED) {
-		/* Enable RTS H/W control mode */
-		setting |= FINTEK_RTS_CONTROL_BY_HW;
-
-		if (rs485->flags & SER_RS485_RTS_ON_SEND) {
-			/* RTS driving high on TX */
-			setting &= ~FINTEK_RTS_INVERT;
-		} else {
-			/* RTS driving low on TX */
-			setting |= FINTEK_RTS_INVERT;
-		}
-
-		rs485->delay_rts_after_send = 0;
-		rs485->delay_rts_before_send = 0;
-	} else {
-		/* Disable RTS H/W control mode */
-		setting &= ~(FINTEK_RTS_CONTROL_BY_HW | FINTEK_RTS_INVERT);
-	}
-
-	pci_write_config_byte(pci_dev, 0x40 + 8 * *index + 7, setting);
-
-	if (rs485 != &port->rs485)
-		port->rs485 = *rs485;
-
-	return 0;
-}
-
-static int pci_fintek_setup(struct serial_private *priv,
-			    const struct pciserial_board *board,
-			    struct uart_8250_port *port, int idx)
-{
-	struct pci_dev *pdev = priv->dev;
-	u8 *data;
-	u8 config_base;
-	u16 iobase;
-
-	config_base = 0x40 + 0x08 * idx;
-
-	/* Get the io address from configuration space */
-	pci_read_config_word(pdev, config_base + 4, &iobase);
-
-	dev_dbg(&pdev->dev, "%s: idx=%d iobase=0x%x", __func__, idx, iobase);
-
-	port->port.iotype = UPIO_PORT;
-	port->port.iobase = iobase;
-	port->port.rs485_config = pci_fintek_rs485_config;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(u8), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	/* preserve index in PCI configuration space */
-	*data = idx;
-	port->port.private_data = data;
-
-	return 0;
-}
-
-static int pci_fintek_init(struct pci_dev *dev)
-{
-	unsigned long iobase;
-	u32 max_port, i;
-	u32 bar_data[3];
-	u8 config_base;
-	struct serial_private *priv = pci_get_drvdata(dev);
-	struct uart_8250_port *port;
-
-	switch (dev->device) {
-	case 0x1104: /* 4 ports */
-	case 0x1108: /* 8 ports */
-		max_port = dev->device & 0xff;
-		break;
-	case 0x1112: /* 12 ports */
-		max_port = 12;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Get the io address dispatch from the BIOS */
-	pci_read_config_dword(dev, 0x24, &bar_data[0]);
-	pci_read_config_dword(dev, 0x20, &bar_data[1]);
-	pci_read_config_dword(dev, 0x1c, &bar_data[2]);
-
-	for (i = 0; i < max_port; ++i) {
-		/* UART0 configuration offset start from 0x40 */
-		config_base = 0x40 + 0x08 * i;
-
-		/* Calculate Real IO Port */
-		iobase = (bar_data[i / 4] & 0xffffffe0) + (i % 4) * 8;
-
-		/* Enable UART I/O port */
-		pci_write_config_byte(dev, config_base + 0x00, 0x01);
-
-		/* Select 128-byte FIFO and 8x FIFO threshold */
-		pci_write_config_byte(dev, config_base + 0x01, 0x33);
-
-		/* LSB UART */
-		pci_write_config_byte(dev, config_base + 0x04,
-				(u8)(iobase & 0xff));
-
-		/* MSB UART */
-		pci_write_config_byte(dev, config_base + 0x05,
-				(u8)((iobase & 0xff00) >> 8));
-
-		pci_write_config_byte(dev, config_base + 0x06, dev->irq);
-
-		if (priv) {
-			/* re-apply RS232/485 mode when
-			 * pciserial_resume_ports()
-			 */
-			port = serial8250_get_port(priv->line[i]);
-			pci_fintek_rs485_config(&port->port, NULL);
-		} else {
-			/* First init without port data
-			 * force init to RS232 Mode
-			 */
-			pci_write_config_byte(dev, config_base + 0x07, 0x01);
-		}
-	}
-
-	return max_port;
-}
-
 static int skip_tx_en_setup(struct serial_private *priv,
 			const struct pciserial_board *board,
 			struct uart_8250_port *port, int idx)
@@ -2726,31 +2576,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_brcm_trumanage_setup,
 	},
-	{
-		.vendor		= 0x1c29,
-		.device		= 0x1104,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fintek_setup,
-		.init		= pci_fintek_init,
-	},
-	{
-		.vendor		= 0x1c29,
-		.device		= 0x1108,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fintek_setup,
-		.init		= pci_fintek_init,
-	},
-	{
-		.vendor		= 0x1c29,
-		.device		= 0x1112,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_fintek_setup,
-		.init		= pci_fintek_init,
-	},
-
 	/*
 	 * Default "match everything" terminator entry
 	 */
@@ -2952,9 +2777,6 @@ enum pci_board_num_t {
 	pbn_omegapci,
 	pbn_NETMOS9900_2s_115200,
 	pbn_brcm_trumanage,
-	pbn_fintek_4,
-	pbn_fintek_8,
-	pbn_fintek_12,
 	pbn_wch384_4,
 	pbn_pericom_PI7C9X7951,
 	pbn_pericom_PI7C9X7952,
@@ -3757,24 +3579,6 @@ static struct pciserial_board pci_boards[] = {
 		.reg_shift	= 2,
 		.base_baud	= 115200,
 	},
-	[pbn_fintek_4] = {
-		.num_ports	= 4,
-		.uart_offset	= 8,
-		.base_baud	= 115200,
-		.first_offset	= 0x40,
-	},
-	[pbn_fintek_8] = {
-		.num_ports	= 8,
-		.uart_offset	= 8,
-		.base_baud	= 115200,
-		.first_offset	= 0x40,
-	},
-	[pbn_fintek_12] = {
-		.num_ports	= 12,
-		.uart_offset	= 8,
-		.base_baud	= 115200,
-		.first_offset	= 0x40,
-	},
 	[pbn_wch384_4] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
@@ -3829,6 +3633,11 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(INTEL, 0x081d), },
 	{ PCI_VDEVICE(INTEL, 0x1191), },
 	{ PCI_VDEVICE(INTEL, 0x19d8), },
+
+	/* Fintek F81504/508/512. It'll handle by MFD f81504-core.c */
+	{ PCI_DEVICE(0x1c29, 0x1104), },
+	{ PCI_DEVICE(0x1c29, 0x1108), },
+	{ PCI_DEVICE(0x1c29, 0x1112), },
 };
 
 /*
@@ -5610,11 +5419,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0,
 		0, pbn_exar_XR17V358 },
 
-	/* Fintek PCI serial cards */
-	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
-	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
-	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data = pbn_fintek_12 },
-
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
-- 
1.9.1
