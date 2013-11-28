From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/5] serial: icom: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 10:57:04 +0900
Message-ID: <000701ceebdd$22bdb1c0$68391540$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:61416 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3K1B5F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 20:57:05 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00C8LAR4GF40@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 28 Nov 2013 10:57:04 +0900 (KST)
In-reply-to: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/icom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index d98e433..0126ba9 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -66,7 +66,7 @@
 #define ICOM_PORT ((struct icom_port *)port)
 #define to_icom_adapter(d) container_of(d, struct icom_adapter, kref)
 
-static const struct pci_device_id icom_pci_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(icom_pci_table) = {
 	{
 		.vendor = PCI_VENDOR_ID_IBM,
 		.device = PCI_DEVICE_ID_IBM_ICOM_DEV_ID_1,
-- 
1.7.10.4


