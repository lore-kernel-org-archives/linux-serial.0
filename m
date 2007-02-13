From: Stefano Brivio <stefano.brivio@polimi.it>
Subject: [PATCH] fix error management in 8250_pci.c pciserial_resume_one
Date: Tue, 13 Feb 2007 11:30:10 +0100
Message-ID: <20070213113010.27125d53@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mfe1.polimi.it ([131.175.12.23]:43273 "EHLO polimi.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751257AbXBMKvH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Feb 2007 05:51:07 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

  CC      drivers/serial/8250_pci.o
drivers/serial/8250_pci.c: In function 'pciserial_resume_one':
drivers/serial/8250_pci.c:1830: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result

This patch fixes it.

Signed-off-by: Stefano Brivio <stefano.brivio@polimi.it>
---

--- drivers/serial/8250_pci.c.orig	2007-02-13 11:04:03.579805618 +0100
+++ drivers/serial/8250_pci.c	2007-02-13 11:12:52.128454010 +0100
@@ -1819,6 +1819,7 @@
 static int pciserial_resume_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
+	int rc;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -1827,7 +1828,9 @@
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		rc = pci_enable_device(dev);
+		if (rc)
+			return rc;
 
 		pciserial_resume_ports(priv);
 	}
