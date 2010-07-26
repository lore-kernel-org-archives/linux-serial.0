From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/4] hsu: call PCI pm hooks in suspend/resume function
Date: Mon, 26 Jul 2010 10:18:46 +0100
Message-ID: <20100726091839.21579.4983.stgit@localhost.localdomain>
References: <20100726091542.21579.55123.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61522 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab0GZJv5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jul 2010 05:51:57 -0400
In-Reply-To: <20100726091542.21579.55123.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

Also add check for dma controller or the uart ports.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/mfd.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)


diff --git a/drivers/serial/mfd.c b/drivers/serial/mfd.c
index 28cb3ac..9a7a388 100644
--- a/drivers/serial/mfd.c
+++ b/drivers/serial/mfd.c
@@ -1217,25 +1217,38 @@ static struct uart_driver serial_hsu_reg = {
 #ifdef CONFIG_PM
 static int serial_hsu_suspend(struct pci_dev *pdev, pm_message_t state)
 {
+	void *priv = pci_get_drvdata(pdev);
 	struct uart_hsu_port *up;
 
-	up = pci_get_drvdata(pdev);
-	if (!up)
-		return 0;
-
-	uart_suspend_port(&serial_hsu_reg, &up->port);
+	/* Make sure this is not the internal dma controller */
+	if (priv && (pdev->device != 0x081E)) {
+		up = priv;
+		uart_suspend_port(&serial_hsu_reg, &up->port);
+	}
 
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
         return 0;
 }
 
 static int serial_hsu_resume(struct pci_dev *pdev)
 {
+	void *priv = pci_get_drvdata(pdev);
 	struct uart_hsu_port *up;
+	int ret;
 
-	up = pci_get_drvdata(pdev);
-	if (!up)
-		return 0;
-	uart_resume_port(&serial_hsu_reg, &up->port);
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		dev_warn(&pdev->dev,
+			"HSU: can't re-enable device, try to continue\n");
+
+	if (priv && (pdev->device != 0x081E)) {
+		up = priv;
+		uart_resume_port(&serial_hsu_reg, &up->port);
+	}
 	return 0;
 }
 #else

