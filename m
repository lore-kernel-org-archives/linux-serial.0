From: Mathieu OTHACEHE <m.othacehe@gmail.com>
Subject: [PATCH] serial: 8250_pci: add MOXA Smartio MUE boards support
Date: Fri, 12 Feb 2016 19:28:50 +0100
Message-ID: <1455301730-24333-1-git-send-email-m.othacehe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, JBeulich@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu OTHACEHE <m.othacehe@gmail.com>
List-Id: linux-serial@vger.kernel.org

Add support for :

- CP-102E: 2 ports RS232 PCIE card
- CP-102EL: 2 ports RS232 PCIE card
- CP-132EL: 2 ports RS422/485 PCIE card
- CP-114EL: 4 ports RS232/422/485 PCIE card
- CP-104EL-A: 4 ports RS232 PCIE card
- CP-168EL-A: 8 ports RS232 PCIE card
- CP-118EL-A: 8 ports RS232/422/485 PCIE card
- CP-118E-A: 8 ports RS422/485 PCIE card
- CP-138E-A: 8 ports RS422/485 PCIE card
- CP-134EL-A: 4 ports RS422/485 PCIE card
- CP-116E-A (A): 8 ports RS232/422/485 PCIE card
- CP-116E-A (B): 8 ports RS232/422/485 PCIE card

Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
---

Hi,

This patch add support for MOXA Smartio MUE boards to 8250 driver.
I already submitted an independant driver based on the vendor one :

https://lkml.org/lkml/2016/2/1/720

But as Andy pointed out, it seems to be a better idea to add this support
directly in 8250 driver.
I was able to test this patch on a CP-168EL-A on PC.

Mathieu

 drivers/tty/serial/8250/8250_pci.c | 193 +++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8f8d5c5..67c1028 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1862,6 +1862,25 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+static int pci_mxupcie_setup(struct serial_private *priv,
+			     const struct pciserial_board *board,
+			     struct uart_8250_port *port, int idx)
+{
+	unsigned int bar, offset;
+
+	/*
+	 * MOXA Smartio MUE boards with 4 ports have
+	 * a different offset for port #3
+	 */
+	if (idx == 3) {
+		bar = FL_GET_BASE(board->flags);
+		offset = 7 * board->uart_offset;
+		return setup_port(priv, port, bar, offset, board->reg_shift);
+	} else {
+		return pci_default_setup(priv, board, port, idx);
+	}
+}
+
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
@@ -1927,6 +1946,19 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
 #define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958
 
+#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
+#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
+#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
+#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
+#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
+#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
+#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
+#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
+#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
+#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
+#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
+#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
+
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
@@ -2727,6 +2759,30 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_fintek_setup,
 		.init		= pci_fintek_init,
 	},
+	/*
+	 * MOXA Smartio MUE 4 ports boards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MOXA,
+		.device		= PCI_DEVICE_ID_MOXA_CP114EL,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_mxupcie_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MOXA,
+		.device		= PCI_DEVICE_ID_MOXA_CP104EL_A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_mxupcie_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MOXA,
+		.device		= PCI_DEVICE_ID_MOXA_CP134EL_A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_mxupcie_setup,
+	},
 
 	/*
 	 * Default "match everything" terminator entry
@@ -2938,6 +2994,19 @@ enum pci_board_num_t {
 	pbn_pericom_PI7C9X7952,
 	pbn_pericom_PI7C9X7954,
 	pbn_pericom_PI7C9X7958,
+	pbn_moxa_CP102E,
+	pbn_moxa_CP102EL,
+	pbn_moxa_CP132EL,
+	pbn_moxa_CP114EL,
+	pbn_moxa_CP104EL_A,
+	pbn_moxa_CP168EL_A,
+	pbn_moxa_CP118EL_A,
+	pbn_moxa_CP118E_A_I,
+	pbn_moxa_CP138E_A,
+	pbn_moxa_CP134EL_A,
+	pbn_moxa_CP116E_A_A,
+	pbn_moxa_CP116E_A_B
+
 };
 
 /*
@@ -3794,6 +3863,81 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	/*
+	 * MOXA Smartio MUE boards
+	 */
+	[pbn_moxa_CP102E] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 2,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP102EL] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 2,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP132EL] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 2,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP114EL] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP104EL_A] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP168EL_A] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP118EL_A] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP118E_A_I] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP138E_A] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP134EL_A] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP116E_A_A] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa_CP116E_A_B] = {
+		.flags          = FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
 };
 
 static const struct pci_device_id blacklist[] = {
@@ -5604,6 +5748,55 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
 	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data = pbn_fintek_12 },
 
+	/* MOXA Smartio MUE PCI serial cards */
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP102E },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP102EL },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP132EL },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP114EL },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP104EL_A },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP168EL_A },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP118EL_A },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP118E_A_I },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP138E_A },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP134EL_A },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP116E_A_A },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_moxa_CP116E_A_B },
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
-- 
2.7.0
