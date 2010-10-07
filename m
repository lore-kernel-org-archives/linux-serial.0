From: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: [PATCH] jsm: Remove the uart port on errors
Date: Thu,  7 Oct 2010 13:40:42 -0300
Message-ID: <1286469642-18796-1-git-send-email-leitao@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:53929 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab0JGQks (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Oct 2010 12:40:48 -0400
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp01.br.ibm.com (8.14.4/8.13.1) with ESMTP id o97Gs73Z029430
	for <linux-serial@vger.kernel.org>; Thu, 7 Oct 2010 13:54:07 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o97GkxG82924618
	for <linux-serial@vger.kernel.org>; Thu, 7 Oct 2010 13:47:00 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o97GeThl028373
	for <linux-serial@vger.kernel.org>; Thu, 7 Oct 2010 13:40:29 -0300
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, Breno Leitao <leitao@linux.vnet.ibm.com>

If kzmalloc fails, the uart port is not removed causing a leak.
This patch just add another label that removes the uart when the
kzmalloc fails.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
---
 drivers/serial/jsm/jsm_driver.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/jsm/jsm_driver.c b/drivers/serial/jsm/jsm_driver.c
index eaf5450..18f5484 100644
--- a/drivers/serial/jsm/jsm_driver.c
+++ b/drivers/serial/jsm/jsm_driver.c
@@ -172,13 +172,15 @@ static int __devinit jsm_probe_one(struct pci_dev *pdev, const struct pci_device
 		 	jsm_uart_port_init here! */
 		dev_err(&pdev->dev, "memory allocation for flipbuf failed\n");
 		rc = -ENOMEM;
-		goto out_free_irq;
+		goto out_free_uart;
 	}
 
 	pci_set_drvdata(pdev, brd);
 	pci_save_state(pdev);
 
 	return 0;
+ out_free_uart:
+	jsm_remove_uart_port(brd);
  out_free_irq:
 	jsm_remove_uart_port(brd);
 	free_irq(brd->irq, brd);
-- 
1.7.2.3

