From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] CONFIG_PM=n slim: drivers/serial/8250_pci.c
Date: Sat, 12 Aug 2006 02:12:55 +0400
Message-ID: <20060811221255.GF6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:8114 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964789AbWHKWM6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Aug 2006 18:12:58 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1001830ugc
        for <linux-serial@vger.kernel.org>; Fri, 11 Aug 2006 15:12:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-serial@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/serial/8250_pci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1783,6 +1783,7 @@ static void __devexit pciserial_remove_o
 	pci_disable_device(dev);
 }
 
+#ifdef CONFIG_PM
 static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
@@ -1812,6 +1813,7 @@ static int pciserial_resume_one(struct p
 	}
 	return 0;
 }
+#endif
 
 static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
@@ -2362,8 +2364,10 @@ static struct pci_driver serial_pci_driv
 	.name		= "serial",
 	.probe		= pciserial_init_one,
 	.remove		= __devexit_p(pciserial_remove_one),
+#ifdef CONFIG_PM
 	.suspend	= pciserial_suspend_one,
 	.resume		= pciserial_resume_one,
+#endif
 	.id_table	= serial_pci_tbl,
 };
 

