From: Robert Richter <robert.richter@amd.com>
Subject: [PATCH] 8250 serial: add OXCB950 chip
Date: Wed, 10 Sep 2008 10:37:11 +0200
Message-ID: <1221035831-12660-1-git-send-email-robert.richter@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753573AbYIJIir@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@amd.com>, Robert Richter <robert.richter@amd.com>
List-Id: linux-serial@vger.kernel.org

From: Andre Przywara <andre.przywara@amd.com>

This patch adds the OXCB950 chip to the 8250 PCI driver.

----------
Chip: Oxford Semiconductor OXCB950 for PCI Cardbus interface
http://www.transdimension.com/products/serial/OXCB950.html

on this card:
ExSys EX-1370 1 port high-speed serial card for ExpressCard/34 slot
----------

Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 drivers/serial/8250_pci.c |    3 +++
 include/linux/pci_ids.h   |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index c2f2393..eec0620 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -2293,6 +2293,9 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_2_1130000 },
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_C950,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_1_921600 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_4_115200 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f1624b3..1d08fbe 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1930,6 +1930,7 @@
 #define PCI_VENDOR_ID_OXSEMI		0x1415
 #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
 #define PCI_DEVICE_ID_OXSEMI_16PCI954	0x9501
+#define PCI_DEVICE_ID_OXSEMI_C950	0x950B
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N	0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
 #define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521
-- 
1.6.0.1
