From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/5] serial: 8250_pci: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 10:55:35 +0900
Message-ID: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:61052 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758445Ab3K1Bzi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 20:55:38 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00DX9AOO0P20@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 28 Nov 2013 10:55:36 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Angelo Butti' <buttiangelo@gmail.com>, 'Ian Abbott' <abbotti@mev.co.uk>, 'Heikki Krogerus' <heikki.krogerus@linux.intel.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/8250/8250_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4697a51..7a605c6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3492,7 +3492,7 @@ static struct pciserial_board pci_boards[] = {
 	},
 };
 
-static const struct pci_device_id blacklist[] = {
+static DEFINE_PCI_DEVICE_TABLE(blacklist) = {
 	/* softmodems */
 	{ PCI_VDEVICE(AL, 0x5457), }, /* ALi Corporation M5457 AC'97 Modem */
 	{ PCI_VDEVICE(MOTOROLA, 0x3052), }, /* Motorola Si3052-based modem */
@@ -3849,7 +3849,7 @@ static int pciserial_resume_one(struct pci_dev *dev)
 }
 #endif
 
-static struct pci_device_id serial_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(serial_pci_tbl) = {
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
-- 
1.7.10.4


