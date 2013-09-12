From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] serial: mfd: remove unnecessary pci_set_drvdata()
Date: Thu, 12 Sep 2013 15:31:06 +0900
Message-ID: <000d01ceaf81$a9910aa0$fcb31fe0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35460 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab3ILGbI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Sep 2013 02:31:08 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT000DAQ23R0TA0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 12 Sep 2013 15:31:07 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Feng Tang' <feng.tang@intel.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/mfd.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index d3db042..ead43dd 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1451,7 +1451,6 @@ static void serial_hsu_remove(struct pci_dev *pdev)
 		uart_remove_one_port(&serial_hsu_reg, &up->port);
 	}
 
-	pci_set_drvdata(pdev, NULL);
 	free_irq(pdev->irq, priv);
 	pci_disable_device(pdev);
 }
-- 
1.7.10.4


