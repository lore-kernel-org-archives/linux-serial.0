From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] pci: use pci_ioremap_bar() in drivers/serial
Date: Mon, 20 Oct 2008 22:01:58 -0700
Message-ID: <20081020220158.5244f99c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33001 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYJUFBz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2008 01:01:55 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, akpm@linux-foundation.org

>From a7ba162fcd65b21f78143e82bf26bd18ef2c836b Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 28 Sep 2008 16:18:21 -0700
Subject: [PATCH] pci: use pci_ioremap_bar() in drivers/serial

Use the newly introduced pci_ioremap_bar() function in drivers/serial.
pci_ioremap_bar() just takes a pci device and a bar number, with the goal
of making it really hard to get wrong, while also having a central place
to stick sanity checks.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/serial/8250_pci.c |    6 ++----
 drivers/serial/icom.c     |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index c014ffb..e5d6836 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -339,8 +339,7 @@ static int sbs_init(struct pci_dev *dev)
 {
 	u8 __iomem *p;
 
-	p = ioremap_nocache(pci_resource_start(dev, 0),
-						pci_resource_len(dev, 0));
+	p = pci_ioremap_bar(dev, 0);
 
 	if (p == NULL)
 		return -ENOMEM;
@@ -364,8 +363,7 @@ static void __devexit sbs_exit(struct pci_dev *dev)
 {
 	u8 __iomem *p;
 
-	p = ioremap_nocache(pci_resource_start(dev, 0),
-					pci_resource_len(dev, 0));
+	p = pci_ioremap_bar(dev, 0);
 	/* FIXME: What if resource_len < OCT_REG_CR_OFF */
 	if (p != NULL)
 		writeb(0, p + OCT_REG_CR_OFF);
diff --git a/drivers/serial/icom.c b/drivers/serial/icom.c
index 2b7531d..d0085ea 100644
--- a/drivers/serial/icom.c
+++ b/drivers/serial/icom.c
@@ -1553,8 +1553,7 @@ static int __devinit icom_probe(struct pci_dev *dev,
 		goto probe_exit1;
 	}
 
-	 icom_adapter->base_addr = ioremap(icom_adapter->base_addr_pci,
-						pci_resource_len(dev, 0));
+	 icom_adapter->base_addr = pci_ioremap_bar(dev, 0);
 
 	if (!icom_adapter->base_addr)
 		goto probe_exit1;
-- 
1.5.5.1



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
