From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] pciserial_resume_one() should check the return value of pci_enable_device()
Date: Wed, 14 Feb 2007 13:25:39 +0900
Message-ID: <20070214042539.GA3327@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from koto.vergenet.net ([210.128.90.7]:33111 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302AbXBNEqI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Feb 2007 23:46:08 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

While compiling Linus' tree this morning, I noticed the following warning,
which I believe that the patch below resolves. Of course this assumes
that callers of pci_enable_device check its return value, I haven't 
verified this.

warning: ignoring return value of `pci_enable_device', declared with attribute warn_unused_result

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/drivers/serial/8250_pci.c
===================================================================
--- linux-2.6.orig/drivers/serial/8250_pci.c	2007-02-14 13:05:59.000000000 +0900
+++ linux-2.6/drivers/serial/8250_pci.c	2007-02-14 13:06:07.000000000 +0900
@@ -1819,6 +1819,7 @@
 static int pciserial_resume_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
+	int err;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -1827,7 +1828,9 @@
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		err = pci_enable_device(dev);
+		if (err < 0)
+			return err;
 
 		pciserial_resume_ports(priv);
 	}
