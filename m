From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] serial/8250_pci: Fix a warning in pciserial_resume_one
Date: Wed, 24 Oct 2007 12:17:33 +0200
Message-ID: <20071024121733.023f962d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-dmz-233-wednesday.dmz.nerim.net ([195.5.254.233]:57358
	"EHLO kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751237AbXJXKks (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Oct 2007 06:40:48 -0400
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [62.4.17.103])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 69C0D230F7
	for <linux-serial@vger.kernel.org>; Wed, 24 Oct 2007 12:19:30 +0200 (CEST)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with ESMTP id 321464F3E5
	for <linux-serial@vger.kernel.org>; Wed, 24 Oct 2007 12:17:27 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Fix the following warning:
drivers/serial/8250_pci.c: In function "pciserial_resume_one":
drivers/serial/8250_pci.c:1998: warning: ignoring return value of "pci_enable_device", declared with attribute warn_unused_result

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
As a side note, I'm curious why the call to pci_enable_device() is
conditioned by priv being set. I'm also not sure if additional cleanups
should be performed if an error occurs.

 drivers/serial/8250_pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc1.orig/drivers/serial/8250_pci.c	2007-10-24 09:59:47.000000000 +0200
+++ linux-2.6.24-rc1/drivers/serial/8250_pci.c	2007-10-24 12:03:26.000000000 +0200
@@ -1987,6 +1987,7 @@ static int pciserial_suspend_one(struct 
 static int pciserial_resume_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
+	int rc;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -1995,7 +1996,9 @@ static int pciserial_resume_one(struct p
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		rc = pci_enable_device(dev);
+		if (rc)
+			return rc;
 
 		pciserial_resume_ports(priv);
 	}


-- 
Jean Delvare
