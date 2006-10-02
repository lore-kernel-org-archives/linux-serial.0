From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] serial: trivial code flow simplification
Date: Mon, 2 Oct 2006 10:57:10 -0600
Message-ID: <200610021057.11198.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:59289 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932509AbWJBQ5S (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Oct 2006 12:57:18 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Return failure immediately, so we don't have to test it twice.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm2/drivers/serial/8250_pnp.c
===================================================================
--- work-mm2.orig/drivers/serial/8250_pnp.c	2006-08-18 13:02:48.000000000 -0600
+++ work-mm2/drivers/serial/8250_pnp.c	2006-08-18 13:04:14.000000000 -0600
@@ -437,11 +437,11 @@
 	port.dev = &dev->dev;
 
 	line = serial8250_register_port(&port);
+	if (line < 0)
+		return -ENODEV;
 
-	if (line >= 0)
-		pnp_set_drvdata(dev, (void *)((long)line + 1));
-	return line >= 0 ? 0 : -ENODEV;
-
+	pnp_set_drvdata(dev, (void *)((long)line + 1));
+	return 0;
 }
 
 static void __devexit serial_pnp_remove(struct pnp_dev *dev)
