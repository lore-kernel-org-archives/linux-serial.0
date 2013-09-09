From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/7] serial: arc_uart: Remove casting the return value which is
 a void pointer
Date: Mon, 09 Sep 2013 14:06:45 +0900
Message-ID: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55009 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab3IIFGr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:06:47 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00KRLE78V8M0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:06:45 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Vineet Gupta' <vgupta@synopsys.com>, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/arc_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 569872f..c9f5c9d 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -533,7 +533,7 @@ arc_uart_init_one(struct platform_device *pdev, int dev_id)
 	unsigned long *plat_data;
 	struct arc_uart_port *uart = &arc_uart_ports[dev_id];
 
-	plat_data = (unsigned long *)dev_get_platdata(&pdev->dev);
+	plat_data = dev_get_platdata(&pdev->dev);
 	if (!plat_data)
 		return -ENODEV;
 
-- 
1.7.10.4


