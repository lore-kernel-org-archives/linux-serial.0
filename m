From: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: [PATCH 2.4] OXSEMI 16PCI952 "final" patch...
Date: Tue, 7 May 2002 17:37:59 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020507153759.GB10208@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from come.alcove-fr ([10.16.10.17])
	by smtp-out.fr.alcove.com with esmtp (Exim 3.12 #1 (Debian))
	id 17572O-0003Jb-00
	for <linux-serial@vger.kernel.org>; Tue, 07 May 2002 17:38:00 +0200
Received: from stelian by come.alcove-fr with local (Exim 3.12 #1 (Debian))
	id 17572O-0007Lf-00
	for <linux-serial@vger.kernel.org>; Tue, 07 May 2002 17:38:00 +0200
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

With the latest 1.4.19-pre changes (pci ID etc), the following patch
is the latest step in supporting the Oxford Semi 16PCI952 serial
card.

The changes are tested and seem trivial, so please forward them to 
Marcelo for inclusion in the mainline.

Thanks,

Stelian.


diff -uNr linux-2.4.18.orig/drivers/char/serial.c linux-2.4.18/drivers/char/serial.c
--- linux-2.4.18.orig/drivers/char/serial.c	Tue May  7 08:28:54 2002
+++ linux-2.4.18/drivers/char/serial.c	Tue May  7 08:30:04 2002
@@ -4259,6 +4259,7 @@
 	pbn_b0_bt_2_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_2_921600,
 
 	pbn_b1_1_115200,
 	pbn_b1_2_115200,
@@ -4337,6 +4338,7 @@
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b0_bt_2_921600 */
 
 	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
 	{ SPCI_FL_BASE1, 2, 115200 },		/* pbn_b1_2_115200 */
@@ -4672,7 +4674,7 @@
 		pbn_b0_4_115200 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
-		pbn_b0_2_115200 },
+		pbn_b0_bt_2_921600 },
 
 	/* Digitan DS560-558, from jimd@esoft.com */
 	{	PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
