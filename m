From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [PATCH] 8250 PCI Serial driver not always disabling PCI device
Date: Wed, 20 Jul 2005 09:27:05 +0200
Message-ID: <200507200927.06500@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:27082 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261202AbVGTHWz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jul 2005 03:22:55 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.co.uk
Cc: linux-serial@vger.kernel.org

Hi,

I found that pciserial_remove_one() only disables the device if it finds 
private data. This looks suspicious to me. Patch attached.

Eike

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.13-rc3/drivers/serial/8250_pci.c	2005-07-13 06:46:46.000000000 
+0200
+++ linux-2.6.13-rc3-eike/drivers/serial/8250_pci.c	2005-07-20 
09:16:28.000000000 +0200
@@ -1778,10 +1778,10 @@ static void __devexit pciserial_remove_o
 		if (quirk->exit)
 			quirk->exit(dev);
 
-		pci_disable_device(dev);
-
 		kfree(priv);
 	}
+
+	pci_disable_device(dev);
 }
 
 static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
