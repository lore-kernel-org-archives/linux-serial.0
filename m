From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/2] 8250: add AgeStar AS-PRS2-009
Date: Thu, 16 Aug 2012 12:01:33 +0100
Message-ID: <20120816110130.774.87642.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48647 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2HPKoO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 06:44:14 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=22502
---

 drivers/tty/serial/8250/8250_pci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 62e10fe..ad4bb8d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1194,6 +1194,8 @@ pci_xr17c154_setup(struct serial_private *priv,
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
 #define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
+#define PCI_VENDOR_ID_AGESTAR		0x5372
+#define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_VENDOR_ID_ASIX		0x9710
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
@@ -4189,6 +4191,12 @@ static struct pci_device_id serial_pci_tbl[] = {
 		pbn_omegapci },
 
 	/*
+	 * AgeStar as-prs2-009
+	 */
+	{	PCI_VENDOR_ID_AGESTAR, PCI_DEVICE_ID_AGESTAR_9375,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_b0_bt_2_115200 },
+	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */

