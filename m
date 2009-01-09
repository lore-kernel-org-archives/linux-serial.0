From: akpm@linux-foundation.org
Subject: [patch 3/3] 8250_pci: add support for netmos 9835
Date: Fri, 09 Jan 2009 14:17:43 -0800
Message-ID: <200901092217.n09MHhUE021228@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51766 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759593AbZAIWSX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Jan 2009 17:18:23 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, jirislaby@gmail.com

From: Jiri Slaby <jirislaby@gmail.com>

Most of netmos 9835 hardware is handled by parport-serial.  IBM introduces
a device which doesn't have any parallel ports and have screwed subdevice
PCI id (not corresponding to port numbers).

Handle this device (9710:9835 1014:0299) properly.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/8250_pci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/serial/8250_pci.c~8250_pci-add-support-for-netmos-9835 drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c~8250_pci-add-support-for-netmos-9835
+++ a/drivers/serial/8250_pci.c
@@ -600,6 +600,10 @@ static int pci_netmos_init(struct pci_de
 	/* subdevice 0x00PS means <P> parallel, <S> serial */
 	unsigned int num_serial = dev->subsystem_device & 0xf;
 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
+			dev->subsystem_device == 0x0299)
+		return 0;
+
 	if (num_serial == 0)
 		return -ENODEV;
 	return num_serial;
@@ -3094,6 +3098,10 @@ static struct pci_device_id serial_pci_t
 		0,
 		pbn_b0_8_115200 },
 
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+		PCI_VENDOR_ID_IBM, 0x0299,
+		0, 0, pbn_b0_bt_2_115200 },
+
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
_
