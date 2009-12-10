From: "kiros" <kiros@korenix.com>
Subject: [PATCH] serial: add support for Korenix JetCard
Date: Thu, 10 Dec 2009 17:49:07 +0800
Message-ID: <81g07q$fe36t@hb2-smtpclt02.hibox.hinet.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp12.hibox.hinet.net ([210.71.187.237]:10150 "EHLO
	smtp12.hibox.hinet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbZLJKAI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Dec 2009 05:00:08 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add different model (with a different PCI ID) to support Korenix JetCard.
 
Signed-off-by: Kiros Yeh <kiros@www.korenix.com>
---

diff -uprN a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	2009-12-03 11:51:21.000000000 +0800
+++ b/drivers/serial/8250_pci.c	2009-12-10 16:01:14.000000000 +0800
@@ -3191,6 +3191,15 @@ static struct pci_device_id serial_pci_t
 		0x1208, 0x0004, 0, 0,
 		pbn_b0_4_921600 },
 
+	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
+		0x1204, 0x0004, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF2,
+		0x1208, 0x0004, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_KORENIX, PCI_DEVICE_ID_KORENIX_JETCARDF3,
+		0x1208, 0x0004, 0, 0,
+		pbn_b0_4_921600 },	
 	/*
 	 * Dell Remote Access Card 4 - Tim_T_Murphy@Dell.com
 	 */
diff -uprN a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2009-12-03 11:51:21.000000000 +0800
+++ b/include/linux/pci_ids.h	2009-12-10 16:00:40.000000000 +0800
@@ -2314,6 +2314,8 @@
 #define PCI_VENDOR_ID_KORENIX		0x1982
 #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
 #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
+#define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
+#define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
 
 #define PCI_VENDOR_ID_QMI		0x1a32


