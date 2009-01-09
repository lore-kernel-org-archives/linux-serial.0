From: akpm@linux-foundation.org
Subject: [patch 1/3] pci: use pci_ioremap_bar() in drivers/serial
Date: Fri, 09 Jan 2009 14:17:40 -0800
Message-ID: <200901092217.n09MHeh2021121@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40526 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759511AbZAIWSR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Jan 2009 17:18:17 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, arjan@linux.intel.com

From: Arjan van de Ven <arjan@linux.intel.com>

Use the newly introduced pci_ioremap_bar() function in drivers/serial. 
pci_ioremap_bar() just takes a pci device and a bar number, with the goal
of making it really hard to get wrong, while also having a central place
to stick sanity checks.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/8250_pci.c |    6 ++----
 drivers/serial/icom.c     |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff -puN drivers/serial/8250_pci.c~pci-use-pci_ioremap_bar-in-drivers-serial drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c~pci-use-pci_ioremap_bar-in-drivers-serial
+++ a/drivers/serial/8250_pci.c
@@ -341,8 +341,7 @@ static int sbs_init(struct pci_dev *dev)
 {
 	u8 __iomem *p;
 
-	p = ioremap_nocache(pci_resource_start(dev, 0),
-						pci_resource_len(dev, 0));
+	p = pci_ioremap_bar(dev, 0);
 
 	if (p == NULL)
 		return -ENOMEM;
@@ -366,8 +365,7 @@ static void __devexit sbs_exit(struct pc
 {
 	u8 __iomem *p;
 
-	p = ioremap_nocache(pci_resource_start(dev, 0),
-					pci_resource_len(dev, 0));
+	p = pci_ioremap_bar(dev, 0);
 	/* FIXME: What if resource_len < OCT_REG_CR_OFF */
 	if (p != NULL)
 		writeb(0, p + OCT_REG_CR_OFF);
diff -puN drivers/serial/icom.c~pci-use-pci_ioremap_bar-in-drivers-serial drivers/serial/icom.c
--- a/drivers/serial/icom.c~pci-use-pci_ioremap_bar-in-drivers-serial
+++ a/drivers/serial/icom.c
@@ -1553,8 +1553,7 @@ static int __devinit icom_probe(struct p
 		goto probe_exit1;
 	}
 
-	 icom_adapter->base_addr = ioremap(icom_adapter->base_addr_pci,
-						pci_resource_len(dev, 0));
+	 icom_adapter->base_addr = pci_ioremap_bar(dev, 0);
 
 	if (!icom_adapter->base_addr)
 		goto probe_exit1;
_
