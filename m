From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 67/79] 8250_pci: Fix kernel panic when pch_uart is disabled
Date: Wed, 26 Oct 2011 14:13:12 +0200
Message-ID: <1319631204-23262-67-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32858 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932956Ab1JZMOA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:14:00 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>

Currently, ".setup" function is not set.
As a result, when detecting our IOH's uart device without pch_uart, kernel panic
occurs at the following of pciserial_init_ports().

	for (i = 0; i < nr_ports; i++) {
		if (quirk->setup(priv, board, &serial_port, i))
			break;

So, this patch adds the ".setup" function.
We can use pci_default_setup because our IOH's uart is compatible with 16550.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index a79caba..1b449b7 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -1591,51 +1591,61 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8812,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8813,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8814,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x8027,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x8028,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x8029,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x800C,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x800D,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	{
 		.vendor         = 0x10DB,
 		.device         = 0x800D,
 		.init		= pci_eg20t_init,
+		.setup		= pci_default_setup,
 	},
 	/*
 	 * Cronyx Omega PCI (PLX-chip based)
-- 
1.7.7

