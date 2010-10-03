From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] add support for Kouwell KW-L221N-2
Date: Sun, 3 Oct 2010 13:23:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.1010031321130.14702@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199Ab0JCRXV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Oct 2010 13:23:21 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o93HNKe6001590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-serial@vger.kernel.org>; Sun, 3 Oct 2010 13:23:21 -0400
Received: from hs20-bc2-1.build.redhat.com (hs20-bc2-1.build.redhat.com [10.10.28.34])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o93HNJKW028847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Sun, 3 Oct 2010 13:23:20 -0400
Received: from hs20-bc2-1.build.redhat.com (localhost.localdomain [127.0.0.1])
	by hs20-bc2-1.build.redhat.com (8.13.1/8.13.1) with ESMTP id o93HNJe6014737
	for <linux-serial@vger.kernel.org>; Sun, 3 Oct 2010 13:23:19 -0400
Received: from localhost (mpatocka@localhost)
	by hs20-bc2-1.build.redhat.com (8.13.1/8.13.1/Submit) with ESMTP id o93HNHBn014731
	for <linux-serial@vger.kernel.org>; Sun, 3 Oct 2010 13:23:19 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Add support for Kouwell KW-L221N-2 card.

The card was supported with the generic rule that got number of ports and 
UART clock speed wrong.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/serial/8250_pci.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.36-rc6-fast/drivers/serial/8250_pci.c
===================================================================
--- linux-2.6.36-rc6-fast.orig/drivers/serial/8250_pci.c	2010-10-03 16:49:20.000000000 +0200
+++ linux-2.6.36-rc6-fast/drivers/serial/8250_pci.c	2010-10-03 19:11:52.000000000 +0200
@@ -2863,6 +2863,9 @@ static struct pci_device_id serial_pci_t
 		PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL,
 		0, 0,
 		pbn_b0_4_1152000 },
+	{	PCI_VENDOR_ID_OXSEMI, 0x9505,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_2_921600 },
 
 		/*
 		 * The below card is a little controversial since it is the
