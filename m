From: Adam Lee <adam.lee@canonical.com>
Subject: [PATCH 1/2] pci_ids: Add Pericom vendor and device ids
Date: Mon,  3 Aug 2015 12:33:20 +0800
Message-ID: <1438576401-24921-1-git-send-email-adam.lee@canonical.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

This patch add Pericom's vendor id and Pericom PI7C9X795[1248] chips'
device ids.

Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 include/linux/pci_ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index fcff8f8..c4a93cf 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2995,4 +2995,10 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_PERICOM			0x12D8
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7951	0x7951
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7952	0x7952
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.5.0
