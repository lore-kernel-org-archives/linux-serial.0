From: dirk.brandewie@gmail.com
Subject: [PATCH] serial/ce4100: Add PCI UART support for the ce4100
Date: Tue, 30 Nov 2010 13:45:02 -0800
Message-ID: <1291153502-11263-1-git-send-email-dirk.brandewie@gmail.com>
References: <20101109211418.GA15802@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33538 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0K3VpY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Nov 2010 16:45:24 -0500
Received: by iwn10 with SMTP id 10so237370iwn.19
        for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2010 13:45:23 -0800 (PST)
In-Reply-To: <20101109211418.GA15802@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: greg@kroah.com, Dirk Brandewie <dirk.brandewie@gmail.com>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds support for the PCI UART on the ce4100.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
CC: linux-serial@vger.kernel.org
---
 drivers/serial/8250_pci.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 842e3b2..8b8930f 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -957,6 +957,22 @@ pci_default_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
+static int
+ce4100_serial_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_port *port, int idx)
+{
+	int ret;
+
+	ret = setup_port(priv, port, 0, 0, board->reg_shift);
+	port->iotype = UPIO_MEM32;
+	port->type = PORT_XSCALE;
+	port->flags = (port->flags | UPF_FIXED_PORT | UPF_FIXED_TYPE);
+	port->regshift = 2;
+
+	return ret;
+}
+
 static int skip_tx_en_setup(struct serial_private *priv,
 			const struct pciserial_board *board,
 			struct uart_port *port, int idx)
@@ -981,6 +997,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_POCTAL232	0x0308
 #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
+#define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 #define PCI_DEVICE_ID_TITAN_200I	0x8028
 #define PCI_DEVICE_ID_TITAN_400I	0x8048
@@ -1072,6 +1089,13 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= skip_tx_en_setup,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_CE4100_UART,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= ce4100_serial_setup,
+	},
 	/*
 	 * ITE
 	 */
@@ -1592,6 +1616,7 @@ enum pci_board_num_t {
 	pbn_ADDIDATA_PCIe_2_3906250,
 	pbn_ADDIDATA_PCIe_4_3906250,
 	pbn_ADDIDATA_PCIe_8_3906250,
+	pbn_ce4100_1_115200,
 };
 
 /*
@@ -2281,6 +2306,12 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
+	[pbn_ce4100_1_115200] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 921600,
+		.reg_shift      = 2,
+	},
 };
 
 static const struct pci_device_id softmodem_blacklist[] = {
@@ -3765,6 +3796,11 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 		0xA000, 0x3004,
 		0, 0, pbn_b0_bt_4_115200 },
+	/* Intel CE4100 */
+	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
+		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
+		pbn_ce4100_1_115200 },
+
 
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
-- 
1.7.2.3

