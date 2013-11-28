From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/5] serial: mfd: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 10:59:35 +0900
Message-ID: <000901ceebdd$7ccb6f90$76624eb0$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62019 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3K1B7g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 20:59:36 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00CKGAVBGF40@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 28 Nov 2013 10:59:35 +0900 (KST)
In-reply-to: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/mfd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index 52c930f..158d79e 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1458,7 +1458,7 @@ static void serial_hsu_remove(struct pci_dev *pdev)
 }
 
 /* First 3 are UART ports, and the 4th is the DMA */
-static const struct pci_device_id pci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(pci_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081B) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081C) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x081D) },
-- 
1.7.10.4


