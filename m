From: Mark Hindley <mark@hindley.org.uk>
Subject: [PATCH] check return of pci_enable_device in 8250_pci.c
Date: Sat, 18 Aug 2007 21:35:39 +0100
Message-ID: <20070818203539.GB7607@hindley.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 83-216-141-215.markhi700.adsl.metronet.co.uk ([83.216.141.215]:3075
	"EHLO mx.hindley.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbXHRVWk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Aug 2007 17:22:40 -0400
Received: from apollo.hindleynet ([192.168.1.3] ident=Debian-exim)
	by mx.hindley.org.uk with esmtp (Exim 4.50)
	id 1IMV1I-0003WW-4J
	for linux-serial@vger.kernel.org; Sat, 18 Aug 2007 21:35:40 +0100
Received: from mark by apollo.hindleynet with local (Exim 4.63)
	(envelope-from <mark@hindley.org.uk>)
	id 1IMV1H-00029G-Hs
	for linux-serial@vger.kernel.org; Sat, 18 Aug 2007 21:35:39 +0100
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

commit 3c1263b4dc81bceef4cd919c804906809e80b8b0
Author: Mark Hindley <mark@hindley.org.uk>
Date:   Sat Aug 18 21:20:26 2007 +0100

    8250_pci.c: Check return of pci_enable_device in pciserial_resume_one.
    
    Signed-off-by: Mark Hindley <mark@hindley.org.uk>

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 5e48587..d0baeac 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1802,6 +1802,7 @@ static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 static int pciserial_resume_one(struct pci_dev *dev)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
+	int err;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -1810,7 +1811,9 @@ static int pciserial_resume_one(struct pci_dev *dev)
 		/*
 		 * The device may have been disabled.  Re-enable it.
 		 */
-		pci_enable_device(dev);
+		err = pci_enable_device(dev);
+		if (err)
+			return err;
 
 		pciserial_resume_ports(priv);
 	}
