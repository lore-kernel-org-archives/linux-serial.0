From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH] tty/8250 Add support for Commtech's Fastcom Async-335 and
 Fastcom Async-PCIe cards
Date: Wed, 21 Nov 2012 09:17:29 -0600
Message-ID: <CAJp1Oe7syKV54oOisSO=DX+hBaZxugSqQoHXoCPmDVWUiT1dOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45500 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab2KUPRu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 10:17:50 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1725845vbb.19
        for <linux-serial@vger.kernel.org>; Wed, 21 Nov 2012 07:17:49 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Add support for Commtech's Fastcom Async-335 and Fastcom Async-PCIe cards

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

This depends on my previous patch submissions:
[PATCH v3] Add support for new devices: Exar's XR17V35x family of
multi-port PCIe UARTs
[PATCH 1/2] tty/8250: Add sleep capability to XR17D15X ports
[PATCH 2/2] tty/8250 Add XR17D15x devices to the exar_handle_irq override
[PATCH 1/3] Add register definitions used in several Exar PCI/PCIe UARTs

 drivers/tty/serial/8250/8250_pci.c |  159 ++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h            |    2 +
 2 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c
b/drivers/tty/serial/8250/8250_pci.c
index c422871..6a7007c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1198,6 +1198,48 @@ pci_xr17v35x_setup(struct serial_private *priv,
 }

 static int
+pci_fastcom335_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	u8 __iomem *p;
+
+	p = pci_ioremap_bar(priv->dev, 0);
+
+	port->port.flags |= UPF_EXAR_EFR;
+
+	/*
+	 * Setup Multipurpose Input/Output pins.
+	 */
+	if (idx == 0) {
+		switch (priv->dev->device) {
+		case 0x04: /* PCI_DEVICE_ID_COMMTECH_4222PCI335 */
+		case 0x02: /* PCI_DEVICE_ID_COMMTECH_4224PCI335 */
+			writeb(0x78, p + 0x90); /* MPIOLVL[7:0] */
+			writeb(0x00, p + 0x92); /* MPIOINV[7:0] */
+			writeb(0x00, p + 0x93); /* MPIOSEL[7:0] */
+			break;
+		case 0x0a: /* PCI_DEVICE_ID_COMMTECH_2324PCI335 */
+		case 0x0b: /* PCI_DEVICE_ID_COMMTECH_2328PCI335 */
+			writeb(0x00, p + 0x90); /* MPIOLVL[7:0] */
+			writeb(0xc0, p + 0x92); /* MPIOINV[7:0] */
+			writeb(0xc0, p + 0x93); /* MPIOSEL[7:0] */
+			break;
+		}
+		writeb(0x00, p + 0x8f); /* MPIOINT[7:0] */
+		writeb(0x00, p + 0x91); /* MPIO3T[7:0] */
+		writeb(0x00, p + 0x94); /* MPIOOD[7:0] */
+	}
+	writeb(0x00, p + UART_EXAR_8XMODE);
+	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
+	writeb(32, p + UART_EXAR_TXTRG);
+	writeb(32, p + UART_EXAR_RXTRG);
+	iounmap(p);
+
+	return pci_default_setup(priv, board, port, idx);
+}
+
+static int
 pci_wch_ch353_setup(struct serial_private *priv,
                     const struct pciserial_board *board,
                     struct uart_8250_port *port, int idx)
@@ -1246,6 +1288,13 @@ pci_wch_ch353_setup(struct serial_private *priv,
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_VENDOR_ID_ASIX		0x9710
+#define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
+#define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
+#define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a
+#define PCI_DEVICE_ID_COMMTECH_2328PCI335 0x000b
+#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
+#define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
+#define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021

 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -1842,6 +1891,59 @@ static struct pci_serial_quirk
pci_serial_quirks[] __refdata = {
 		.setup		= pci_asix_setup,
 	},
 	/*
+	 * Commtech, Inc. Fastcom adapters
+	 *
+	 */
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_4222PCI335,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fastcom335_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_4224PCI335,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fastcom335_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_2324PCI335,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fastcom335_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_2328PCI335,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_fastcom335_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_4222PCIE,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_xr17v35x_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_4224PCIE,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_xr17v35x_setup,
+	},
+	{
+		.vendor = PCI_VENDOR_ID_COMMTECH,
+		.device = PCI_DEVICE_ID_COMMTECH_4228PCIE,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_xr17v35x_setup,
+	},
+	/*
 	 * Default "match everything" terminator entry
 	 */
 	{
@@ -1917,6 +2019,10 @@ enum pci_board_num_t {

 	pbn_b0_4_1152000,

+	pbn_b0_2_1152000_200,
+	pbn_b0_4_1152000_200,
+	pbn_b0_8_1152000_200,
+
 	pbn_b0_2_1843200,
 	pbn_b0_4_1843200,

@@ -2114,6 +2220,27 @@ static struct pciserial_board pci_boards[]
__devinitdata = {
 		.uart_offset	= 8,
 	},

+	[pbn_b0_2_1152000_200] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 1152000,
+		.uart_offset	= 0x200,
+	},
+
+	[pbn_b0_4_1152000_200] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 1152000,
+		.uart_offset	= 0x200,
+	},
+
+	[pbn_b0_8_1152000_200] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 1152000,
+		.uart_offset	= 0x200,
+	},
+
 	[pbn_b0_2_1843200] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 2,
@@ -4353,6 +4480,38 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0, 0, pbn_b0_bt_2_115200 },

 	/*
+	 * Commtech, Inc. Fastcom adapters
+	 */
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCI335,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_b0_2_1152000_200 },
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCI335,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_b0_4_1152000_200 },
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_2324PCI335,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_b0_4_1152000_200 },
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_2328PCI335,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_b0_8_1152000_200 },
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCIE,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17V352 },
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCIE,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17V354 },
+	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4228PCIE,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17V358 },
+
+	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0199a7a..0f84473 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2326,6 +2326,8 @@

 #define PCI_VENDOR_ID_TOPSPIN		0x1867

+#define PCI_VENDOR_ID_COMMTECH		0x18f7
+
 #define PCI_VENDOR_ID_SILAN		0x1904

 #define PCI_VENDOR_ID_RENESAS		0x1912
-- 
1.7.2.5
