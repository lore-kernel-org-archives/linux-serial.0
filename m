From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] serial: mfd: fix bug in serial_hsu_remove()
Date: Mon, 06 Sep 2010 13:41:02 +0100
Message-ID: <20100906124102.1596.96288.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59571 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754491Ab0IFNXp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 09:23:45 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

Medfield HSU driver deal with 4 pci devices(3 uart ports + 1 dma controller),
so in pci remove func, we need handle them differently

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/mfd.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)


diff --git a/drivers/serial/mfd.c b/drivers/serial/mfd.c
index 5aa25e5..af83135 100644
--- a/drivers/serial/mfd.c
+++ b/drivers/serial/mfd.c
@@ -1429,7 +1429,6 @@ static void hsu_global_init(void)
 	}
 
 	phsu = hsu;
-
 	hsu_debugfs_init(hsu);
 	return;
 
@@ -1441,18 +1440,20 @@ err_free_region:
 
 static void serial_hsu_remove(struct pci_dev *pdev)
 {
-	struct hsu_port *hsu;
-	int i;
+	void *priv = pci_get_drvdata(pdev);
+	struct uart_hsu_port *up;
 
-	hsu = pci_get_drvdata(pdev);
-	if (!hsu)
+	if (!priv)
 		return;
 
-	for (i = 0; i < 3; i++)
-		uart_remove_one_port(&serial_hsu_reg, &hsu->port[i].port);
+	/* For port 0/1/2, priv is the address of uart_hsu_port */
+	if (pdev->device != 0x081E) {
+		up = priv;
+		uart_remove_one_port(&serial_hsu_reg, &up->port);
+	}
 
 	pci_set_drvdata(pdev, NULL);
-	free_irq(hsu->irq, hsu);
+	free_irq(pdev->irq, priv);
 	pci_disable_device(pdev);
 }
 

