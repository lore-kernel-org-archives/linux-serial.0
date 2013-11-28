From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 5/5] serial: txx9: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 11:00:36 +0900
Message-ID: <000a01ceebdd$a13e2f70$e3ba8e50$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34574 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3K1CAt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 21:00:49 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY009H6AX2UK70@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 28 Nov 2013 11:00:38 +0900 (KST)
In-reply-to: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/serial_txx9.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 90a080b..6e5fad8 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1250,7 +1250,7 @@ static int pciserial_txx9_resume_one(struct pci_dev *dev)
 }
 #endif
 
-static const struct pci_device_id serial_txx9_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(serial_txx9_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_TC86C001_MISC) },
 	{ 0, }
 };
-- 
1.7.10.4


