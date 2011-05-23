From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 48/48] serial: 8250_pci: add support for Cronyx Omega PCI multiserial board.
Date: Mon, 23 May 2011 12:10:54 -0700
Message-ID: <1306177854-18172-48-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47376 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324Ab1EWTMf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:12:35 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Antony Pavlov <antony@niisi.msk.ru>, Greg Kroah-Hartman <gregkh@suse.de>

From: Antony Pavlov <antony@niisi.msk.ru>

This patch adds support for the Omega-PCI, an 8-port asynchronous
multiport adapter for computers with PCI bus [1].

[1] http://www.cronyx.ru/hardware/ompci.html

Signed-off-by: Antony Pavlov <antony@niisi.msk.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 762db97..4b4968a 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -971,6 +971,14 @@ ce4100_serial_setup(struct serial_private *priv,
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
@@ -1011,6 +1019,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_TITAN_200EISI	0xA017
 #define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
+#define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -1438,6 +1447,16 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_default_setup,
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
 	 * Default "match everything" terminator entry
 	 */
 	{
@@ -1624,6 +1643,7 @@ enum pci_board_num_t {
 	pbn_ADDIDATA_PCIe_4_3906250,
 	pbn_ADDIDATA_PCIe_8_3906250,
 	pbn_ce4100_1_115200,
+	pbn_omegapci,
 };
 
 /*
@@ -2319,6 +2339,12 @@ static struct pciserial_board pci_boards[] __devinitdata = {
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
@@ -3816,6 +3842,12 @@ static struct pci_device_id serial_pci_tbl[] = {
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
1.7.4.2

