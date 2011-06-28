From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/12] 8250_pci: add -ENODEV code for Intel EG20T PCH
Date: Tue, 28 Jun 2011 09:03:38 -0700
Message-ID: <1309277029-1532-1-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58141 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758843Ab1F1QDx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:03:53 -0400
In-Reply-To: <20110628153856.GB32710@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Intel EG20T PCH has UART device which is compatible with 8250.
Currently, with general configuration, the PCH UART driver is not loaded
but 8250 standard driver is loaded.  Therefore, in case of using PCH
UART driver, need to disable 8250 pci function.  However, this procedure
is not best solution.  This patch, in 8250_pci, if the device is the PCH
or the family IOH, '-ENODEV' is returned.  As a result, disabling
8250-pci processing becomes unnecessary.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |   59 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 4b4968a..d7dc513 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -994,6 +994,15 @@ static int skip_tx_en_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+static int pci_eg20t_init(struct pci_dev *dev)
+{
+#if defined(CONFIG_SERIAL_PCH_UART) || defined(CONFIG_SERIAL_PCH_UART_MODULE)
+	return -ENODEV;
+#else
+	return 0;
+#endif
+}
+
 /* This should be in linux/pci_ids.h */
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
@@ -1446,6 +1455,56 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.init			= pci_oxsemi_tornado_init,
 		.setup		= pci_default_setup,
 	},
+	{
+		.vendor         = PCI_VENDOR_ID_INTEL,
+		.device         = 0x8811,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_INTEL,
+		.device         = 0x8812,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_INTEL,
+		.device         = 0x8813,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = PCI_VENDOR_ID_INTEL,
+		.device         = 0x8814,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = 0x10DB,
+		.device         = 0x8027,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = 0x10DB,
+		.device         = 0x8028,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = 0x10DB,
+		.device         = 0x8029,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = 0x10DB,
+		.device         = 0x800C,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = 0x10DB,
+		.device         = 0x800D,
+		.init		= pci_eg20t_init,
+	},
+	{
+		.vendor         = 0x10DB,
+		.device         = 0x800D,
+		.init		= pci_eg20t_init,
+	},
 	/*
 	 * Cronyx Omega PCI (PLX-chip based)
 	 */
-- 
1.7.5.4

