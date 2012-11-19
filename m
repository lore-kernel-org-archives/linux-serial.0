From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 370/493] tty: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:19 -0500
Message-ID: <1353349642-3677-370-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41486 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2KSSep (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 13:34:45 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Alan Cox <alan@linux.intel.com> 
Cc: linux-serial@vger.kernel.org 
---
 drivers/tty/nozomi.c              | 2 +-
 drivers/tty/serial/8250/8250_em.c | 2 +-
 drivers/tty/serial/mfd.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 645f54a..e067e5f 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -400,7 +400,7 @@ struct buffer {
 } __attribute__ ((packed));
 
 /*    Global variables */
-static const struct pci_device_id nozomi_pci_tbl[] __devinitconst = {
+static const struct pci_device_id nozomi_pci_tbl[] = {
 	{PCI_DEVICE(0x1931, 0x000c)},	/* Nozomi HSDPA */
 	{},
 };
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index f59bff5..430bf42 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -163,7 +163,7 @@ static int __devexit serial8250_em_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id serial8250_em_dt_ids[] __devinitconst = {
+static const struct of_device_id serial8250_em_dt_ids[] = {
 	{ .compatible = "renesas,em-uart", },
 	{},
 };
diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 71c4c8e..26e02f5 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1456,7 +1456,7 @@ static void serial_hsu_remove(struct pci_dev *pdev)
 }
 
 /* First 3 are UART ports, and the 4th is the DMA */
-static const struct pci_device_id pci_ids[] __devinitconst = {
+static const struct pci_device_id pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081B) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081C) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081D) },
-- 
1.8.0

