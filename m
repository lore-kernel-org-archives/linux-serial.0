From: matts_old@commtech-fastcom.com
Subject: [PATCHv2 2/2] tty/8250: The correct device id for this card is 0x0022
Date: Thu,  6 Dec 2012 22:19:59 -0600
Message-ID: <1354853999-6789-2-git-send-email-matts@commtech-fastcom.com>
References: <1354853999-6789-1-git-send-email-matts@commtech-fastcom.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:33414 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab2LGEWs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 23:22:48 -0500
Received: by mail-ye0-f174.google.com with SMTP id m6so16016yen.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Dec 2012 20:22:47 -0800 (PST)
In-Reply-To: <1354853999-6789-1-git-send-email-matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, Matt Schulte <matts@commtech-fastcom.com>

From: Matt Schulte <matts@commtech-fastcom.com>

The correct device id for this card is 0x0022

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c

v2: Reorder define in patch 2 as requested by Alan

 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index bf2f1a0..8a2c3d9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1301,9 +1301,9 @@ pci_wch_ch353_setup(struct serial_private *priv,
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_VENDOR_ID_ASIX		0x9710
-#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
 #define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021
+#define PCI_DEVICE_ID_COMMTECH_4222PCIE	0x0022
 
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
-- 
1.7.2.5

