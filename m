From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 75/75] serial_8250: support for Sealevel Systems Model 7803
	COMM+8
Date: Fri, 02 Jan 2009 13:50:43 +0000
Message-ID: <20090102135042.13472.97375.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50536 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526AbZABNu2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:50:28 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Flavio Leitner <fleitner@redhat.com>

Add support for Sealevel Systems Model 7803 COMM+8

Signed-off-by: Flavio Leitner <fleitner@redhat.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/8250_pci.c |    3 +++
 include/linux/pci_ids.h   |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 2a2e1c7..c088146 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -2287,6 +2287,9 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM8,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_8_115200 },
+	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_7803,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_8_460800 },
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM8,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_8_115200 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index fa83dfe..218c73b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1796,6 +1796,7 @@
 #define PCI_DEVICE_ID_SEALEVEL_UCOMM232	0x7202
 #define PCI_DEVICE_ID_SEALEVEL_COMM4	0x7401
 #define PCI_DEVICE_ID_SEALEVEL_COMM8	0x7801
+#define PCI_DEVICE_ID_SEALEVEL_7803	0x7803
 #define PCI_DEVICE_ID_SEALEVEL_UCOMM8	0x7804
 
 #define PCI_VENDOR_ID_HYPERCOPE		0x1365

