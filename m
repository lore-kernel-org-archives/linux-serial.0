From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 45/75] serial: set correct baud_base for Oxford Semiconductor
	Ltd EXSYS EX-41092 Dual 16950 Serial adapter
Date: Fri, 02 Jan 2009 13:46:58 +0000
Message-ID: <20090102134655.13472.24136.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37604 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757205AbZABNqo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:44 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Niels de Vos <niels.devos@wincor-nixdorf.com>

The PCI-card identified as "Oxford Semiconductor Ltd EXSYS EX-41092 Dual
16950 Serial adapter" is only usable with other devices (i.e. not the same
card) after doing a "setserial /dev/ttyS<n> baud_base 115200".  This
baud_base should be default for this card.

Signed-off-by: Niels de Vos <niels.devos@wincor-nixdorf.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/8250_pci.c |    3 +++
 include/linux/pci_ids.h   |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 0b79413..2a2e1c7 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -2388,6 +2388,9 @@ static struct pci_device_id serial_pci_tbl[] = {
 		 * For now just used the hex ID 0x950a.
 		 */
 	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
+		PCI_SUBVENDOR_ID_SIIG, PCI_SUBDEVICE_ID_SIIG_DUAL_SERIAL, 0, 0,
+		pbn_b0_2_115200 },
+	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_2_1130000 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b6e6944..fa83dfe 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1766,6 +1766,7 @@
 #define PCI_DEVICE_ID_SIIG_8S_20x_650	0x2081
 #define PCI_DEVICE_ID_SIIG_8S_20x_850	0x2082
 #define PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL	0x2050
+#define PCI_SUBDEVICE_ID_SIIG_DUAL_SERIAL	0x2530
 
 #define PCI_VENDOR_ID_RADISYS		0x1331
 

