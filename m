From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/4] Add support for '8-port RS-232 MIC-3620 from advantech'
Date: Tue, 27 Jan 2009 11:51:16 +0000
Message-ID: <20090127115111.6236.66165.stgit@localhost.localdomain>
References: <20090127114820.6236.67019.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37028 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752703AbZA0Lu5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jan 2009 06:50:57 -0500
In-Reply-To: <20090127114820.6236.67019.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

From: Michael Bramer <michael@debsupport.de>

This Patch add the device information for the
MIC-3620 8-port RS-232 cPCI card from Advantech Co. Ltd.

Signed-off-by: Michael Bramer <grisu@deb-support.de>
Signed-off-by: Alan Cox <number6@the-village.bc.nu>
---

 drivers/serial/8250_pci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 2a36712..536d8e5 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -806,6 +806,8 @@ pci_default_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_OCTPRO422	0x0208
 #define PCI_SUBDEVICE_ID_POCTAL232	0x0308
 #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
+#define PCI_VENDOR_ID_ADVANTECH		0x13fe
+#define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -2152,6 +2154,10 @@ static int pciserial_resume_one(struct pci_dev *dev)
 #endif
 
 static struct pci_device_id serial_pci_tbl[] = {
+	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
+		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
+		pbn_b2_8_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,

