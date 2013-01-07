From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 1/2] Fix incorrect device ID for the Commtech 422/2-PCIe.
Date: Mon,  7 Jan 2013 15:17:14 -0600
Message-ID: <1357593435-3566-1-git-send-email-matts@commtech-fastcom.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f175.google.com ([209.85.213.175]:34225 "EHLO
	mail-ye0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3AGVna (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 16:43:30 -0500
Received: by mail-ye0-f175.google.com with SMTP id q7so3133379yen.20
        for <linux-serial@vger.kernel.org>; Mon, 07 Jan 2013 13:43:29 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Matt Schulte <matts@commtech-fastcom.com>


Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 26b9dc0..18f1d79 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1301,9 +1301,9 @@ pci_wch_ch353_setup(struct serial_private *priv,
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_VENDOR_ID_ASIX		0x9710
-#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
 #define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021
+#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0022
 
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
-- 
1.7.2.5

