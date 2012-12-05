From: Matt Schulte <matts_old@commtech-fastcom.com>
Subject: [PATCH 2/2] The correct device id for this card is 0x0022.
Date: Wed,  5 Dec 2012 14:56:22 -0600
Message-ID: <1354740983-4352-2-git-send-email-matts@commtech-fastcom.com>
References: <1354740983-4352-1-git-send-email-matts@commtech-fastcom.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63936 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2LEU7f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Dec 2012 15:59:35 -0500
Received: by mail-gh0-f174.google.com with SMTP id g15so907230ghb.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Dec 2012 12:59:34 -0800 (PST)
In-Reply-To: <1354740983-4352-1-git-send-email-matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, Matt Schulte <matts@commtech-fastcom.com>

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: b0ab02361167faa82198b783a8d555eb6f58901c 

 drivers/tty/serial/8250/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index bf2f1a0..777832c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1301,7 +1301,7 @@ pci_wch_ch353_setup(struct serial_private *priv,
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_VENDOR_ID_ASIX		0x9710
-#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
+#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0022
 #define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021
 
-- 
1.7.2.5

