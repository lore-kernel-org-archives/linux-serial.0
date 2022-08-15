Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8542FC00140
	for <linux-serial@archiver.kernel.org>; Mon, 15 Aug 2022 12:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiHOMNq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiHOMN3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Aug 2022 08:13:29 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C049E252BA
        for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2022 05:13:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NYqxo2sw0XaJmNYqxoyvCx; Mon, 15 Aug 2022 14:05:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 14:05:56 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: icom: Fix some indentation
Date:   Mon, 15 Aug 2022 14:05:50 +0200
Message-Id: <037fc7510ff88945e3f0a5756de4cfd135c59849.1660565015.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

checkpatch and smatch report some code alignment issues.

So remove some unneeded leading spaces to fix the warnings.

While at it remove some {} around a single statement and convert some
spaces into a tab.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/icom.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 45df29947fe8..3ac81622c4fb 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1727,10 +1727,10 @@ static int icom_probe(struct pci_dev *dev,
 
 	retval = pci_request_regions(dev, "icom");
 	if (retval) {
-		 dev_err(&dev->dev, "pci_request_regions FAILED\n");
-		 pci_disable_device(dev);
-		 return retval;
-	 }
+		dev_err(&dev->dev, "pci_request_regions FAILED\n");
+		pci_disable_device(dev);
+		return retval;
+	}
 
 	pci_set_master(dev);
 
@@ -1754,9 +1754,9 @@ static int icom_probe(struct pci_dev *dev,
 
 	retval = icom_alloc_adapter(&icom_adapter);
 	if (retval) {
-		 dev_err(&dev->dev, "icom_alloc_adapter FAILED\n");
-		 retval = -EIO;
-		 goto probe_exit0;
+		dev_err(&dev->dev, "icom_alloc_adapter FAILED\n");
+		retval = -EIO;
+		goto probe_exit0;
 	}
 
 	icom_adapter->base_addr_pci = pci_resource_start(dev, 0);
@@ -1778,11 +1778,10 @@ static int icom_probe(struct pci_dev *dev,
 		goto probe_exit1;
 	}
 
-	 /* save off irq and request irq line */
-	 retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
-	 if (retval) {
-		  goto probe_exit2;
-	 }
+	/* save off irq and request irq line */
+	retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
+	if (retval)
+		goto probe_exit2;
 
 	retval = icom_load_ports(icom_adapter);
 
@@ -1798,11 +1797,11 @@ static int icom_probe(struct pci_dev *dev,
 			icom_port->uart_port.fifosize = 16;
 			icom_port->uart_port.ops = &icom_ops;
 			icom_port->uart_port.line =
-		        icom_port->port + icom_adapter->index * 4;
+			icom_port->port + icom_adapter->index * 4;
 			if (uart_add_one_port (&icom_uart_driver, &icom_port->uart_port)) {
 				icom_port->status = ICOM_PORT_OFF;
 				dev_err(&dev->dev, "Device add failed\n");
-			 } else
+			} else
 				dev_info(&dev->dev, "Device added\n");
 		}
 	}
-- 
2.34.1

