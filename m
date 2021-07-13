Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6003C07E96
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C82761249
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhGMKnB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:43:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:15385 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235632AbhGMKm7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 06:42:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="189823012"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="189823012"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="649355774"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2021 03:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99CC62B6; Tue, 13 Jul 2021 13:40:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
Date:   Tue, 13 Jul 2021 13:40:25 +0300
Message-Id: <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to try MSI/MSI-X only on selected devices.
If MSI is not supported while neing advertised it means device
is broken and we rather introduce a list of such devices which
hopefully will be small or never appear.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 937861327aca..02825c8c5f84 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -58,18 +58,6 @@ struct serial_private {
 
 #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
 
-static const struct pci_device_id pci_use_msi[] = {
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9912,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
-			 0xA000, 0x1000) },
-	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
-			 PCI_ANY_ID, PCI_ANY_ID) },
-	{ }
-};
-
 static int pci_default_setup(struct serial_private*,
 	  const struct pciserial_board*, struct uart_8250_port *, int);
 
@@ -3994,14 +3982,9 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	if (board->flags & FL_NOIRQ) {
 		uart.port.irq = 0;
 	} else {
-		if (pci_match_id(pci_use_msi, dev)) {
-			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
-			pci_set_master(dev);
-			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
-		} else {
-			dev_dbg(&dev->dev, "Using legacy interrupts\n");
-			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
-		}
+		pci_set_master(dev);
+
+		rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
 		if (rc < 0) {
 			kfree(priv);
 			priv = ERR_PTR(rc);
@@ -4009,6 +3992,11 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 		}
 
 		uart.port.irq = pci_irq_vector(dev, 0);
+
+		if (pci_dev_msi_enabled(dev))
+			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
+		else
+			dev_dbg(&dev->dev, "Using legacy interrupts\n");
 	}
 
 	uart.port.dev = &dev->dev;
-- 
2.30.2

