From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 2/2 #2] 8250_pci: add support for netmos 9835
Date: Mon,  8 Dec 2008 16:24:33 +0100
Message-ID: <1228749873-21823-1-git-send-email-jirislaby@gmail.com>
References: <1228749555-21363-2-git-send-email-jirislaby@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:50785 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYLHPZI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Dec 2008 10:25:08 -0500
In-Reply-To: <1228749555-21363-2-git-send-email-jirislaby@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

Most of netmos 9835 hardware is handled by parport-serial.
IBM introduces a device which doesn't have any parallel ports and
have screwed subdevice PCI id (not corresponding to port numbers).

Handle this device (9710:9835 1014:0299) properly.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/serial/8250_pci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 1948c81..766cfac 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -600,6 +600,10 @@ static int pci_netmos_init(struct pci_dev *dev)
 	/* subdevice 0x00PS means <P> parallel, <S> serial */
 	unsigned int num_serial = dev->subsystem_device & 0xf;
 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
+			dev->subsystem_device == 0x0299)
+		return 0;
+
 	if (num_serial == 0)
 		return -ENODEV;
 	return num_serial;
@@ -3091,6 +3095,10 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0,
 		pbn_b0_8_115200 },
 
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+		PCI_VENDOR_ID_IBM, 0x0299,
+		0, 0, pbn_b0_bt_2_115200 },
+
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
-- 
1.6.0.5

