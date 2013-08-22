From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] TTY: amiserial, remove unnecessary platform_set_drvdata()
Date: Thu, 22 Aug 2013 11:08:04 +0900
Message-ID: <002001ce9edc$6feb5310$4fc1f930$%han@samsung.com>
References: <001f01ce9edc$421b1d30$c6515790$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11964 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3HVCIF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Aug 2013 22:08:05 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRW007OATX6AWD0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 22 Aug 2013 11:08:05 +0900 (KST)
In-reply-to: <001f01ce9edc$421b1d30$c6515790$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/amiserial.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 083710e..2b86f8e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1785,8 +1785,6 @@ static int __exit amiga_serial_remove(struct platform_device *pdev)
 	free_irq(IRQ_AMIGA_TBE, state);
 	free_irq(IRQ_AMIGA_RBF, state);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return error;
 }
 
-- 
1.7.10.4


