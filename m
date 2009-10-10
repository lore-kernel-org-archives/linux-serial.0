From: Dick Hollenbeck <dick@softplc.com>
Subject: [PATCH] Advantech PCI 8250 serial board
Date: Sat, 10 Oct 2009 18:10:24 -0500
Message-ID: <4AD11460.8070804@softplc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040009040505080907070904"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kcmailp08.birch.net ([216.212.0.103]:62742 "EHLO mx01.birch.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753981AbZJJXLC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 10 Oct 2009 19:11:02 -0400
Received: from unknown (HELO [192.100.100.3]) ([65.16.135.194])
          (envelope-sender <dick@softplc.com>)
          by mx01.birch.net (qmail-ldap-1.03) with SMTP
          for <linux-serial@vger.kernel.org>; 10 Oct 2009 23:10:23 -0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009040505080907070904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This simply adds another PCI product id and a table entry for a 16PCI954 
two port board.
Patch made against 2.6.31.1
It works.


Signed-off-by: Dick Hollenbeck <dick@softplc.com>


--------------040009040505080907070904
Content-Type: text/x-patch;
 name="8250_pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250_pci.patch"

--- 8250_pci.c.orig	2009-10-10 18:02:26.000000000 -0500
+++ 8250_pci.c	2009-10-08 11:06:49.000000000 -0500
@@ -981,6 +981,7 @@ static int skip_tx_en_setup(struct seria
 #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
+#define PCI_DEVICE_ID_ADVANTECH_PCI3610	0x3610
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -2525,6 +2526,10 @@ static int pciserial_resume_one(struct p
 #endif
 
 static struct pci_device_id serial_pci_tbl[] = {
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3610,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_921600 },
+
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,

--------------040009040505080907070904--
