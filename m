From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] serial: pch_uart: remove unnecessary pci_set_drvdata()
Date: Mon, 25 Nov 2013 11:19:41 +0900
Message-ID: <001e01cee984$ccb6ccd0$66246670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55468 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab3KYCTn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Nov 2013 21:19:43 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWS00FWMRSUK200@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 25 Nov 2013 11:19:42 +0900 (KST)
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
 drivers/tty/serial/pch_uart.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 0aa2b52..11c862c 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1853,7 +1853,6 @@ static void pch_uart_exit_port(struct eg20t_port *priv)
 		debugfs_remove(priv->debugfs);
 #endif
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
-	pci_set_drvdata(priv->pdev, NULL);
 	free_page((unsigned long)priv->rxbuf.buf);
 }
 
-- 
1.7.10.4


