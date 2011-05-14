From: Antony Pavlov <antony@niisi.msk.ru>
Subject: [PATCH] serial: 8250_pci: add support for Cronyx Omega PCI multiserial board.
Date: Sat, 14 May 2011 08:39:32 +0400
Message-ID: <1305347972-19321-1-git-send-email-antony@niisi.msk.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from t111.niisi.ras.ru ([193.232.173.111]:50123 "EHLO
	t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab1ENE3w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 May 2011 00:29:52 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Antony Pavlov <antony@niisi.msk.ru>

This patch adds support for the Omega-PCI, an 8-port asynchronous
multiport adapter for computers with PCI bus [1].

[1] http://www.cronyx.ru/hardware/ompci.html

Signed-off-by: Antony Pavlov <antony@niisi.msk.ru>
---
 drivers/tty/serial/8250_pci.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 738cec9..b3b8bac 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -973,6 +973,14 @@ ce4100_serial_setup(struct serial_private *priv,
 	return ret;
 }
 
+static int
+pci_omegapci_setup(struct serial_private *priv,
+		      struct pciserial_board *board,
+		      struct uart_port *port, int idx)
+{
+	return setup_port(priv, port, 2, idx * 8, 0);
+}
+
 static int skip_tx_en_setup(struct serial_private *priv,
 			const struct pciserial_board *board,
 			struct uart_port *port, int idx)
@@ -1012,6 +1020,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_TITAN_200EI	0xA016
 #define PCI_DEVICE_ID_TITAN_200EISI	0xA017
 #define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
+#define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -1296,6 +1305,16 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.exit		= __devexit_p(pci_plx9050_exit),
 	},
 	/*
+	 * Cronyx Omega PCI (PLX-chip based)
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= PCI_DEVICE_ID_PLX_CRONYX_OMEGA,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_omegapci_setup,
+	 },
+	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 232
 	 */
 	{
@@ -1617,6 +1636,7 @@ enum pci_board_num_t {
 	pbn_ADDIDATA_PCIe_4_3906250,
 	pbn_ADDIDATA_PCIe_8_3906250,
 	pbn_ce4100_1_115200,
+	pbn_omegapci,
 };
 
 /*
@@ -2312,6 +2332,12 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 		.base_baud	= 921600,
 		.reg_shift      = 2,
 	},
+	[pbn_omegapci] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 115200,
+		.uart_offset	= 0x200,
+	},
 };
 
 static const struct pci_device_id softmodem_blacklist[] = {
@@ -3801,6 +3827,12 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
 		pbn_ce4100_1_115200 },
 
+	/*
+	 * Cronyx Omega PCI
+	 */
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_omegapci },
 
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
-- 
1.7.1

