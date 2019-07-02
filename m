From: jeyentam <je.yen.tam@ni.com>
Subject: [PATCH 2/2] PCI: Add NI-Serial PXI/PXIe+485 device IDs
Date: Mon, 1 Jul 2019 20:24:17 -0700
Message-ID: <20190702032417.29014-1-je.yen.tam@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jeyentam <je.yen.tam@ni.com>
List-Id: linux-serial@vger.kernel.org

Add NI PXIe-RS232, PXI-RS485 and PXIe-RS485 device IDs.

Signed-off-by: jeyentam <je.yen.tam@ni.com>
---
 include/linux/pci_ids.h | 62 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..cc1f61575eb4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1027,31 +1027,43 @@
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
 #define PCI_DEVICE_ID_SUN_CASSINI	0xabba
 
-#define PCI_VENDOR_ID_NI		0x1093
-#define PCI_DEVICE_ID_NI_PCI2322	0xd130
-#define PCI_DEVICE_ID_NI_PCI2324	0xd140
-#define PCI_DEVICE_ID_NI_PCI2328	0xd150
-#define PCI_DEVICE_ID_NI_PXI8422_2322	0xd190
-#define PCI_DEVICE_ID_NI_PXI8422_2324	0xd1a0
-#define PCI_DEVICE_ID_NI_PXI8420_2322	0xd1d0
-#define PCI_DEVICE_ID_NI_PXI8420_2324	0xd1e0
-#define PCI_DEVICE_ID_NI_PXI8420_2328	0xd1f0
-#define PCI_DEVICE_ID_NI_PXI8420_23216	0xd1f1
-#define PCI_DEVICE_ID_NI_PCI2322I	0xd250
-#define PCI_DEVICE_ID_NI_PCI2324I	0xd270
-#define PCI_DEVICE_ID_NI_PCI23216	0xd2b0
-#define PCI_DEVICE_ID_NI_PXI8430_2322	0x7080
-#define PCI_DEVICE_ID_NI_PCI8430_2322	0x70db
-#define PCI_DEVICE_ID_NI_PXI8430_2324	0x70dd
-#define PCI_DEVICE_ID_NI_PCI8430_2324	0x70df
-#define PCI_DEVICE_ID_NI_PXI8430_2328	0x70e2
-#define PCI_DEVICE_ID_NI_PCI8430_2328	0x70e4
-#define PCI_DEVICE_ID_NI_PXI8430_23216	0x70e6
-#define PCI_DEVICE_ID_NI_PCI8430_23216	0x70e7
-#define PCI_DEVICE_ID_NI_PXI8432_2322	0x70e8
-#define PCI_DEVICE_ID_NI_PCI8432_2322	0x70ea
-#define PCI_DEVICE_ID_NI_PXI8432_2324	0x70ec
-#define PCI_DEVICE_ID_NI_PCI8432_2324	0x70ee
+/* NI-Serial Device IDs */
+#define PCI_VENDOR_ID_NI		  0x1093
+/* NI PXI(e) RS-232 Devices */
+#define PCI_DEVICE_ID_NI_PCI2322	  0xd130
+#define PCI_DEVICE_ID_NI_PCI2324	  0xd140
+#define PCI_DEVICE_ID_NI_PCI2328	  0xd150
+#define PCI_DEVICE_ID_NI_PXI8422_2322	  0xd190
+#define PCI_DEVICE_ID_NI_PXI8422_2324	  0xd1a0
+#define PCI_DEVICE_ID_NI_PXI8420_2322	  0xd1d0
+#define PCI_DEVICE_ID_NI_PXI8420_2324	  0xd1e0
+#define PCI_DEVICE_ID_NI_PXI8420_2328	  0xd1f0
+#define PCI_DEVICE_ID_NI_PXI8420_23216	  0xd1f1
+#define PCI_DEVICE_ID_NI_PCI2322I	  0xd250
+#define PCI_DEVICE_ID_NI_PCI2324I	  0xd270
+#define PCI_DEVICE_ID_NI_PCI23216	  0xd2b0
+#define PCI_DEVICE_ID_NI_PXI8430_2322	  0x7080
+#define PCI_DEVICE_ID_NI_PCI8430_2322	  0x70db
+#define PCI_DEVICE_ID_NI_PXI8430_2324	  0x70dd
+#define PCI_DEVICE_ID_NI_PCI8430_2324	  0x70df
+#define PCI_DEVICE_ID_NI_PXI8430_2328	  0x70e2
+#define PCI_DEVICE_ID_NI_PCI8430_2328	  0x70e4
+#define PCI_DEVICE_ID_NI_PXI8430_23216	  0x70e6
+#define PCI_DEVICE_ID_NI_PCI8430_23216	  0x70e7
+#define PCI_DEVICE_ID_NI_PXI8432_2322	  0x70e8
+#define PCI_DEVICE_ID_NI_PCI8432_2322	  0x70ea
+#define PCI_DEVICE_ID_NI_PXI8432_2324	  0x70ec
+#define PCI_DEVICE_ID_NI_PCI8432_2324	  0x70ee
+#define PCIE_DEVICE_ID_NI_PXIE8430_2328   0x74C2
+#define PCIE_DEVICE_ID_NI_PXIE8430_23216  0x74C1
+/* NI PXI(e) RS-485 Devices */
+#define PCI_DEVICE_ID_NI_PXI8431_4852     0x7081
+#define PCI_DEVICE_ID_NI_PXI8431_4854     0x70DE
+#define PCI_DEVICE_ID_NI_PXI8431_4858     0x70E3
+#define PCI_DEVICE_ID_NI_PXI8433_4852     0x70E9
+#define PCI_DEVICE_ID_NI_PXI8433_4854     0x70ED
+#define PCIE_DEVICE_ID_NI_PXIE8431_4858   0x74C4
+#define PCIE_DEVICE_ID_NI_PXIE8431_48516  0x74C3
 
 #define PCI_VENDOR_ID_CMD		0x1095
 #define PCI_DEVICE_ID_CMD_643		0x0643
-- 
2.17.1
