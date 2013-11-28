From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/5] serial: jsm: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 10:58:39 +0900
Message-ID: <000801ceebdd$5b984a50$12c8def0$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:20994 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3K1B6l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 20:58:41 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00EO3ATRHZA0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 28 Nov 2013 10:58:40 +0900 (KST)
In-reply-to: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Thadeu Lima de Souza Cascardo' <cascardo@linux.vnet.ibm.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/jsm/jsm_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index a47d882..4e4899b 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -202,7 +202,7 @@ static void jsm_remove_one(struct pci_dev *pdev)
 	kfree(brd);
 }
 
-static struct pci_device_id jsm_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(jsm_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
-- 
1.7.10.4


